# 說明
繼上篇完成Frontend IP, Listener, Rule及HTTP 設定，今天終於來到Application Gateway的最後一道關卡，Backend。以下將說明Backend建立特性。

# Backend

Backend設定流量最後導向的目標，也就是要呈現的網站或服務。Backend pool 設定項目包含名稱、是否建立目標及目標設定，其中目標設定共4種類型：

- IP address or FDQN
  - 可輸入目標服務的IP或是FDQN路徑。
- Virtual machine
  - 可選擇Application Gateway連接的到的Virtual machine服務。
- VMSS
  - 可選擇Application Gateway連接的到的 VMSS 服務。
- App Service
  - 可選擇Application Gateway連接的到的 App Service 服務。

![image-20201008231036179](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201008231036179.png)

一個Backend pool 可以設定很多個目標，但我還沒有測試過如果設定很多個會有甚麼結果，但照理來說會都設定一樣版本的服務，作為災時備援使用。

# 總結

本篇簡要說明Backend特性及建立時的設定。至本篇已將Application Gateway主要的幾個設定項目說明完畢，下一篇將繼續介紹網站常常需要用到的HTTPS申請，最後再結合前述幾篇的資訊，建立一個Application Gateway服務，並在建立時即完成免費憑證申請所需的設定。







---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)