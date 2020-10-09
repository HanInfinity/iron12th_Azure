# 說明

上一篇有提到 Let's Encrypt 的執行要素，如果開發的網站是建立在 Linux 或 Windows 伺服器的話，就可以依照要求在指定的路徑中加入指定的檔案名稱並建立對應的內容，這樣 Let's Encrypt 就可以抓到資訊，並生成憑證給你。但是建立在Azure 上的服務，像是 App Service 或是 Kubernetes Service 要怎麼做呢?第一種是建立對應的檔案後更新，但這會需要花一些時間，若這些服務有使用 Application Gateway 掛在最外層的話，可以參考本篇整合 Blob Storage 的方式 ！

本篇將介紹如何在建立Application Gateway時同時完成免費憑證申請所需的設定。在前面有稍微介紹到storage的功能，他是Azure 提供的類似雲端硬碟的服務，建立的檔案在權限足夠的情形下，也可以透過指定的路徑檢視。在前篇也有提到 Rule 中除了設定目標到Backend pool 及外部網路外，也可以建立 `path-based rule` 設定單一條件路徑下的重新導向功能，讓要求路徑為`.well-known/acme-challenge/`底下的頁面的流量，重新導向到 Blob storage 中。

因此在設定前，需先建立Blob Storage，並在其中建立名為 `public` 的 container 。建立完成後，到Properties 中找到Blob Service的路徑並複製下來。

![storage properties](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload8fe70ccb94c245a08c52bec88a08e29e.png)



在建立 Application Gateway 時，需先設定好一組連線，因此可以直接設定重新導向至blob的連線。先至[AAG列表](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Network%2FapplicationGateways)並按新增，依網頁提示建立Application Gateway：

設定Application Gateway基本資訊

![image-20201010011921535](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201010011921535.png)

設定Frontend IP，新增Public IP

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a3d1845f-c376-4653-bd85-76611bab36bf/92dcc9628e4b4e0ba438d856293cbf46.png](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload92dcc9628e4b4e0ba438d856293cbf46.png)

設定 Backend pool，按下新增後端集區

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b782718e-8f72-410e-9cd7-0065ab0c061d/735b66c9b0c24240b79a64afb0f149f8.png](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload735b66c9b0c24240b79a64afb0f149f8.png)

設定新增 Backend pool，若還沒有網站服務可以連接，可以先建立不含目標的後端集區。

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/0b6257bd-5054-4cc1-906e-c8131f60c86c/21653439dc004f98b1c6494bdb1286fd.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T173542Z&X-Amz-Expires=86400&X-Amz-Signature=645875260402033dfed05e2c8ee7b58ce5cbbdfb501efa5753ee902118b46ada&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%2221653439dc004f98b1c6494bdb1286fd.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload21653439dc004f98b1c6494bdb1286fd.png)

設定 Rule

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/42fa951b-8b5f-490a-a4ab-41169b37e1b4/aaa4aaaac4e5498faf980bcba7b56b2a.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T173713Z&X-Amz-Expires=86400&X-Amz-Signature=d067a9eca111376bebd578b5c49099f0629df4b107694d883404d3fa4c2a2cfc&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22aaa4aaaac4e5498faf980bcba7b56b2a.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadaaa4aaaac4e5498faf980bcba7b56b2a.png)

Rule串接`Listener`及`Backend`。首先建立接聽程式，設定完後按`後端目標`

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/c8de895a-e183-49f2-94d7-1bf311488132/0b01ca23d3e945579558c9a5f0091014.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T174156Z&X-Amz-Expires=86400&X-Amz-Signature=ff2b1f6541a48757dbdb6bab95eb3870eda1fbb7f7434382b7f6b49ee581f287&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%220b01ca23d3e945579558c9a5f0091014.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload0b01ca23d3e945579558c9a5f0091014.png)

