今天又要來講實戰性的內容了！將透過python程式碼實際執行storage相關功能。

# Blob

首先來講我相對熟悉的Blob。在使用前須先安裝套件：

```bash
pip install azure-storage-blob
```

正式使用前，還需要準備blob的ConnectionString。在進入storage後，按一下settings中的Access keys，會看到裡面有key1 及 key2。每個key都有connection string，複製其中一個即可。我的做法是將connection string存在.env中，再用dotenv讀取，比較安全。

![image-20200924230116922](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200924230116922.png)

以下程式碼為列出所有在`tatamocontainer`中的所有blob物件。

```python
from dotenv import load_dotenv

load_dotenv()
connect_str = os.getenv('AZURE_STORAGE_CONNECTION_STRING')

# 建立 BlobServiceClient 物件
blob_service_client = BlobServiceClient.from_connection_string(connect_str)
# 設定已建立的container name
container_name = "tatamocontainer"
# 透過blob_service_client取得container client
container_client = blob_service_client.get_container_client(container_name)

print("\nListing blobs...")

# 將tatamocontainer中的blob都列出來
blob_list = container_client.list_blobs()
for blob in blob_list:
    print("\t" + blob.name)
```
會看到輸出結果如下：
```
Listing blobs...
	KaoDistrict.html
```
另外還有建立container、上傳blob、下載blob及刪除container等功能，可參考[官方說明文件](https://docs.microsoft.com/zh-tw/azure/storage/blobs/storage-quickstart-blobs-python)

# Queue
使用前先安裝套件：
```bash
pip install azure-storage-queue
```
connection string與上一段說明取得的是同一個，可以直接使用。以下為設定取得`taqueue`連線，並傳送三筆訊息到queue中。

```python
import os, uuid
from azure.storage.queue import QueueServiceClient, QueueClient, QueueMessage
from dotenv import load_dotenv

load_dotenv()
connect_str = os.getenv('AZURE_STORAGE_CONNECTION_STRING')

queue_name = 'taqueue'
# Instantiate a QueueClient which will be
# used to create and manipulate the queue
queue_client = QueueClient.from_connection_string(connect_str, queue_name)
print("\nAdding messages to the queue...")

# Send several messages to the queue
queue_client.send_message(u"First message")
queue_client.send_message(u"Second message")
# 也可以將訊息儲存，可調用資訊來更新訊息
saved_message = queue_client.send_message(u"Third message")
```
可看到azure上存放了這三筆訊息

![image-20200924233607279](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200924233607279.png)

接著執行取得訊息的程式，這邊的取得方式有兩種，一個是現在用的peek（窺視），另一個是receive（接收）。peek只會收到訊息內容，而receive則包含其他詳細資訊。

```python
print("\nPeek at the messages in the queue...")

# Peek at messages in the queue
peeked_messages = queue_client.peek_messages(max_messages=5)

for peeked_message in peeked_messages:
    # Display the message
    print("Message: " + peeked_message.content)
```

取得結果如下：

```
Peek at the messages in the queue...
Message: First message
Message: Second message
Message: Third message
```

接收訊息程式碼如下

```python
print("\nReceiving messages from the queue...")

# Get messages from the queue
messages = queue_client.receive_messages(messages_per_page=5)
for message in messages:
    # Display the message
    print("Message: " + message)
```
接著會輸出詳細的訊息及相關資訊，且接收後訊息會消失，等同於之前service bus中執行complete()。

以上queue作法與[情報員上戰場 - ServiceBus實作](https://ithelp.ithome.com.tw/articles/10241630)差不多，若有使用過servicebus的話還滿容易上手的。

# Table

先安裝套件

```bash
pip install azure-cosmosdb-table
```

下方建立table_service 連線，並以dict型態建立task，然後透過table_service傳送至`tatable`中。

```python
from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity

from dotenv import load_dotenv

load_dotenv()
connect_str = os.getenv('AZURE_STORAGE_CONNECTION_STRING')
table_service = TableService(connection_string=connect_str)

# 建立並以dict型態至table
task = {'PartitionKey': 'tasksSeattle', 'RowKey': '001',
        'description': 'Take out the trash', 'priority': 200}
table_service.insert_entity('tatable', task)
```

另外也可以以物件的型態傳送

```python
# 建立並以物件型態至table
task = Entity()
task.PartitionKey = 'tasksSeattle'
task.RowKey = '002'
task.description = 'Wash the car'
task.priority = 100
table_service.insert_entity('tatable', task)
```

兩種型態傳送到Azure Storage Table，都會各自存成一筆資料，讀取回來的結果如下：

```python
tasks = table_service.query_entities(
    'tatable', filter="PartitionKey eq 'tasksSeattle'")
for task in tasks:
    print(task.description)
    print(task.priority)
    print(task.PartitionKey)
    print(task.RowKey)
    print("-------")
```

```
Take out the trash
200
tasksSeattle
001
-------
Wash the car
100
tasksSeattle
002
-------
```



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)