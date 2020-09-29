AKS的設定方有很多，你可以透過az cli傳送指令，也可以透過pipline建立佈署流程。今天主要講的是透過az cli從ACR將應用程式佈署到AKS上。





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






---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)