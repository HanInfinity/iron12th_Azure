

# 說明

在[Azure 官方文件](https://docs.microsoft.com/zh-tw/azure/application-gateway/overview)中提及：

Azure Application Gateway (AAG, Azure 應用程式閘道) 是網路流量負載平衡器，可讓您管理 Web 應用程式的流量。 傳統負載平衡器會在傳輸層 (OSI 層 4 - TCP 和 UDP) 上運作，並根據來源 IP 位址和連接埠，將流量路由傳送到目的地 IP 位址和連接埠。

應用程式閘道可讓您根據 HTTP 要求的其他屬性 (例如 URI 路徑或主機標頭) 進行路由決策。 例如，您可以根據傳入 URL 路由傳送流量。 因此，如果 /images 在傳入的 URL 中，您可以將流量路由傳送至一組針對影像設定的特定伺服器 (也稱為集區)。 如果 /video 在此 URL 中，該流量就會路由至另一個針對影片最佳化的集區。

![AAG 示意圖](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadc917ba79483543b88550f4ceb1d8b78c.png)

在AAG中，主要有5大項目需設定，說明如下圖及說明：

![AAG中各項功能配置說明圖](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload866d9de1b8214e6f9d630c651fcce9c4.png)

- 前端IP
  - AAG的IP位址，可設定公用與私人兩種IP，這邊會使用公用IP
  - 公用IP可設定domain name
- 接聽程式
  - 接聽透過前端IP接收到的流量
  - 可設定HTTP或HTTPS
  - 連接埠不能重複
  - 可設定多站台，以掛多個網站至同一個AAG
- 路由規則
  - 接收接聽程式的流量，依設定條件將流量引導至對應的後端集區
- HTTP設定
  - 設定與後端集區的連線方式
- 後端集區
  - 最後連線目標
  - 可設定不含目標的後端集區，提供重新導向功能。

# 總結

當網站掛在Application Gateway的後端集區，並完成所有設定後，接聽程式便會開始他的工作。一但接聽程式接收到符合條件的流量(IP、port、或是domain name等)，便會將此流量導入關聯的路由規則，路由規則會再根據流量需求的網址，透過HTTP設定導入到後端集區，存取到提供的網站，網頁上才會看到整個網站的內容。所以使用者要讀取此網站，會經過Application Gateway的層層把關，提高網站的安全性。

本篇簡易說明Application Gateway，並介紹Application Gateway中主要的五項設定。下篇開始將逐一介紹前端IP、接聽程式、路由規則、HTTP設定、後端集區的建立與設定要領，後續會再提到使用HTTPS及自動更新憑證的部分。



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)