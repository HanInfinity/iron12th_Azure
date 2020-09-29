AKS的設定方有很多，你可以透過az cli傳送指令，也可以透過pipline建立佈署流程。今天主要講的是透過az cli從ACR將應用程式佈署到AKS上。



# 佈署至AKS

按照上一篇文章完成連線後，接下來要將ACR上的Image佈署到AKS上了！

## 設定文件
首先準備好部署的文件，文件是YAML檔，裡面主要是設定佈署的資訊，包含建立哪些服務、images從哪裡來、環境參數、部署後使用的port、是否有設定外部IP等項目，檔案可以有一個以上，可以個別放置基本資訊、機敏資料、其他服務等。設定完之後提供給AKS，AKS就會根據這份（些）文件將服務通通建起來。

今天會將第12天放到ACR上的pgadmin image佈署到AKS中，先來設定YAML檔。我命名為pgadmin.yaml:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tatamo-pgadmin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tatamo-pgadmin
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5 
  template:
    metadata:
      labels:
        app: tatamo-pgadmin
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: tatamo-pgadmin
        image: tatamo.azurecr.io/pgadmin:latest
        ports:
        - containerPort: 80
        env:
          - name: PGADMIN_DEFAULT_EMAIL
            value: email
          - name: PGADMIN_DEFAULT_PASSWORD
            value: password
        resources:
          requests:
            cpu: 250m
          limits:
            cpu: 500m
---
apiVersion: v1
kind: Service
metadata:
  name: tatamo-pgadmin
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: tatamo-pgadmin
```

## 建立namespace

若AKS中會建立許多服務的話，namespace可以輕鬆分辨服務歸屬，例如專案。同樣專案的服務放在同一個namespace的話，要移除只要刪除namespace即可。以下為建立namespace `pgadmin`的指令：

```bash
kubectl create namespace pgadmin
```

再執行下面指令後，就會看到剛剛建立的namespace出現在列表中。

```bash
kubectl get namespace
```

![image-20200929211652777](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200929211652777.png)



## 上傳YAML文件

將剛剛設定的`pgadmin.yaml`上傳到namespace `pgadmin`中:

```bash
kubectl apply -n pgadmin -f pgadmin.yaml
```

上傳之後AKS就會開始建置環境

## 查看pod資訊

那樣怎麼看環境建置的狀況呢？以下指令可以查看namespace pgadmin 中的pod狀況

```bash
kubectl get pods --namespace pgadmin
```

此時看到STATUS顯示為Running，表示服務正常啟動了。

```
NAME                              READY   STATUS    RESTARTS   AGE
tatamo-pgadmin-76cf67c857-68vn6   1/1     Running   0          7h54m
```

想要看全部的pod資訊怎麼辦？？

```bash
kubectl get pods
```

## 查看service 資訊

因為我在pgadmin.yaml中有設定LoadBalancer，建置完成的服務將提供外部IP，使用以下指令查看namespace pgadmin 中的service狀況：

```bash
kubectl get services --namespace pgadmin
```

此時收到回傳的資訊，其中`EXTERNAL-IP`我有修改過：

```
NAME             TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
tatamo-pgadmin   LoadBalancer   10.0.93.121   00.11.22.33   80:31677/TCP   8h
```

想要看全部的service資訊怎麼辦？？

```bash
kubectl get services
```

複製回傳的EXTERNAL-IP，就可以看到pgadmin成功啟動啦！！！

![image-20200929215929634](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200929215929634.png)

不過像我這樣直接建立pgadmin還有CSRF的問題，需要再看是否有方法可以處理，如果是建立自己開發的服務，就不會有這樣的困擾囉～

## 連不上ACR

當執檢視pod狀態發現`ImagePullBackOff`時，很有可能是AKS無法從ACR中抓出image，此時需要輸入指令使AKS與ACR接上。

![image-20200929133131210](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200929133131210.png)

輸入以下指令，其中`myAKSCluster` 為AKS名稱、`myResourceGroup`為resource group 名稱，而 `<acr-name>`為ACR名稱。`<acr-name>`也可以改用`<acr-resource-id>`替代。

```bash
az aks update -n myAKSCluster -g myResourceGroup --attach-acr <acr-name>
```

看到以下訊息表示成功接上

![image-20200929133813134](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200929133813134.png)



若要移除與ACR的對接，也可以透過指令完成。

```bash
az aks update -n myAKSCluster -g myResourceGroup --detach-acr <acr-name>
```



# 結論

今天已成功將ACR中的pgadmin image佈署到AKS上，並且成功透過網頁存取！


---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)