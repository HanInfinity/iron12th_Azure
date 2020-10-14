# 說明

繼上篇建立 App Registration 後，本篇將繼續介紹使用MSAL透過Activate Directory取得API存取授權token。下列說明一樣使用Jupyter Notebook操作並記錄，可參考文件。

# MSAL

使用前先安裝套件

```bash
pip install msal
```

接下來需要讀取一些資訊，這邊我是記在env檔案，再從程式中讀取：

```python
import os
from dotenv import load_dotenv
import msal
import logging

load_dotenv()
authority = os.environ["AUTHORITY"]                      ##https://login.microsoftonline.com/{TENANT ID}
client_id = os.environ["CLIENT_ID"]                      ##ENTER THE CLIENT ID OF YOUR SERVICE PRINCIPAL
client_secret = os.environ["CLIENT_SECRETE"]             ##ENTER THE CLIENT SECRET OF YOUR SERVICE PRINCIPAL
```

其中`CLIENT_ID`及AUTHORITY中所需的`TENANT ID`可在下圖中紅框的位置取得。

![image-20201014163008896](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201014163008896.png)

`CLIENT_SECRETE`則是到Certificates & secrets建立新的(或是有記得之前建立且尚未過期的也行)，按一下複製即可。

> 建立後重新整理CLIENT_SECRETE就會隱藏，所以要記下來，不然下次還要再建一次新的。

![image-20201014163225153](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201014163225153.png)

接著執行以下程式碼。下列程式碼為回傳取得graph api 的token內容，並顯示token類型。若成功取得的話，會顯示`Bearer`，表示取得的token為Bearer型態，而token就在result['access_token']中。

```python
app = msal.ConfidentialClientApplication(
    client_id, authority=authority,
    client_credential=client_secret)

# The pattern to acquire a token looks like this.
result = None

# First, the code looks up a token from the cache.
# Because we're looking for a token for the current app, not for a user,
# use None for the account parameter.
result = app.acquire_token_silent(["https://graph.microsoft.com/.default"], account=None)

if not result:
    logging.info("No suitable token exists in cache. Let's get a new one from AAD.")
    result = app.acquire_token_for_client(scopes=["https://graph.microsoft.com/.default"])

if "access_token" in result:
    # Call a protected API with the access token.
    print(result["token_type"])
else:
    print(result.get("error"))
    print(result.get("error_description"))
    print(result.get("correlation_id"))  # You might need this when reporting a bug.
```



# 總結

有了token之後，就可以在權限許可範圍中，在header中加入Bearer token使用Microsoft Graph API，詳細內容無法在本次鐵人賽中一一說明，可以到[這裡](https://docs.microsoft.com/en-us/graph/use-the-api)欣賞。

---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)