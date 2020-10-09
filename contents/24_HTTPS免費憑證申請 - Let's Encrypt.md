# 說明

在操作整個Application Gateway的建立流程前，先了解HTTPS免費憑證申請的流程及Azure整合的設定後，便可以在建立Application Gateway時同時完成申請免費憑證所需的設定，因此本篇將先介紹HTTPS 免費憑證 Let’s Encrypt ，並實際操作申請流程。

# 甚麼是Let's Encrypt ?

> Let’s Encrypt 是免費、自動化和開放的憑證頒發機構
>
> -- https://letsencrypt.org/zh-tw/

以前我知道的HTTPS憑證申請，都是需要跟政府或憑證單位付費申請，直到成為真正的RD，才知道已經有這樣一個免費頒發機構讓我們可以申請憑證。有了Let’s Encrypt，我們便可以直接申請免費的憑證，而且不需要經過繁雜的申請手續及等待時間，只要經確認網站可以連上，且申請者具有更新網站的權限，就可以取得免費的憑證。其工作原理可以參考[官方文件](https://letsencrypt.org/zh-tw/how-it-works/)。

Let's Encrypt 的驗證流程中，會先連線到執行時提供的網域名稱，確認能否正常連線，接著會要求執行的人在他指定的路徑中建立指定的內容 (路徑都會是在 `.well-known/acme-challenge/` 底下)，然後他去驗證之後確認可以讀取到指定的內容，便會提供憑證資料。

# Let's Encrypt 申請步驟

在網站建置完成，並串接Domain Name之後，可以利用 Let’s Encrypt 申請免費憑證，以建置HTTPS連線。申請可使用python 套件 certbot 執行，首先安裝 certbot 套件。

```bash
pip install certbot
```

安裝後替換下方指令`<yourmail>`、`<yourdomain>`為申請的電子郵件及網域名稱並執行：

```bash
certbot certonly --email <yourmail> -d <yourdomain> --agree-tos --manual
```

接下來跟著指引做應該就可以了(問甚麼都按Y)，其中要注意的是他要求建立的驗證檔案。以下圖來說的話，就是要你在網站的`/.well-known/acme-challenge`路徑下新增名為`ttNWJx6LpqD5UTwlq1adIvVyGHAslURsMLSdgokgQTk`的檔案，檔案裡面包含`ttNWJx6LpqD5UTwlq1adIvVyGHAslURsMLSdgokgQTk.efZe0gfsV3GSEWy0LNq-3YaZKnF2Od_rncHzopt7Xr0`字串。

![image-20201009204635345](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201009204635345.png)

成功後就可以在`C:\\Certbot\\live`中找到相關檔案：

```bash
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---l      2020/1/30  下午 02:27              0 cert.pem
-a---l      2020/1/30  下午 02:27              0 chain.pem
-a---l      2020/1/30  下午 02:27              0 fullchain.pem
-a---l      2020/1/30  下午 02:27              0 privkey.pem
-a----      2020/1/30  下午 02:27            706 README
```

接著就可以將生成的相關檔案生成伺服器需要的檔案類型，完成HTTPS設定。



# 總結

本篇介紹 Let's Encrypt 及申請免費 HTTPS 憑證。下篇將說明如何以 Application Gateway 鏈結的網站，申請免費 HTTPS 憑證的設定方式。

---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)