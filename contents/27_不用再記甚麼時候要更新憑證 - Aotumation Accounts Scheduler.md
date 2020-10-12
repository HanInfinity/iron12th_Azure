# 說明
上一篇介紹建立一鍵更新HTTPS憑證的Runbook，但既然都可以一鍵完成了，那是不是可以有一個小幫手來幫我們按下那一鍵呢？本篇將延續上篇的進度，繼續說明建立schedule幫你定期一鍵更新的方法。

## 設定 HTTPS 憑證 更新 Schedule

當上一篇建立runbook確認有正常執行後，回到 Automation Accounts 頁面來建立自動更新憑證的排程設定。按一下 Linke to schedule ，裡面需選擇 Schedule 及 Parameters，尚未建立schedule 可直接建立新的，自訂 schedule 的執行開始時間、執行次數及頻率等都可以在設定中自行選擇，完成後按 Create 建立。

![New Schedule](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload201125524yMXih6bcj.png)

Parameters 的資訊就跟前面 Test Pane 輸入的參數一樣，設定完後按下OK便完成排程設定，接下來Azure就會幫你更新HTTPS憑證囉!!

![Setting Parameters](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload20112552HP87GwNb5a.jpg)

# 問題與處理方式

## 'MinCapacity' is less than minimum value of '2'.

當遇到以上錯誤訊息，代表連結的 Application Gateway 的 Minimum scale units 小於2導致此錯誤訊息出現。到 Application Gateway 的 Configuration 將 Minimum scale units 設定到2以上即可解決。

![image-20201012211229900](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201012211229900.png)



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)