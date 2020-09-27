

今天將介紹使用上傳至GitHub平台的Django程式部署到App Service的流程。直接使用App Service 的 deployment center 進行部署。



首先進入要部署的App Service中，並按一下Deployment Center，此時會看到畫面中間的GitHub 方塊。因為我還沒驗證過，會顯示Not Authorized，按一下GitHub的方塊，再按底下的Authorize來完成與GitHub連接吧!!



![image-20200926230511092](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200926230511092.png)



完成驗證後，會看到自己的GitHub帳號出現在右下角，按一下Continue繼續後面的部署作業。

![image-20200926230638337](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200926230638337.png)



第2階段會要你選擇建立的方式，左邊的選項為App Service的建置服務，這邊不需要另外設定額外資訊。中間是使用GitHub Actions，此方式會在檔案中新增一個YAML來設定部署相關資訊。最右邊的是Azure Piplines，目前還是perview版本。這邊我先選最左邊的App Service建置服務，選完後按一下Continue接續下一步設定。

![image-20200926230953500](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200926230953500.png)



接下來會要你選擇部署的Repository及branch，選擇好了之後按一下Continue繼續下一個步驟。

![image-20200926231430212](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200926231430212.png)



最後會看到要部署的資訊，確認無誤後按Finish，等待部署完成。

![image-20200926231621739](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200926231621739.png)



接下來可以在Deployment Center中看到部署的狀況，當設定的分支有新進度的話，Deployment Center也會重新部署一次。

![image-20200927162247674](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927162247674.png)

想要看成果直接點左上方的Browse，然後就可以在跳出的視窗中看到部署的網站成果!

![image-20200927162533806](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200927162533806.png)



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)