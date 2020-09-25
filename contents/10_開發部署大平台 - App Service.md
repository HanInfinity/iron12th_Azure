# 簡介
官網App Service 介紹：以您想要的方式快速建置、部署及調整 Web 應用程式和 API。在容器中使用或是在 Windows 或 Linux 上執行 .NET、.NET Core、Node.js、Java、Python 或 PHP。使用受信任且完全受控的平台，每天處理超過 400 億筆要求，從而達到嚴格的企業級效能、安全性與合規性需求。

# 建立App Service

首先進入App Service頁面建立新的App Service。這邊我預計要部署Django的網站，所以runtime選擇的是Python，方案選擇的是Basic B1 ，是Dev/Test方案類別中，比F1( Free )稍微多一些功能的。需要花費，不過一個月試用很快就到了，不花白不花XDD。完成後按一下 `Review + create`後再按一下`Create`，等待服務建置完成。

![image-20200925224113369](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200925224113369.png)

# 部署應用程式

App Service提供的部署應用程式方式有很多種，包含az指令、Deployment Center等方式。而Deployment Center中又包含從Azure Repos(from DevOps), GitHub, Bitbucket, Local Git 及 FTP等方式。點選任何一項服務，將會進行CI/CD部署，把程式碼部署到App Service中，下一篇將介紹透過GitHub方式部署網站。

![image-20200925230119710](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200925230119710.png)

# 調整方案

如果對方案不滿意，或是想要調整App Service的方案（效能），可以到Scale Up去設定。除了Dev/Test，還有Production及Isolated等類型可以選擇。

![image-20200925231303772](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200925231303772.png)



# 結論

今天主要介紹透過入口網站建立App Service的方式，及部署的管道簡述、如何調整方案。另外還有自訂網域名稱、備份、TSL/SSL設定等功能，都可以在App Service中直接設定。下一篇將介紹透過GitHub將網站部署到App Service的流程。

---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)