設定後端目標，新增HTTP設定

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/70ec75be-9411-4bd8-a735-9fa488a7c65e/bf2beffc3a7348068e42f71e7fd2d2c3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T174244Z&X-Amz-Expires=86400&X-Amz-Signature=6723077ee8513a2da2b51945a8f915aa56a3dcb6c74945aeeb3c5ad4e3de8038&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22bf2beffc3a7348068e42f71e7fd2d2c3.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadbf2beffc3a7348068e42f71e7fd2d2c3.png)

HTTP設定基本上沒有太多設定，後端連接埠設為80即可，然後按下儲存。

這邊有一個設定為要求逾時(秒)，當有連線要求超過設定秒數的話，便會回傳502。因此如果有連線需要超過20秒的話，可以設定適合的秒數，以免連線時出現問題。

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/0d905548-4bb1-4e3c-a985-6b940dec1cdc/f5bded97fc864f48ab7dcef7f40d07e8.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T174312Z&X-Amz-Expires=86400&X-Amz-Signature=70c20b123c48a7a8c17ebe94c8ba067e9b73e1ba0d7fb45a9b2f82535825324d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22f5bded97fc864f48ab7dcef7f40d07e8.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadf5bded97fc864f48ab7dcef7f40d07e8.png)

跳回來後，按`新增多個目標來建立路徑式規則`

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/82460d26-f2c7-411a-aa42-36c517a97cf1/462e564008464c8fba9a9f393f6dd5df.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T174542Z&X-Amz-Expires=86400&X-Amz-Signature=5e5c2e6f9a4a9f730be126699a2f527c7acfa01024e4d545d591a15c9b2f9afc&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22462e564008464c8fba9a9f393f6dd5df.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload462e564008464c8fba9a9f393f6dd5df.png)

這邊就是設定讓cert bot 連線時，將流量導向至 Blob 的設定，這樣一來我們就可以直接將檔案更新到Blob上面，不必再經過版本更新、重新佈署，等待新版本建置完成才能完成憑證申請。設定時目標類型選擇`重新導向`，路徑設定`/.well-known/acme-challenge/*`，重新導向類型選擇`暫時`，目標為外部網站，目標URL為Blob網址加上容器名稱(如`https://tatamo.blob.core.windows.net/public`)。按下新增後回到後端目標畫面，再按一下新增建立路由規則。

![image-20201010014708511](C:\Users\hanin\AppData\Roaming\Typora\typora-user-images\image-20201010014708511.png)

完成之路由規則會長這樣

![image-20201010020702757](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201010020702757.png)

設定好的組態會長這樣，前端、路由規則及後端集區皆有設定完成。

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/f2f5a8f4-88b3-407d-9ec7-382c3da4d0c8/13bbebf75ddb4d72ae823a276f8ee610.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T180722Z&X-Amz-Expires=86400&X-Amz-Signature=30df19331d3361193af67e6ea37242e3ceddd6ad9cfc1bcbee6251f24838430b&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%2213bbebf75ddb4d72ae823a276f8ee610.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload13bbebf75ddb4d72ae823a276f8ee610.png)

標籤不必設定的話，直接按下一步

![https://s3.us-west-2.amazonaws.com/secure.notion-static.com/9fb3e900-9fc2-4f82-8cfa-888dbd76cc55/6f19e0fece4a4c1cbe312e6760395876.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20201009%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201009T180754Z&X-Amz-Expires=86400&X-Amz-Signature=5fd1730473dda1b9fd9c9240dc9f5f2ab28ea860094bd1011959d60ce9ced90b&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%226f19e0fece4a4c1cbe312e6760395876.png%22](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_upload6f19e0fece4a4c1cbe312e6760395876.png)

在檢閱+建立畫面，若驗證成功，則可以按下建立，等待Application Gateway建立完成。

![image-20201010020909105](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201010020909105.png)

# 總結

本篇為集結前面幾篇的知識，在了解到storage的特性、Applicatoin Gateway主要功能的說明及Let’s Encrypt的申請方式後，建立一個可直接申請免費憑證的Application Gateway服務。下篇將接續本篇建立的Application Gateway，說明申請免費憑證後，如何轉換成Azure所需的憑證類型並建立HTTPS連線。



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)