# 簡介

跟Dropbox, Google Drive, One Drive等雲端硬碟一樣，Azure也有屬於他自己的雲端硬碟Storage。但Storage中可用的功能比其他雲端硬碟更多，還能夠設定一些服務。Azure Storage服務內容包含以下5種，服務名稱與建議使用情境說明如下：

- Azure Blobs
  - 您想要應用程式支援串流及隨機存取案例。
  - 您想要能夠從任何位置存取應用程式資料。
  - 您想要在 Azure 上建置企業 Data Lake，並執行巨量資料分析。
- Azure Files
  - 您想要將應用程式「隨即轉移」至已使用原生檔案系統 Api 的雲端，以在其和在 Azure 中執行的其他應用程式之間共用資料。
  - 您想要取代或補充內部部署檔案伺服器或 NAS 裝置。
  - 您想要儲存需要從許多虛擬機器存取的開發和偵錯工具。
- Azure Queues
  - 您想要分離應用程式元件，並使用非同步訊息在兩者之間進行通訊。
- Azure Tables
  - 您想要儲存具彈性的資料集，例如 web 應用程式的使用者資料、通訊錄、裝置資訊，或服務所需的其他元資料類型。
- Azure Disks
  - 您想要「隨即轉移」使用原生檔案系統 Api 的應用程式，以讀取和寫入持續性磁片的資料。

每個Storage類型皆不同，依照使用的需求來選擇適合的類型。我之前接觸到Storage是因為需要有一個空間放置照片，並且讓手機App及網頁可以讀取到這些照片，所以我使用的是Azure Blob的服務。

# 建立Storage Account

在使用任何一個Storage中的服務前，至少要先有一個storage account，建立方式一如既往地簡單。除了resource group 、name 及 location 以外，我都是用預設提供的位置。按下 `Review + create` 後，再按一次  `Create` 來建立新的storage account。

![image-20200923160510194](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923160510194.png)

# Blob

## 建立Blob Container

進入storage account 後，點選左側或是畫面中間的 Containers

![image-20200923173029101](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923162730437.png)

接著按下 `+ Container`以建立新的container

![image-20200923162730437](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923162901437.png)

此時右側會出現建立的頁面，自訂名稱後按下Create即可。

![image-20200923162901437](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923163022340.png)

此時可以在列表中看到剛剛建立的container。

![image-20200923174849715](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923173029101.png)



建立完成後，進入container便可以開始上傳檔案，把資料儲存在blob中。按一下 `Upload`，右側會跳出視窗，接著選擇要上傳的檔案，上傳狀態會顯示在下方。若上傳成功的話就可以在container中看到上傳的檔案囉!

![image-20200923224334235](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923224334235.png)

此時點一下剛剛上傳的檔案，並複製URL，在新的視窗貼上後，你將會看到檔案的內容，如果他是HTML檔的話，就會以網頁的方式顯示......

![image-20200923224805980](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923224805980.png)

但在貼上後你會發現，檔案是看不到的!

![image-20200923225021689](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923225021689.png)

這是因為一開始在建立container的時候，預設的權限是private。

![image-20200923162901437](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923163022340.png)

若想要把上傳的檔案公開給所有人使用，可以修改權限。

![image-20200923225243502](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923225243502.png)

共三種權限可以選擇：Private(不開放權限), Blob(開放讀取blob權限), Container(開放讀取blob及container權限)

![image-20200923225306149](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923225306149.png)

當然開放權限的話會有一定的安全性問題，若你只是想要給知道連結的人讀取的話，可以提供對方包含SAS token的網址。

按一下要分享的檔案，再按`Generate SAS`，可以設定此token的期限，確認後按一下 `Generate SAS token and URL`，下面便會跳出兩個字串，一個是SAS token 可以附加在網址後面，而另一個則是已經包含SAS token的網址，複製第二個網址並在新視窗貼上。

![image-20200923225701748](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923225701748.png)

就會看到HTML內容囉!!

![image-20200923230016742](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923230016742.png)

# File Share

## 建立File Share

一樣從storage account畫面或是左側點選File share。設定完名稱後按下Create建立新的file share。

![image-20200923174624089](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923173250786.png)



可以看到新建立的file share出現在列表中。

![image-20200923163022340](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923174345827.png)

File Share可以做為網路磁碟機掛載到電腦上，需要連線Azure VPN才能使用。


# Table
## 建立Table

從storage account畫面或是左側點選Tables，再按一下 `+ Table`，此時下方會跳出建立Table的頁面。設定完名稱後按下OK建立新的table。

![image-20200923173250786](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923174624089.png)

可以透過[azure-cosmosdb-table](https://pypi.org/project/azure-cosmosdb-table/)存取table資料。

# Queue
## 建立Queue

從storage account畫面或是左側點選Queues，再按一下 `+ Table`，此時下方會跳出建立Queue的頁面。設定完名稱後按下OK建立新的queue。

![image-20200923174345827](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923174849715.png)

[這裡](https://docs.microsoft.com/zh-tw/azure/storage/common/storage-samples-python?toc=/azure/storage/queues/toc.json#queue-samples)有提供透過python存取queue的方法。

# 結論

今天主要說明Storage account 相關功能，及簡易建立方法。另外補充Blob的使用方式，其他的服務因為尚未接觸，無法內化分享給大家，待未來有機會接觸時會再整理並分享。

---
★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)

