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

# 建立服務

## 建立Storage Account

在使用任何一個Storage中的服務前，至少要先有一個storage account，建立方式一如既往地簡單。除了resource group 、name 及 location 以外，我都是用預設提供的位置。按下 `Review + create` 後，再按一次  `Create` 來建立新的storage account。

![image-20200923160510194](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923160510194.png)

## 建立Blob Container

進入storage account 後，點選左側或是畫面中間的 Containers

![image-20200923162730437](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923162901437.png)

接著按下 `+ Container`以建立新的container

![image-20200923162901437](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923163022340.png)

此時右側會出現建立的頁面，自訂名稱後按下Create即可。

![image-20200923163022340](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923174345827.png)

此時可以在列表中看到剛剛建立的container。

![image-20200923173029101](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923162730437.png)

## 建立File Share

一樣從storage account畫面或是左側點選File share。設定完名稱後按下Create建立新的file share。

![image-20200923173250786](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923174624089.png)

可以看到新建立的file share出現在列表中。

![image-20200923174345827](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923174849715.png)



## 建立Table

從storage account畫面或是左側點選Tables，再按一下 `+ Table`，此時下方會跳出建立Table的頁面。設定完名稱後按下OK建立新的table。

![image-20200923174624089](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923173250786.png)

## 建立Queue

從storage account畫面或是左側點選Queues，再按一下 `+ Table`，此時下方會跳出建立Queue的頁面。設定完名稱後按下OK建立新的queue。

![image-20200923174849715](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200923173029101.png)