今天將分成Queue及Topic兩個部分實作

參考https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/servicebus/azure-servicebus


# 實作

接下來要講一下實戰性的部分了，在queue及topic都是處理訊息傳送的部分，所以會有程式將訊息傳送到service bus，也就會有程式從service bus中讀取出來。因此下面實作的部分，將個別說明Queue及Topic兩者在傳送與接收訊息之間的差異，本篇實作程式碼均參考[官方說明文件](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/servicebus/azure-servicebus)再加以調整內容。

## 安裝套件

執行前先安裝azure-servicebus套件，套件已經幫我們把最困難的部分解決了，我們只要好好的運用套件帶來的成果即可！

```bash
pip install azure-servicebus --pre
```

## 準備

在使用程式碼前，須先取得服務的相關連線及驗證資訊。機密資訊的部分，我將他們都存在`.env`檔案中，提供JupyterNotebook存取，以下程式碼可直接讀取，同時避免資訊外洩遭有心人士利用。
- ConnectionString

  在進入到Service Bus頁面後，按一下`Shared access policies`，選擇其中一個policy，右側變顯示2個key跟2個ConnectionString，將其中一個複製起來。

  ![image-20200921222113215](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921222113215.png)

- Queue
  
  - QueueName
  
    按一下Queues，此時會看到這個serviceBus中所有的queues列表（下圖只有1個），選擇一個要傳送的名稱並記起來，等一下執行傳送訊息後記得不要進到錯的queue中，這樣會看不到訊息的。
  
    ![image-20200921222359830](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921222359830.png)
  
- Topic
  - TopicName
  
    按一下Topics，此時會看到這個serviceBus中所有的topics列表（下圖只有1個），選擇一個要傳送的名稱並記起來，接著按一下topic進入其畫面。
  
    ![image-20200921222707760](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921222707760.png)
  
  - SubscriptionName
  
    進入後按一下Subscriptions。如果您按照上一篇的文章動作的話，應該會跟我一樣，沒有subscription資料。點一下Subscription來新增一個：
  
    ![image-20200921222850898](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921222850898.png)
  
    設定名稱及最大傳送數量後，按下`Create`建立新的Subscription。也可以再新增幾個來測試，當傳送訊息到Topic時，Topic底下的Subscription皆會收到同樣的訊息。同樣的要記下每一個subscription的名稱。
  
    ![image-20200921223158429](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921223158429.png)
    
    

## Queue

在前面已經知道ConnectionString及QueueName。以下程式碼為測試是否能傳送到指定的queue中。

```python
from azure.servicebus import ServiceBusClient, Message

import os
connstr = os.environ['SERVICE_BUS_CONN_STR']
queue_name = os.environ['SERVICE_BUS_QUEUE_NAME']

with ServiceBusClient.from_connection_string(connstr) as client:
    with client.get_queue_sender(queue_name) as sender:
        # Sending a single message
        single_message = Message("Single message")
        sender.send_messages(single_message)

        # Sending a list of messages
        messages = [Message("First message"), Message("Second message")]
        sender.send_messages(messages)
```

送出後可以看到對應的queue裡面有3則訊息，`Single message`、`First message`及`Second message`。

![image-20200921232106389](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921232106389.png)

接著使用接收程式碼取得訊息：

```python
from azure.servicebus import ServiceBusClient

import os
connstr = os.environ['SERVICE_BUS_CONN_STR']
queue_name = os.environ['SERVICE_BUS_QUEUE_NAME']

with ServiceBusClient.from_connection_string(connstr) as client:
    # max_wait_time specifies how long the receiver should wait with no incoming messages before stopping receipt.  
    # Default is None; to receive forever.
    with client.get_queue_receiver(queue_name, max_wait_time=30) as receiver:
        for msg in receiver:  # ServiceBusReceiver instance is a generator. This is equivilent to get_streaming_message_iter().
            print(str(msg))
            # If it is desired to halt receiving early, one can break out of the loop here safely.
```

將收到剛剛送出的訊息：

![image-20200921232418240](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921232418240.png)

如果這時候再回去看Azure上的紀錄，會發現3個訊息還是存在。是因為程式碼中少加了`.complete()`的動作，要告訴service bus這則訊息已經處理完成，他才不會一直存在記憶體中。

## Topic

Topic這邊我也測試一個subscription來接收看看，下面我讓他傳送6筆訊息過去：

```python
from azure.servicebus import ServiceBusClient, Message

import os
connstr = os.environ['SERVICE_BUS_CONN_STR']
topic_name = os.environ['SERVICE_BUS_TOPIC_NAME']
subscription_name = os.environ['SERVICE_BUS_SUBSCRIPTION_NAME']

with ServiceBusClient.from_connection_string(connstr) as client:
    i = 0
    while i <= 5:
        with client.get_topic_sender(topic_name) as sender:
            msg=f"Data{i}"
            sender.send_messages(Message(msg))
            print(msg)
        i += 1
```

輸出的訊息長這樣：

![image-20200921233455271](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921233455271.png)

來到Azure上面，發現有33筆訊息！！！（因為我測試好幾次）

![image-20200921233802224](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921233802224.png)

先看一下程式碼

```python
from azure.servicebus import ServiceBusClient, Message

import os
connstr = os.environ['SERVICE_BUS_CONN_STR']
topic_name = os.environ['SERVICE_BUS_TOPIC_NAME']
subscription_name = os.environ['SERVICE_BUS_SUBSCRIPTION_NAME']

with ServiceBusClient.from_connection_string(connstr) as client:
    # If session_id is null here, will receive from the first available session.
    with client.get_subscription_receiver(topic_name, subscription_name) as receiver:
        for msg in receiver:
            print(str(msg))
```

看起來很正常，輸出的訊息長這樣：

![image-20200921234057558](/Users/tatamo/Library/Application Support/typora-user-images/image-20200921234057558.png)

這邊訊息我有先輸出了，但他還是存在於服務中。因為還少了一個步驟！！

```python
from azure.servicebus import ServiceBusClient, Message

import os
connstr = os.environ['SERVICE_BUS_CONN_STR']
topic_name = os.environ['SERVICE_BUS_TOPIC_NAME']
subscription_name = os.environ['SERVICE_BUS_SUBSCRIPTION_NAME']

with ServiceBusClient.from_connection_string(connstr) as client:
    # If session_id is null here, will receive from the first available session.
    with client.get_subscription_receiver(topic_name, subscription_name) as receiver:
        for msg in receiver:
            print(str(msg))
            ## 少了這個！！！
            msg.complete()
```

訊息在處理完後記得要執行`.complete()`，否則會一直存在在service bus中。

全部執行complete後就歸0了。

![image-20200921234311383](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200921234311383.png)

# 總結
今天主要介紹使用Queue及Topic傳送、接收訊息的實作，其實做法都差不多，只差在queue只有一個接收者，topic可以設定許多接收者。

在接收到訊息並處理完後，必須執行complete()動作，讓service bus知道這個訊息已完成，才會釋出記憶體。除了`.complete()`以外，還有[.abandon()](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-servicebus/latest/azure.servicebus.html?highlight=abandon#azure.servicebus.ReceivedMessage.abandon), [.dead_letter()](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-servicebus/latest/azure.servicebus.html?highlight=dead_letter#azure.servicebus.ReceivedMessage.dead_letter)及[.defer()](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-servicebus/latest/azure.servicebus.html?highlight=defer#azure.servicebus.ReceivedMessage.defer)等用法，可以參考相對的連結。

---
★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)