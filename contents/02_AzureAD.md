若要說進入Azure後第一個使用的服務是什麼，我認為是Azure Active Directory。因為當你在申請免費帳戶的時候，就是使用AzureAD登入Microsoft帳戶並註冊的。下面的畫面是否非常熟悉呢？他就是登入Azure時出現的畫面。這個畫面就是透過AzureAD進行管理的，當登入後，Azure會收到Microsoft傳給他的資訊，確認登入的身份是否為有效的Microsoft帳號，若是的話，才會進一步讓你登入使用Azure的服務。AzureAD說明文件可以參考[這裡](https://docs.microsoft.com/zh-tw/azure/active-directory/fundamentals/active-directory-whatis)

![image-20200916225608544](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200916225608544.png)

在主畫面找到並進入Active Directory後，你就會看到一個Tenant information出現在畫面中間偏下的地方，這個就是你現在所在的tenant，中文稱為租用戶。

側邊欄的功能項目分為基本、Manage及Monitor。其中Manage為管理方面的功能如使用者(User)、群組(Groups)、應用程式註冊(App registration)等；Monitor則為監控相關的功能設定。

![image-20200916230850224](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200916230850224.png)

畫面下方也另外提供連結，可以快速建立使用者、群組、應用程式註冊等相關功能。

![image-20200916231547056](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200916231547056.png)

說明文件有提到：『Azure AD是 Microsoft 的雲端式身分識別和存取管理服務，可協助員工登入及存取Microsoft 365、Azure 入口網站和其他數千個 SaaS 應用程式等外部資源，及公司網路和內部網路上的應用程式，以及您自己的組織所開發的任何雲端應用程式。』意味著你可以利用AzureAD替你管理使用者資訊。

在同一個租用戶中，你可以建立不同的使用者及群組，甚至邀請已經有microsoft帳號的使用者到這個租用戶中，接下來建立一個新的使用者試試吧。按下Create系列中的User，直接進入新增使用者的畫面。

![image-20200917005111068](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917005111068.png)

進入後，可以選擇建立新的使用者或是邀請已有帳號的使用者加入，若要建立新使用者的話，至少要輸入User name及Name的資訊，看到Create按鈕變成藍色就可以按下並建立使用者。

建立完成後進入User中就可以看到新建立的使用者出現在列表中。

![image-20200917005559647](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917005559647.png)

若想要給該名使用者密碼，可以按Reset password，系統便會提供一個隨機密碼，該使用者用此密碼登入後，會要求修改密碼。

![image-20200917005834922](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917005834922.png)

![image-20200917010121176](https://raw.githubusercontent.com/HanInfinity/iron12th_Azure/master/uPic/image-20200917010121176.png)