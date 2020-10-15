# 說明

有時候網站需要建立會員資料庫，並設定登入驗證、授權等等，若這些事情交給Azure服務，或許在某些情況來說會方便許多，本篇將介紹網站與 Activate Directory 整合的方式。

# App registrations

Activate Directory 已經提供許多與網站或服務整合的功能，本系列接下來將延續第2天的文章，介紹網站透過 Activate Directory 登入，以及使用Azure 提供 API 的操作。

在使用前須先將網站服務註冊到 Activate Directory 中。首先進到 Activate Directory 中，按一下 App registrations並選擇其中一個App registration，或是直接建立一個新的。

![image-20201013144359254](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201013144359254.png)

建立時除了輸入名稱外，還需要選擇該App registration開放哪些類型的帳戶登入使用。也就是說當網站建立好，並提供微軟帳號登入時，開放的帳號類型有哪些。如下圖4個選項中，主要有三種類型的帳戶分類，分別為：

- 此Tenant中的帳戶，可以在User中查看
- 任何Activate Directory 的帳戶
- 個人帳戶(包含Skype、Xbox等)

![image-20201013144834610](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201013144834610.png)

設定完後便可以檢視建立的資訊。這些資訊在後面的一些驗證設定都會需要用到。

![image-20201013145154859](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201013145154859.png)



# 總結

本篇簡單介紹了 Activate Directory 的建立及帳戶類型。後續將說明使用MSAL、Django-social-auth介紹與 Activate Directory 整合SSO的方式。

---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)