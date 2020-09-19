Notification hub 為手機推送訊息的服務，讓開發者可以從任何後端 (雲端或內部部署) 傳送通知到任何平台 (iOS、Android、Windows 等)。在設定時需針對不同的手機系統設定不同的通知服務：

- iOS：Apple Push Notification Service (APNS)
- Android：Firebase Cloud Messaging (FCM) 
- Windows：Windows 通知服務 (WNS)

Notification hub 流程大致說明如下：

1. 手機端開發的應用程式，需持續接收來自PNS的訊息，因此應用程式會要求唯一的暫時性推播控制代碼。
2. 應用程式取得控制代碼後，將代碼存到後端或處理通知的應用程式。
3. 當有訊息要推播給特定的裝置或所有裝置時，將發送的訊息透過 notification hub傳送給指定對象。

![通知中樞圖表](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadnotification-hub-diagram.png)

因為我目前的工作內容主要偏後端與雲端管理的部分，本篇主要著重在基本介紹與建立方式，以及使用Python傳送給手機端通知的方法，若您想知道的是App如何使用notification hub的話可以參考[說明文件](https://docs.microsoft.com/zh-tw/azure/notification-hubs/)。

# 建立Notification hub

進入Notification hub列表後，按下create notification hub 開始建立一個吧!下面為我建立的Notification hub，resource group 選擇上一篇文章建立的Tatamo。Notification hub 將建立namespace 及 notification hub，我分別命名為`iron12th`及`iron12th-message`，一個namespace中可以建立許多notification hub。

![image-20200919204302427](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200919204302427.png)

建立完成後進入畫面顯示如下，可以看到左側欄Settings那邊有Apple, Google, Windows, Windows Phone, Amazon及Baidu等服務可以設定。在相關平台申請後填入對應的KEY即可，每個服務所需要的KEY類型跟數量都不同，這點需要注意一下，建立之後便可以開始[使用python開發Notification hub功能](https://docs.microsoft.com/zh-tw/azure/notification-hubs/notification-hubs-python-push-notification-tutorial)。

![image-20200919205503019](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200919205503019.png)



# 使用python開發Notification hub功能

python開發notification hub 推送功能主要分成三個部分：

1. 解析Connection string
2. 產生授權權杖
3. 使用 HTTP REST API 傳送通知

## 解析Connection string

首先你需要先有此notification hub的Connection string。

![image-20200919235435948](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200919235435948.png)

在官方文件提供的範例程式碼以`class`處理，class初始化時便會解析Connection string，提供後續生成SAS Token使用。

```python
class NotificationHub:
    API_VERSION = "?api-version=2013-10"
    DEBUG_SEND = "&test"

    def __init__(self, connection_string=None, hub_name=None, debug=0):
        self.HubName = hub_name
        self.Debug = debug

        # Parse connection string
        parts = connection_string.split(';')
        if len(parts) != 3:
            raise Exception("Invalid ConnectionString.")

        for part in parts:
            if part.startswith('Endpoint'):
                self.Endpoint = 'https' + part[11:]
            if part.startswith('SharedAccessKeyName'):
                self.SasKeyName = part[20:]
            if part.startswith('SharedAccessKey'):
                self.SasKeyValue = part[16:]
```
## 建立安全性權杖

在剛剛建立的class中增加下面的程式碼，完成此class功能：

```python
@staticmethod
def get_expiry():
    # By default returns an expiration of 5 minutes (=300 seconds) from now
    return int(round(time.time() + 300))


@staticmethod
def encode_base64(data):
    return base64.b64encode(data)


def sign_string(self, to_sign):
    key = self.SasKeyValue.encode('utf-8')
    to_sign = to_sign.encode('utf-8')
    signed_hmac_sha256 = hmac.HMAC(key, to_sign, hashlib.sha256)
    digest = signed_hmac_sha256.digest()
    encoded_digest = self.encode_base64(digest)
    return encoded_digest


def generate_sas_token(self):
    target_uri = self.Endpoint + self.HubName
    my_uri = urllib.parse.quote(target_uri, '').lower()
    expiry = str(self.get_expiry())
    to_sign = my_uri + '\n' + expiry
    signature = urllib.parse.quote(self.sign_string(to_sign))
    auth_format = 'SharedAccessSignature sig={0}&se={1}&skn={2}&sr={3}'
    sas_token = auth_format.format(signature, expiry, self.SasKeyName, my_uri)
    return sas_token
```
## 使用 HTTP REST API 傳送通知

建立Notification class處理傳送通知的程式碼
```python
class Notification:
    def __init__(self, notification_format=None, payload=None, debug=0):
        valid_formats = ['template', 'apple', 'fcm',
                         'windows', 'windowsphone', "adm", "baidu"]
        if not any(x in notification_format for x in valid_formats):
            raise Exception(
                "Invalid Notification format. " +
                "Must be one of the following - 'template', 'apple', 'fcm', 'windows', 'windowsphone', 'adm', 'baidu'")

        self.format = notification_format
        self.payload = payload

        # array with keynames for headers
        # Note: Some headers are mandatory: Windows: X-WNS-Type, WindowsPhone: X-NotificationType
        # Note: For Apple you can set Expiry with header: ServiceBusNotification-ApnsExpiry
        # in W3C DTF, YYYY-MM-DDThh:mmTZD (for example, 1997-07-16T19:20+01:00).
        self.headers = None
    def make_http_request(self, url, payload, headers):
        parsed_url = urllib.parse.urlparse(url)
        connection = http.client.HTTPSConnection(
            parsed_url.hostname, parsed_url.port)

        if self.Debug > 0:
            connection.set_debuglevel(self.Debug)
            # adding this querystring parameter gets detailed information about the PNS send notification outcome
            url += self.DEBUG_SEND
            print("--- REQUEST ---")
            print("URI: " + url)
            print("Headers: " + json.dumps(headers, sort_keys=True,
                                           indent=4, separators=(' ', ': ')))
            print("--- END REQUEST ---\n")

        connection.request('POST', url, payload, headers)
        response = connection.getresponse()

        if self.Debug > 0:
            # print out detailed response information for debugging purpose
            print("\n\n--- RESPONSE ---")
            print(str(response.status) + " " + response.reason)
            print(response.msg)
            print(response.read())
            print("--- END RESPONSE ---")

        elif response.status != 201:
            # Successful outcome of send message is HTTP 201 - Created
            raise Exception(
                "Error sending notification. Received HTTP code " + str(response.status) + " " + response.reason)

        connection.close()


    def send_notification(self, notification, tag_or_tag_expression=None):
        url = self.Endpoint + self.HubName + '/messages' + self.API_VERSION

        json_platforms = ['template', 'apple', 'fcm', 'adm', 'baidu']

        if any(x in notification.format for x in json_platforms):
            content_type = "application/json"
            payload_to_send = json.dumps(notification.payload)
        else:
            content_type = "application/xml"
            payload_to_send = notification.payload

        headers = {
            'Content-type': content_type,
            'Authorization': self.generate_sas_token(),
            'ServiceBusNotification-Format': notification.format
        }

        if isinstance(tag_or_tag_expression, set):
            tag_list = ' || '.join(tag_or_tag_expression)
        else:
            tag_list = tag_or_tag_expression

        # add the tags/tag expressions to the headers collection
        if tag_list != "":
            headers.update({'ServiceBusNotification-Tags': tag_list})

        # add any custom headers to the headers collection that the user may have added
        if notification.headers is not None:
            headers.update(notification.headers)

        self.make_http_request(url, payload_to_send, headers)


    def send_apple_notification(self, payload, tags=""):
        nh = Notification("apple", payload)
        self.send_notification(nh, tags)


    def send_fcm_notification(self, payload, tags=""):
        nh = Notification("fcm", payload)
        self.send_notification(nh, tags)


    def send_adm_notification(self, payload, tags=""):
        nh = Notification("adm", payload)
        self.send_notification(nh, tags)


    def send_baidu_notification(self, payload, tags=""):
        nh = Notification("baidu", payload)
        self.send_notification(nh, tags)


    def send_mpns_notification(self, payload, tags=""):
        nh = Notification("windowsphone", payload)

        if "<wp:Toast>" in payload:
            nh.headers = {'X-WindowsPhone-Target': 'toast',
                          'X-NotificationClass': '2'}
        elif "<wp:Tile>" in payload:
            nh.headers = {'X-WindowsPhone-Target': 'tile',
                          'X-NotificationClass': '1'}

        self.send_notification(nh, tags)


    def send_windows_notification(self, payload, tags=""):
        nh = Notification("windows", payload)

        if "<toast>" in payload:
            nh.headers = {'X-WNS-Type': 'wns/toast'}
        elif "<tile>" in payload:
            nh.headers = {'X-WNS-Type': 'wns/tile'}
        elif "<badge>" in payload:
            nh.headers = {'X-WNS-Type': 'wns/badge'}

        self.send_notification(nh, tags)


    def send_template_notification(self, properties, tags=""):
        nh = Notification("template", properties)
        self.send_notification(nh, tags)
```

完成後便可以使用class，須提供`ConnectionString`及`NotificationHubName `。其中 ConnectionString 即為前面提到的Connection string，而NotificationHubName為剛剛建立的NotificationHub名稱，以此篇建立的名稱為範例顯示如下：
```python
hub = NotificationHub("ConnectionString", "iron12th-message")
```

若要傳送給Android手機，使用hub.send_fcm_notification()並提供JSON格式訊息內容為參數即可。iOS(send_apple_notification)及windows(send_windows_notification)的話切換到對應的function即可。

```python
fcm_payload = {
    'data':
        {
            'msg': 'Hello!'
        }
}
hub.send_fcm_notification(fcm_payload)
```