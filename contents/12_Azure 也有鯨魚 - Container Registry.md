# 簡介

Azure Container Registry (ACR) 是受控的私人 Docker 登錄服務，架構於開放原始碼的 Docker Registry 2.0。 建立及維護 Azure 容器登錄庫，以儲存和管理您的私人 Docker 容器映像和相關成品。

所以ACR 可以說是私人的Docker Hub，讓我們可以在ACR中存放公司或是個人專屬的Continer，再透過其他服務如下一片要說明的Azure Kubernetes Service來建立服務，也可以pull到電腦中建立統一的開發環境。

建立所需要的資訊很簡單，resource group、registry name、location及SKU。其中SKU包含Basic、Standard及Premium這三種，越高功能越多，服務越好，預設為Standard。完成填寫後一樣按一下Review + create然後再按Create等待ACR建立完成。

![image-20200927164101069](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927164101069.png)

建置完成後可以看到列表中已經出現剛剛建立的服務，點進去看一下內容。

![image-20200927164759427](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927164759427.png)

這邊會告訴你ACR的容量使用狀態，剛建立時有100G的容量可以使用。

![image-20200927164925950](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927164925950.png)

在Quick start中已經提供詳細的操作流程，接下來將參考操作流程實際執行一次看看。

![image-20200927174354513](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927174354513.png)

因為我的電腦裡面已經有pgadmin的image，所以我直接上傳pgadmin的image。在設定前，由於建立的ACR沒有註冊AAD應用程式，可以啟用admin帳號來測試。記住 Username 及 password，稍後會用到。

![image-20200927214557334](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927214557334.png)

首先用docker登入我的ACR。填入剛剛記下的帳號密碼，成功顯示畫面如下：

```bash
 docker login tatamo.azurecr.io
```

![image-20200927215216282](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927215216282.png)

接著將原本已有的pgadmin image加上ACR的tag

```bash
docker tag dpage/pgadmin4 tatamo.azurecr.io/pgadmin
```

接著再將image push 到ACR上

```bash
docker push tatamo.azurecr.io/pgadmin
```

![image-20200927215538006](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927215538006.png)

![image-20200927215926575](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927215926575.png)

此時可以在其他電腦將image pull下來，直接使用!!



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)