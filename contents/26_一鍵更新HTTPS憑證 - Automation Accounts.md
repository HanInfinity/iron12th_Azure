# 說明

在前篇介紹建立可提供 Let’s Encrypt 申請憑證的 Application Gateway 服務。但憑證如果到期的話，還要在時間到期前，重新申請憑證，實在太花費心力了。要是有自動幫你重新申請憑證的服務，那不是更方便嗎?剛好Azure 上就有這樣一個服務可以使用，就是在這一篇介紹過的 Automation Accounts。本篇將介紹如何使用 Automation Accounts 來建立一鍵更新 HTTPS 憑證的方法，步驟分為更新Modules 與建立 Runbook。。

# 更新Modules

進入新建立的 Automation Account 後，再進入左側選單中的 `Moduls` 。此時看到的是預設所安裝的 Modules ，需要安裝及更新以下 Modules 才能讓 renew 功能正常運行。

進入 Browse gallery 安裝以下 modules：

- AzureRM.profile
- AzureRM.Network
- ACMESharp
- AzureRM.Storage
- ACME-PS
- AzureRMAppGWCert
- GetAppGWCerts

有些 modules 有相依其他 modules，所以當 import 時可能會提醒你是否安裝其他相依的 modules ，按下確認並等待更新完成即可。

![Modules list](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadUntitled.png)

# 建立 Runbook

Modules 設定完成後，建立執行 HTTPS 憑證更新的 runbook 。在左側選單中點選 Runbooks 並建立新的 runbook。設定時選擇 `Runbook type` 為 `PowerShell` 。

![image-20201011165709786](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201011165709786.png)

建立後，可直接到[Github分享的Script](https://github.com/intelequia/letsencrypt-aw/blob/master/letsencryptaw_v2.ps1)複製程式碼，並在建立的runbook中貼上。

![image-20201011170203426](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201011170203426.png)

貼上後按 Save，再按 Publish。執行前可先按 Test Pane 測試是否能正常 Renew SSL 憑證。

依序將下列資訊填入左側欄位並按下 Start便開始測試，若出現下圖右邊黑色畫面出現 completed 文字，代表已執行完成。下方文字沒有紅色的則表示沒有出現錯誤：

- 憑證DNS網域
- 申請使用的email
- Blob 所屬資源群組
- Blob 名稱
- Application Gateway 所屬資源群組
- Application Gateway 名稱
- 原 Listener 使用的憑證名稱

![image-20201011170514463](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201011170514463.png)

# 總結

本篇介紹在 Automation Accounts 更新 Modules 並建立更新HTTPS憑證的Runbook。建立 Runbook 後，要更新HTTPS憑證後，就可以按一下執行，就會自動更新憑證。但這樣還要手動按一下執行，還是有點不方便。

下一篇將繼續介紹，如何設定排程功能，讓更新憑證這件事，由 Automation Accounts 自動幫你完成!!

---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)