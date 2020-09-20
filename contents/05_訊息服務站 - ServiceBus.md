Service Bus 提供了另一種訊息服務傳遞的方式。之前專案會使用到這個服務主要是為了避免後端功能在執行時遺漏資訊，或是當訊息量過大時來不及處理，有了Service Bus後可以先有一個地方可以先暫時儲存訊息，讓後端能夠在非同步的狀況下，將訊息完整的處理完成，避免資訊遺漏的問題。當然Service Bus的功能也不只有這樣，下面將進行更加詳細的說明。

# 簡介

微軟官方[說明文件](https://docs.microsoft.com/zh-tw/azure/service-bus-messaging/service-bus-messaging-overview)提到：

Microsoft Azure 服務匯流排是完全受控的企業整合訊息代理程式。 服務匯流排可以將應用程式與服務分離。 服務匯流排針對非同步資料和狀態傳輸提供了可靠且安全的平台。

資料會使用「訊息」  在不同的應用程式和服務之間傳輸。 訊息採用二進位格式，且可包含 JSON、XML 或純文字。

一些常見的傳訊案例如下：

- *傳訊*。 傳輸商務資料，例如銷售或採購單、日誌或庫存移動。
- *將應用程式分離*。 改善應用程式和服務的可靠性和延展性。 用戶端和服務不需要同時上線。
- *主題和訂用帳戶*。 讓「發行者」與「訂閱者」之間有 1:n  的關聯性。
- *訊息工作階段*。 實作需要訊息排序或訊息延遲的工作流程。



在ServiceBus中，也有Namespace的設定，每個Namespace中可以有好幾個Queues或Topics。Queues 與 Topics差異說明如下：

## Queues

Queues中文翻譯為`佇列`，一個queue代表一個傳遞管道，當有訊息傳送到此queue時，就只會有一個接收者會收到訊息。另外Queues在處理訊息時並沒有照訊息的傳送時間排序，也就是說當queue中有好幾個訊息，接收者處理時不一定會先處理到第一個傳送的訊息，若使用的服務有要按傳送先後順序處理的需求，就需要使用topic處理。

![佇列](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadabout-service-bus-queue.png)



## Topics

Topics中文翻譯為`主題`，一個Topic裡面可以設定好幾個subscriptions，每個subscription都會有一個接收者，也就是說我只要發送一個訊息到這個topic，topic中的所有subscriptions都會收到同樣的訊息。

![主題](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadabout-service-bus-topic.png)

# 建立 Service Bus

建立Service Bus服務可透過入口網站、Azure PowerShell及Azure CLI，本篇文章主要說明使用入口網站建立的流程。建立時需選擇resource group，並設定namespace名稱、選擇地區與方案後，按下Review + create，再按一次Create便會開始建立Service Bus。

![建立Service Bus](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920210009945.png)

Service Bus 定價及功能說明如下，值得注意的是，Basic並未包含Topic功能，若有需要使用topic功能，需要選擇Standard或Premium的定價才行喔。

![付費方案](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload%E6%88%AA%E5%9C%96%202020-09-20%20%E4%B8%8B%E5%8D%889.00.44.png)

因為我在建立的時候選擇的是basic，想要換定價的話不必刪除重建，只要在建立完成後進入Service Bus畫面中的`Pricing tier`，就可以修改定價方案囉。

![升級付費方案](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadtypora_uploadimage-20200920211929026.png)

## 建立Queue

進入Service Bus 畫面後，左上角有按鈕讓你快速建立Queue及Topic，按下左邊的Queue，在視窗右側會跳出建立新queue的頁面。

![建立Queue](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920211838298.png)

可以依喜好設定名稱、最大訊息容量、最大傳遞計數、訊息存在時間及鎖定訊息時間。

![image-20200920220511448](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920220511448.png)

建立完成後，在側邊欄中可以找到Queues的按鈕，按一下便可以檢視現在已建立的queues列表

![image-20200920221454566](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920221454566.png)

## 建立Topic

同樣在畫面的左上方按一下Topic，視窗右側便會跳出建立topic的頁面。

![建立Topic](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920211910506.png)

可依喜好設定名稱、訊息大小上限、訊息存在時間等項目。

![image-20200920212317711](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920212317711.png)

建立完成後，在側邊欄中可以找到Topics的按鈕，按一下便可以檢視現在已建立的topics列表

![image-20200920221551820](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200920221551820.png)

今天文章中說明了Service Bus及Queue、Topic的特性，並且建立了Queue及Topic服務。明天將繼續介紹利用python傳送與接收Queue、Topic兩個服務的方法。