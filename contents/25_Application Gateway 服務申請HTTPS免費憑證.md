上一篇有提到 Let's Encrypt 的執行要素，如果開發的網站是建立在 Linux 或 Windows 伺服器的話，就可以依照要求在指定的路徑中加入指定的檔案名稱並建立對應的內容，這樣 Let's Encrypt 就可以抓到資訊，並生成憑證給你。但是建立在Azure 上的服務，像是 App Service 或是 Kubernetes Service 要怎麼做呢?第一種是建立對應的檔案後更新，但這會需要花一些時間，若這些服務有使用Application Gateway 掛在最外層的話，可以參考今天介紹的，整合 Blob Storage 的方式 ！

在前面有稍微介紹到storage的功能，他是Azure 提供的類似雲端硬碟的服務，建立的檔案在權限足夠的情形下，也可以透過指定的路徑檢視。在前篇也有提到 Rule 中除了設定目標到Backend pool 及外部網路外，也可以建立 `path-based rule` 設定單一條件路徑下的重新導向功能，讓要求路徑為`.well-known/acme-challenge/`底下的頁面，重新導向到 Blob storage 中。







---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)