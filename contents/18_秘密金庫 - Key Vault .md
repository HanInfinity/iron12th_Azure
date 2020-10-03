Azure Key Vault 顧名思義就是鑰匙的金庫，而在軟體開發中，密碼、連線資訊、token等就是應用程式的鑰匙，所以Azure Key Vault 出現的目的就是讓你的機敏資訊可以有一個安全地存放位置，讓應用程式使用URI安全地存取所需資訊。另外Azure Key Vault 也可以存放密鑰及憑證。

# 建立Azure Key Vault

同樣透過網站介面建立Azure Key Vault 。選擇resource group 並設定名稱及區域，按下`Review + create`後再按`Create`等待建立完成。

![image-20201003000317385](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003000317385.png)

建立後進入畫面，可以看到左側欄的`Settings`下方有`Keys`、`Secretes`及`Certificates`3個選項，分別提供存放這3種不同類型的機密資料，以下將逐一介紹。

![image-20201003225515262](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003225515262.png)

## Keys

在點進去Keys後，會看到這個Key Vault中存放的所有Key的列表，因為都沒有建立過，所以會看到是空的。此時按一下左上角的`Generate/Import`來建立或匯入Key形式的資料。

![image-20201003225942891](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003225942891.png)

建立Key頁面如下，如果是要生成新的key，選Generate，若是要將已建立的key存放在Key Vault上，則選擇Import，並選擇要上傳的檔案。這邊說明生成的流程，設定Name後，選擇key的類型及設定，RSA有2048、3072、4096等3種size可以選擇。

![image-20201003230113174](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003230113174.png)

EC則是P-256、P-384、P-251及P-256K等4種類型可以選擇。可再另外設定啟動日期及使用期限，還有是否要啟用，讓我們更加多元的方式管理key的使用。完成設定後按下Create，等待key的建立。

![image-20201003230509634](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003230509634.png)

回到列表後就可以看到我剛剛設定的ssh key已成功建立。

![image-20201003231049050](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003231049050.png)

## Secretes

進入Secretes一樣會看到這個Key Vault中存放的所有Secretes的列表，也因為都沒有建立過，所以會看到是空的。此時按一下左上角的`Generate/Import`來建立Secretes形式的資料。

![image-20201003231118474](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003231118474.png)

Secretes的形式是Name及Value，在應用程式的環境變數便是以Secrete的方式，其中k8s的config檔案也可以設定secrete，將yaml檔分成好幾個，方便管理不同類型的檔案。而上述提到的都可以將它們放在Key vault這個更安全的服務中，也更加易於管理所有的secrete資料。在填完Name及Value後按下Create即可。

> 在Upload options中還有另一個Certificate選項，這個選項現在已經分離出來成為另一個Certificate設定，未來應該也會拿掉。Certificate的部分直接在下一個項目繼續說明。

![image-20201003231840965](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003231840965.png)

建立後一樣可以看到列表中出現剛剛建立的secrete，點進去後還可以確認建立的value是否正確。

![image-20201003232421439](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003232421439.png)

## Certificates

進入Certificates一樣會看到這個Key Vault中存放的所有Certificates的列表，也會看到空的列表。此時按一下左上角的`Generate/Import`來建立或匯入Certificates形式的資料。

![image-20201003232821455](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201003232821455.png)

Certificate就是存放SSL憑證的資料，所需要的設定這邊也都可以操作，包含整合CA的憑證設定。在完成設定或是完成匯入後按下Create便可建立certificate資料。

# 總結

本篇主要介紹Key Vault的特性，並說明`Keys`、`Secretes`及`Certificates`等3種不同類型的建立方式。下一篇將介紹使用Python存取與寫入`Keys`、`Secretes`及`Certificates`的方法。



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)

