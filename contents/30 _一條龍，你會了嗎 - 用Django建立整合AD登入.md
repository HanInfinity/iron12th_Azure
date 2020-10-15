# 說明

本篇將繼續介紹使用django-social-auth設定整合Activate Directory方式，直接整合使用者系統，無痛建立使用者資料庫!!

# 安裝與設定

```bash
pip install social-auth-django
```

接著在`settings.py`中設定以下資訊：

```python
SOCIAL_AUTH_AZUREAD_OAUTH2_KEY = ''
SOCIAL_AUTH_AZUREAD_OAUTH2_SECRET = ''
SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID = ''
SOCIAL_AUTH_AZUREAD_OAUTH2_RESOURCE = 'https://graph.microsoft.com/'

AUTHENTICATION_BACKENDS = (
    ...
    'social_core.backends.azuread_tenant.AzureADTenantOAuth2',
    ...
)
```

其中`SOCIAL_AUTH_AZUREAD_OAUTH2_KEY`、`SOCIAL_AUTH_AZUREAD_OAUTH2_SECRET`、`SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID`的資訊取得方式已在上篇說明，`SOCIAL_AUTH_AZUREAD_OAUTH2_RESOURCE`可以設定其他microsoft提供的resource，最後是在`AUTHENTICATION_BACKENDS `中加入`'social_core.backends.azuread_tenant.AzureADTenantOAuth2'`。

完成後須執行`python manage.py migrate`，讓資料庫加入social-auth自訂的Table。

最後在HTML頁面中加入以下程式碼

```html
<a href="{% url "social:begin" "azuread-tenant-oauth2" %}">Azure AD login</a>
```

就會在頁面中看到`Azure AD login`的按鈕，按下去出現下列畫面就大功告成啦~~可以直接登入囉!!

![image-20201015174125065](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201015174125065.png)



# 結論

在前面已經介紹過了網站部屬的服務(AKS、App Service)、資料庫(PostgreSQL)、資料儲存(Storage)、容器(Container Registry)，基本上已經可以建立一個完整的網站了。再加上訊息推播(Notification hub)讓網站資訊可以與手機整合、訊息處理(Service Bus)提供非同步執行方式，提供更多元的服務設定。最後還有Key Vault、Application Gateway 賦予網站更安全的資訊放置位置，以及更安全的流量把關。透過對以上服務的了解，已經可以建立一條龍的網站服務了

稍微比對一下介紹過的服務與Azure上的服務，其實介紹過的還不到Azure 所有服務的一半，還有很多服務都還沒有接觸過，還有很多新的服務等待探索。或許明年再回頭來看這次寫的文章，還會有許多可以補充的地方，待明年的我經過一年的歷練，再來分享，本系列到這邊，下台一鞠躬，謝謝!!



---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)