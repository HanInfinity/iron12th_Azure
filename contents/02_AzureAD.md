若要說進入Azure後第一個使用的服務是什麼，我認為是Azure Active Directory。因為當你在申請免費帳戶的時候，就是使用AzureAD登入Microsoft帳戶並註冊的。下面的畫面是否非常熟悉呢？他就是登入Azure時出現的畫面。這個畫面就是透過AzureAD進行管理的，當登入後，Azure會收到Microsoft傳給他的資訊，確認登入的身份是否為有效的Microsoft帳號，若是的話，才會進一步讓你登入使用Azure的服務。AzureAD說明文件可以參考[這裡](https://docs.microsoft.com/zh-tw/azure/active-directory/fundamentals/active-directory-whatis)

![image-20200916225608544](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200916225608544.png)

在主畫面找到並進入Active Directory後，你就會看到一個Tenant information出現在畫面中間偏下的地方，這個就是你現在所在的tenant，中文稱為租用戶。

側邊欄的功能項目分為基本、Manage及Monitor。其中Manage為管理方面的功能如使用者(User)、群組(Groups)、應用程式註冊(App registration)等；Monitor則為監控相關的功能設定。

![image-20200916230850224](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200916230850224.png)

畫面下方也另外提供連結，可以快速建立使用者、群組、應用程式註冊等相關功能。

![image-20200916231547056](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200916231547056.png)

說明文件有提到：『Azure AD是 Microsoft 的雲端式身分識別和存取管理服務，可協助員工登入及存取Microsoft 365、Azure 入口網站和其他數千個 SaaS 應用程式等外部資源，及公司網路和內部網路上的應用程式，以及您自己的組織所開發的任何雲端應用程式。』意味著你可以利用AzureAD替你管理使用者資訊。

## 建立使用者

在同一個租用戶中，你可以建立不同的使用者及群組，甚至邀請已經有microsoft帳號的使用者到這個租用戶中，接下來建立一個新的使用者試試吧。按下Create系列中的User，直接進入新增使用者的畫面。

![image-20200917005111068](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917005111068.png)

進入後，可以選擇建立新的使用者或是邀請已有帳號的使用者加入，若要建立新使用者的話，至少要輸入User name及Name的資訊，看到Create按鈕變成藍色就可以按下並建立使用者。

建立完成後進入User中就可以看到新建立的使用者出現在列表中。

![image-20200917005559647](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917005559647.png)

若想要給該名使用者密碼，可以按Reset password，系統便會提供一個隨機密碼，該使用者用此密碼登入後，會要求修改密碼。

![image-20200917005834922](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917005834922.png)

![image-20200917010121176](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917010121176.png)

修改後便可以使用該帳號登入，並共用同一個免費帳戶的資源!

## 建立群組

在AzureAD中，你也可以建立不同的群組，管理不同的使用者存取資源的權限。

![image-20200917225541043](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917225541043.png)

建立時至少需填寫名稱，類型的話預設為Security，若想要選擇O365的可以在這邊選擇，命名完成後按下Create便完成群組的建立!

![image-20200917231501284](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917231501284.png)

此時回到群組列表就會看到剛剛建立的群組囉!

![image-20200917231725892](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917231725892.png)

進入剛剛建立的`新手村`後，可以選擇member來設定加入群組的成員，來把剛剛建立的使用者加進去吧!

![image-20200917231921827](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917231921827.png)

![image-20200917232015214](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917232015214.png)

此時右邊會跳出視窗讓你選擇想要加入到此群組的使用者帳號，找到剛剛建立的使用者並點一下，他就會跳到下面的區塊，代表這個使用者帳號被你選到了，若還想加入其他的帳號可以繼續點，點完後按一下select便完成設定囉!

![image-20200917232252478](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917232252478.png)

![image-20200917232355412](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917232355412.png)

好了，今天主要介紹的是AzureAD的簡介及使用者、群組建立流程。AzureAD的應用還包括App registry，預計會在後面的實作中一併說明。

