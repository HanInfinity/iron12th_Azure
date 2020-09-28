# 甚麼是Kubernetes?

在docker開始盛行之後，以容器的型態建置應用程式及服務也越來越廣泛。Kubernetes的出現讓容器更好管理、調整，讓大規模的部署與管理變得更加容易。在希臘文中，這Kubernetes表示船舵手或領航員，有時稱為 `k8s` 或 `k-eights`。

# 建立Azure Kubernetes Service

在Azure中亦有提供Kubernetes (Azure Kubernetes Service，簡稱AKS) 服務，在列表中按一下`Add`並完成設定後，按一下`Review + create`後，再按一下`Create`等待建置完成。

> 若建置失敗的話，可以將Node count改成2試試。

![image-20200928224120736](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200928224120736.png)

透過az cli連線至AKS service，若電腦沒有安裝的話，可以使用Azure提供的Azure Cloud Shell ，選擇Bash並按下Create。

![image-20200928224549639](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200928224549639.png)

登入後就可以直接使用`kubectl`指令了

![image-20200928224721199](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200928224721199.png)

使用以下指令進行連線，其中`myResourceGroup`為resource group名稱，`myAKSCluster`為AKS名稱。

```bash
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
```

![image-20200928224941039](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200928224941039.png)

接著你會看到context已將剛剛的連線資訊加進去config裡面。再輸入下面指令，就會看到剛剛設定的連線資訊出現在下方。

```bash
kubectl config get-contexts
```

回傳的連線資訊長這樣，前面有`*`的表示現在使用的是這個AKS。

```bash
CURRENT   NAME         CLUSTER      AUTHINFO                        NAMESPACE
*         tatamo-k8s   tatamo-k8s   clusterUser_Tatamo_tatamo-k8s
```

# 結論

今天主要介紹Azure Kubernetes Service，並說明建立方式及利用Azure Cloud Shell連線，下一篇將繼續部署的說明，將應用服務部署到AKS中。



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)