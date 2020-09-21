Resource group 提供管理Azure資源的服務，你可以讓所有同樣專案的服務放在同一個resource group 中，這樣除了較容易檢視管理以外，在之後自動化設定或是部屬資源時，比較不會因為名稱錯誤而找不到對應的資源去進行。

今天這一篇主要簡單說明如何建立resource group，以便後續建立新的資源或服務的時候可以選擇。

# 建立resource group

進入 resource group 列表後，按一下 create resource group ，網頁便跳轉到建立的頁面。

![image-20200918170300287](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200918170300287.png)

選擇 訂用帳戶(subscription)、定義名稱(Resource group)、並選擇資源所在位置(Region)。然後直接按`Review + create`，然後再按`create`就完成囉!!

![image-20200918171801999](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200918171801999.png)

接著就可以在 resource group 列表中看到剛剛建立的 `Tatamo`，接下來要建立新的服務或資源，就可以選擇`Tatamo`囉!

![image-20200918171826364](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200918171826364.png)

進入Tatamo後的畫面如下，畫面下方的地方顯示在這個 resource group 中的資源或服務，因為現在還沒有，就會是空的。

![image-20200918172622804](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200918172622804.png)

---
★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)