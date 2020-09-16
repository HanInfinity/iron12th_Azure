在Azure[官網](https://azure.microsoft.com/zh-tw/overview/what-is-azure/)中有提到：Microsoft Azure 是一款不斷擴大的雲端服務組合，可協助組織解決商業挑戰。它可讓您自由地在大規模的全球網路上使用自己慣用的工具和架構來建置、管理及部署應用程式。

在Azure剛出來的時候，只有部分功能，加上當時我還對資訊開發知識不夠，所以加入試用時只會開啟虛擬桌面，然後錢很快就燒光了，什麼都沒測試到。直到今年的案子，在主管規劃的系統架構中，才開始真正接觸到Azure的一些服務，所以接下來的文章中，主要分享的是我在專案裡使用到的服務，以Django網站架設的相關服務為主。Azure服務的類型十分多元，大多數的開發需求他都能做到，雖然我現在接觸過的可能不到所有服務的一半，若之後還有機會，也會繼續分享其他服務的心得。

## 註冊免費帳戶

在使用Azure服務前，首先要有一組帳號。若沒有的話，可以先註冊免費帳號進行測試。

首先在google中搜尋 `azure` ，第一個就會出現Microsoft Azure: 雲端運算服務，按一下裡面的免費帳戶進入申請註冊畫面。

![Azure%20Intro%208073cf25ddd84e759856a5fa50d06c2e/Untitled.png](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/g2EvZl7jnouLk3f.png)

進入免費帳戶頁面後，按一下開始免費使用，進行註冊。接下來會要你登入Microsoft帳號，登入後網頁在確認此帳號尚未申請過免費帳戶的話，會再要求輸入一些基本資訊及信用卡資訊（不會扣款），接下來就可以暢快使用囉！

![Azure%20Intro%208073cf25ddd84e759856a5fa50d06c2e/Untitled%201.png](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/Untitled%201.png)

## 操作畫面簡介

成功取得免費帳戶後，進入入口網站，便可以看到首頁畫面如下，此時右上角會跳出通知說現在使用的是訂用帳戶 '免費試用版' 尚餘價值 NT$6,100.00 元的點數。

![Azure%20Intro%208073cf25ddd84e759856a5fa50d06c2e/Untitled%202.png](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/Untitled%202.png)

按下 `更多服務` 後便可以看到在Azure上提供的所有服務囉！！

![Azure%20Intro%208073cf25ddd84e759856a5fa50d06c2e/Untitled%203.png](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/Untitled%203.png)

## 大綱

接下來的文章預計分為以下部分進行說明，每一項服務依照實際接觸過的內容多寡分為多個篇幅，希望能在這30天內完整分享給大家。

1. Azure AD
2. Resource Groups
3. Notification hub
4. ServiceBus
5. Automation Accounts
6. Storage
7. App Service
8. Container Registry
9. Kubernetes Service
10. PostgresQL
11. Key vaults
12. Application Gateway
13. App registrations
14. Application Insights
15. Dash board