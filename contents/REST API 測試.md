

Notification hub傳送通知的方法有很多，本篇主要說明使用[REST API](https://docs.microsoft.com/zh-tw/rest/api/notificationhubs/rest-api-methods)的方式透過notification hub傳送通知給手機端，另外還有許多方式可以參考notification hub中左側欄`Quick Start`的資訊。

在與notification hub的串接程式開發中，除了建立推送的功能外，當其他的機制設定也需要做好，像是當notification hub尚未建立的話，需要建立一個新的以維持推送功能的運作，其他還有許多設定需要考量到，這邊只說明傳送通知的方法，其他可以參考[REST API說明](https://docs.microsoft.com/zh-tw/rest/api/notificationhubs/rest-api-methods)。若有不懂的地方也歡迎在下方提問唷~

在使用REST API 需要在傳送要求的header中提供access_token，若要使用postman測試可以參考這部影片或[文章](https://blog.jongallant.com/2017/11/azure-rest-apis-postman/)。

<iframe width="560" height="315" src="https://www.youtube.com/embed/fh37VQ3_exk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

傳送的方式

![image-20200919212135294](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200919212135294.png)