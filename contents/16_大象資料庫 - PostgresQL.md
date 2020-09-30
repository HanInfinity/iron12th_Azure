PostgreSQL 資料庫是我研究所開始最常使用到的資料庫。原因是當時都在做GIS服務，想要建立一個圖資資料庫。查詢後得知PostgreSQL的存在，並利用他建立了圖資資料庫，管理研究室的GIS圖資。直到兼任GIS工程師時，也是利用PostgreSQL建立圖資系統，另外開發Django網頁時，後端的資料庫也是使用他。甚至轉職當軟體開發工程師所接的案子也是使用他，可見我與他非常有緣!

其實我一直很在意他的念法，在我開始看到他時就確定念法為`Post-Gres-Q-L`，官方[wiki](https://wiki.postgresql.org/wiki/FAQ/zh-hant)也有提供念法的mp3檔，下次身邊有人念錯的話，放給他聽吧！

# 建立PostgreSQL服務

我在Azure上建立與使用PostgreSQL服務主要都是透過PGAdmin來連接資料庫並完成相關操作，因此這篇文章會以PGAdmin來示範連線及資料庫操作。

建立服務的方式一樣，只是在進入後會要你選擇類型。這邊只是要建立單一server，所以按左上角的區塊的`Create`即可。

![image-20200930232710575](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200930232710575.png)

設定resource group、server name等資訊，在規格的部分可以做調整，按一下下圖中紅框的連結。

![image-20200930233022418](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200930233022418.png)

可以自行選擇類型及規格，右邊還有預算提供參考。

![image-20201001000008042](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001000008042.png)

最後是admin的帳號密碼，輸入後要記著，等一下連線會使用到。填寫完畢後按`Review + create`便開始建立服務。

# 連線PostgreSQL服務

官方提供多種安裝方式，若還沒有PGAdmin的話請先參考[這邊](https://www.pgadmin.org/download/)完成安裝，然後進入PGAdmin。登入後若看到下圖的畫面，代表已經成功進來啦，按下`Add New Server`與剛剛建立的PostgreSQL server連線吧！

![image-20201001003929834](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001003929834.png)

首先需要取得一些資訊：`hostname`、`username`，這些都可以在Azure網站上找到。`password`是剛剛紀錄的，先進入網頁將剩下的`hostname`、`username`資訊找出來，進入PostgreSQL畫面後就可以看到了！將下圖紅框的資訊記錄下來。若是忘記密碼也別緊張，左上角有一個鉛筆的icon就是Reset password，按下去之後再把生成的密碼記起來。

![image-20201001004434812](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001004434812.png)

回到PGAdmin，按下`Add New Server`後會跳出小視窗要你輸入連線資訊，需要填寫`General`及`Connection`2個頁籤。以下為`General`頁籤，只要設定好顯示的名稱即可。若想要放在不同的group或是設定不同顏色也可以在這邊完成。

![image-20201001004749093](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001004749093.png)

接下來是`Connection`頁籤。將剛剛複製的`hostname`、`username`及之前記的`password`個別填入即可。

![image-20201001004851749](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001004851749.png)

完成後按下`Save`......怎麼沒辦法連??

是因為被防火牆擋在外面了!!

![image-20201001005307283](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001005307283.png)

回到Azure網頁，進入Connection security，設定`ALLOW_ALL`參數及IP範圍，這邊是開放所有IP，若你要僅限開放部分IP也可以自行設定。設定完後，按一下`Save`，等待更新完成。

![image-20201001005700875](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001005700875.png)

回到PGAdmin，再按一下`Save`，就會看到列表出現剛剛建立的連線囉!!可以看到server中已內建3個database，下一篇將繼續介紹PGAdmin的使用方法。

![image-20201001010017988](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001010017988.png)


---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)