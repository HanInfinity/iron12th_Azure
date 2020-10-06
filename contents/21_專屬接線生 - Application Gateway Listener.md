# 說明

本篇將介紹 Application Gateway 項目中的 Frontend IP 及 Listener 。在Application Gateway 中，這兩個算是最先接觸到流量的。每一個 Application Gateway 都至少會有一個 Frontend IP，外部連線才能夠找到Application Gateway。而每一個 Application Gateway 可以有無數個 Listener 在裡面，而且都是獨立的存在，不能有任務重複。以下來介紹Frontend IP 及 Listener 建置時要注意的項目。

# Frontend IP

分為 Public IP 及 Private IP，提供外部流量傳送的 IP 位址，可設定Azure domain name 及自訂 domain name。

# Listener

本篇的重點。主要設定的項目如下：

下圖為預設所使用的設定，為HTTP及Basic type。但一般網站不可能只有HTTP，且所有流量都指向同一個IP，除了設定port 以外，Listener也很無法區分流量，當所有網站都要用預設的80甚至是443 port時，沒有其他設定就會讓Application Gateway 顯得浪費了，因為一個 Application Gateway 只能給一個網站使用。下面會繼續介紹設定多個站的方式。

![image-20201006225116472](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201006225116472.png)

將Protocol 設定為HTTPS後，下面的設定也會更著變動。可以看到port已經自動改成443，且增加了憑證上傳的項目。這邊憑證上傳需使用 `.pfx` 格式，可以直接上傳或是選擇Key Vault 建立的憑證。

![image-20201006225537521](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201006225537521.png)

當設定` Listener type `為 `Muti site`，此時可以設定網站要使用的domain name，假設我設定的是`tatamo.ddns.net`，並且知道Frontend IP 為 123.1.2.3 時，我可以在設定domain name 的地方，例如購買網域的平台、no-ip、或是Azure DNS Zone等，將此domain name 設定指向 123.1.2.3 ，此時若有瀏覽器連線 http://tatamo.ddns.net 時就會導向 Application Gateway，只有 tatamo-listener 符合條件，將流量導向後面關聯到 tatamo-listener 的 rule，Rule的介紹將於下篇繼續說明。

![image-20201006225844475](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201006225844475.png)



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)