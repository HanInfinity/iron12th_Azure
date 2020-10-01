今天來介紹幾個我在PGAdmin中比較常用的幾個功能。

# 建立使用者

在PGAdmin中可以建立其他使用者連線此資料庫，這樣就不需要提供admin帳號給其他同事或是廠商，避免最高權限的帳號外流導致資料庫資安問題。在連線資訊中包含`Databases`、`Login/Group Roles`及`Tablespaces`。點開`Login/Group Roles`可以看到已建立的使用者及群組。對`Login/Group Roles`按右鍵並選擇Create > Login/Group Roles。然後設定名稱、密碼，並設定可以為登入。

![image-20201001215051298](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001215051298.png)

![image-20201001215215192](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001215215192.png)

![image-20201001215225510](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001215225510.png)

![image-20201001215305656](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001215305656.png)

接著用此帳號密碼便可以登入。

![image-20201001220105765](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001220105765.png)

列表新增連線表示有成功登入了!

![image-20201001220147500](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001220147500.png)

# 介面操作

PostgreSQL的Database中可建立好幾個Schema，一般預設都是public，public中包含許多項目，其中最常使用的是Tables 及 Sequences。其中Tables紀錄表格資料；Sequences紀錄每個表格的計數。

當Table有建立時，可以對table按右鍵檢視資訊

![image-20201001221309666](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001221309666.png)

進入後若想要篩選，可以在上方的功能列表中找到Sort/Filter。

![image-20201001221528256](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001221528256.png)

可以在`SQL Filter`區塊中輸入篩選條件。若要設定排序，可以按Data Sorting右邊的 `+`新增並選擇排序的欄位，以及升冪降冪。

![image-20201001221632115](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001221632115.png)

# Query Tool

我也常用Query Tool 取得我要的資訊，因為資料庫經過正規化後，有時需要資料並不是全部都在單一Table中，使用query tool可以直接取得整理後的資料，相當方便。

先找到要執行query tool的database，然後按下Query Tool的按鈕。接著會跳出新的頁籤，頁籤中可以輸入query 指令，並按下`F5`執行指令。

![image-20201001222911579](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001222911579.png)

#  備份還原

點選想要備份的database、schema或table，並對他按右鍵選擇`backup`，設定檔案位置後即可進行備份。

![image-20201001223059089](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001223059089.png)

另外可以選擇Plain Format，可輸出可修改的sql檔案。

![image-20201001223454763](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001223454763.png)

也可以設定輸出的內容，裡面有許多選項可以設定。包含只輸出資料或schema，指令包含drop table等等。

![image-20201001223607528](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201001223607528.png)

# 結論

今天簡單介紹我在PGAdmin常用的項目，PGAdmin上還有許多實用的功能，如果有想要了解的也歡迎在下面提出喔！


---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)