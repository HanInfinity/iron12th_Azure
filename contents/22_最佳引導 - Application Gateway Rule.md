# 說明

上一篇介紹了Frontend IP 及 Listener這2個流量進來時最先接觸到的物件，在Listener接收到流量後，就會將流量轉給Rule身上。本篇將說明Rule的特性及建立要領。

# Rule

Rule的功能主要是作為串接Listener及Backend的橋樑，因此在建立時需要設定流量來源的Listener、導向目標的Backend，並可設定其他重新導向的條件。建立時要設定Listener 及 Backend，如下為選擇Listener的介面。

![image-20201007221844835](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201007221844835.png)

選擇完Listener後，進入Backend target項目繼續設定。裡面可選擇Target type，可設定導向到backend pool，或是設定重新導向到其他網址。

![image-20201007222536269](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201007222536269.png)

重新導向的設定包含導向的類型、目標(Listener 或其他網址)。

![image-20201007222831826](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201007222831826.png)

在rule中可以設定多種重新導向的規則。在畫面下方按一下 `Add multiple targets to create a path-based rule`建立新的導向規則。

![image-20201007223038490](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201007223038490.png)

這邊可以設定特定路徑時觸發重新導向的規則，一樣可以選擇Backend pool 或其他網址。若設定path 為`/report/*`，當連線網址為`tatamo.ddns.net/report/123`，就會重新導向到目標網址中`/123`的路徑，因此可以設定多種不同的重新導向條件，讓多功能的服務網站整合更加多元。

![image-20201007223500917](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201007223500917.png)

# HTTP 設定

HTTP設定也在rule中，直接設定新的或選擇已建立的即可。因為HTTP設定為連線到Backend pool，所以連線透過HTTP或HTTPS、使用的port都要依照Backend pool 連線的server接受的條件進行設定。

# 總結

本篇說明Rule的建立，其中包含HTTP設定。在流量到Rule這邊時，會先判斷路徑中是否有符合任一`path-based rule`，若有的話直接導向過去，判斷均無符合條件，才會將導向規則引導流量到設定的backend pool，或是重新導向到其他網址、Listener。下一篇將繼續說明流量終點站之一，Backend。



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)