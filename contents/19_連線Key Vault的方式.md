# 說明

上篇已說明Key Vault 中的三個存放的類型：`Keys`、`Secretes`及`Certificates`，本篇將繼續說明如何透過安全驗證的方式連線到Key Vault，並存取資訊。

# 存取方式

Key Vault中的三種類型在運用的情境不同，所以存取的方式也會不同。`Keys`通常用於SSH連線時取代帳號密碼，如果您有接觸過 Git 平台如 GitHub、GitLab、Bitbucket等，或是 Azure DevOps 等開發平台，也會接觸到SSH設定，透過本機端生成一對密鑰，將公開密鑰提供給平台後，要使用git時就不必再輸入帳號密碼。

開發應用程式或是網站時，會設定許多機敏資訊，這些資訊若直接跟程式碼放一起的話，一個不小心被駭客進入，找到程式碼也找到機敏資料。要是這些資料又包含AWS或是Azure的連線驗證資訊，那你的AWS或是Azure帳戶很有可能就被駭客用來建立挖礦機，付錢讓他躺著賺。所以建立生產環境時，都會將機敏資訊以`Secretes`的( Name, Value )形式存放在其他只提供網站存取權限的地方，防止被有心人士取用。

`Certificates`多數用在SSL 憑證資訊，要使用HTTPS的話，需要有一個合格的憑證才會生效。以下將說明各項資料類型的存取方式。

## Python 程式碼範例說明

本篇透過Python的存取方式為AD Secrete驗證，官方建議僅於開發測試時使用，正式產品環境建議使用憑證或是MSI方式進行驗證。以下介紹Python程式碼時，會使用Jupyter Notebook執行，相關成果也會放在網路上提供參考。

在設定環境變數前，需先將AAD加入到 Key Vault 的 access policy 中，該AAD才能夠存取Key Vault 的資訊。進入 Key Vault 畫面後，按一下 Access policies 並按 `+Add Access Policy`。

![image-20201004154826133](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201004154826133.png)

Configure from template選擇 `Keys, Secretes & Certificates Management`，接著選擇 principal 資訊，搜尋建立的AAD資料後按下select，最後按一下Add完成建立。

![image-20201004155040476](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201004155040476.png)

建立後需到剛剛選擇的AAD畫面，取得 `tenant_id`、`client_id `及 `client_secret`，寫到環境變數中。

`tenant_id`、`client_id `從下圖複製：

![image-20201004155455452](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201004155455452.png)

`client_secret`則是到 `Certificate & secretes` 中，按 `+ New client secret` 並命名後，下方會出現一列新的secret，按一下 copy 的 icon複製資訊。

![image-20201004155606428](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201004155606428.png)

使用python存取資訊前，先在`.env`中設定環境變數，並讀取資訊。

```makefile
# .env
TENANT_ID=*****
CLIENT_ID=********
CLIENT_SECRETE=*******
```

```python
import os
from dotenv import load_dotenv

load_dotenv()
tenant_id = os.environ["TENANT_ID"]                      ## AZURE TENANT ID
client_id = os.environ["CLIENT_ID"]                      ## CLIENT ID OF YOUR SERVICE PRINCIPAL
client_secret = os.environ["CLIENT_SECRETE"]             ##  CLIENT SECRET OF YOUR SERVICE PRINCIPAL
vault_name = "tatamo"

# 建立ClientSecretCredential，後面的client都需要此token建立。
token = ClientSecretCredential(tenant_id=tenant_id, client_id=client_id, client_secret=client_secret)
```

## Keys

### 使用Azure Cloud Shell  存取Keys

您可以在Azure portal 網站中開啟Azure Cloud Shell 來執行指令建立與存取Keys。

![image-20200928224549639](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20200928224549639.png)

同樣也可以用 Azure Cloud Shell 建立新的 KeyVault 。上一篇建立的 Key Vault 若轉成 Azure Cloud Shell 的話會像這個樣子：

```powershell
New-AzKeyVault -Name 'Tatamo' -ResourceGroupName 'Tatamo' -Location 'Southeast Asia'
```

建立 Key 的方式也很簡單：

```powershell
Add-AzKeyVaultKey -VaultName 'Tatamo' -Name 'ssh' -Destination 'Software'
```

存取Key的資訊如下：

```powershell
Get-AzKeyVaultKey -VaultName 'Tatamo' -KeyName 'ssh'
```

此時會收到回應的訊息

![image-20201004142437691](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201004142437691.png)

### 使用Python 存取Keys

以下利用 python 取得我在Key Vault 中存放的 key ，並回傳 key 的名稱。

```python
from azure.keyvault.keys import KeyClient

# 建立Key Client
key_client = KeyClient(vault_url=f"https://{vault_name}.vault.azure.net/", credential=token)

key = key_client.get_key("ssh")
print(key.name)
```

我的Key名稱設定為 ssh，所以輸出的 `key.name`也會是ssh。

其他有關key的相關範例，可以參考[這裡](https://docs.microsoft.com/zh-tw/python/api/overview/azure/keyvault-keys-readme?view=azure-python#examples)

## Secretes

### 使用Azure Cloud Shell  存取 Secretes

透過 Azure Cloud Shell 建立新的 secrete `ExamplePassword`，value 為 `hVFkk965BuUv`。

```powershell
$secretvalue = ConvertTo-SecureString 'hVFkk965BuUv' -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName 'Tatamo' -Name 'ExamplePassword' -SecretValue $secretvalue
```

使用以下指令可以存取 `ExamplePassword`的資訊。

```powershell
(Get-AzKeyVaultSecret -vaultName "Tatamo" -name "ExamplePassword").SecretValueText
```

此時收到回傳的字串為`hVFkk965BuUv`。

### 使用Python 存取 Secretes

接下來使用python 程式碼存取剛剛利用 Azure Cloud Shell 建立的 `ExamplePassword`。

```python
from azure.keyvault.secrets import SecretClient

secret_name = "ExamplePassword"

# 建立SecretClient
client = SecretClient(vault_url=vault_url, credential=token)

# 取得名為 secret_name 的內容
secret = client.get_secret(secret_name)

# 輸出secret.value
print(secret.value)
```

同樣會取得輸出的字串為`hVFkk965BuUv`。

其他有關secrete的相關python範例，可以參考[這裡](https://docs.microsoft.com/zh-tw/azure/key-vault/secrets/quick-create-python?tabs=cmd#save-a-secret)

## Certificates
### 使用Azure Cloud Shell  存取 Certificates
首先建立 Policy

```powershell
$Policy = New-AzKeyVaultCertificatePolicy -SecretContentType "application/x-pkcs12" -SubjectName "CN=contoso.com" -IssuerName "Self" -ValidityInMonths 6 -ReuseKeyOnRenewal
```

接著利用 Policy 建立名為 `ExampleCertificate` 的憑證資料。

```powershell
Add-AzKeyVaultCertificate -VaultName "Tatamo" -Name "ExampleCertificate" -CertificatePolicy $Policy
```

使用以下指令存取剛剛建立的憑證資料：

```powershell
Get-AzKeyVaultCertificate -VaultName "Tatamo" -Name "ExampleCertificate"
```

![image-20201004153343060](https://raw.githubusercontent.com/HanInfinity/MDnoteImg/master/typora_uploadimage-20201004153343060.png)



### 使用Python 存取 Certificates

接下來使用python 程式碼存取剛剛利用 Azure Cloud Shell 建立的 `ExampleCertificate`，並設定輸出名稱。

```python
from azure.keyvault.certificates import CertificateClient

certificateName = "ExampleCertificate"

client = CertificateClient(vault_url=vault_url, credential=token)
retrieved_certificate = client.get_certificate(certificateName)

print(retrieved_certificate.name)
```

取得輸出的名稱一樣是`ExampleCertificate`。

相關certificates程式碼可以參考[這裡](https://docs.microsoft.com/zh-tw/azure/key-vault/certificates/quick-create-python?tabs=cmd#create-the-sample-code)

# 總結

本篇介紹透過 Azure Cloud Shell 來建立與存取 `Keys`、`Secretes`及`Certificates` 的資訊，以及使用 Python 讀取資訊。Python 程式碼使用Jupyter Notebook 執行，可以前往此處參考。Python的存取方式為AD Secrete驗證，官方建議僅於開發測試時使用，正式產品環境還是建議使用憑證或是MSI方式進行驗證會更加安全。

---

★ **Amos3.0 團隊系列文** ★  

以下為團隊所有成員的主題，也歡迎大家前往欣賞喔！

- CSScoke - [金魚都能懂的Bootstrap5網頁框架開發](https://ithelp.ithome.com.tw/users/20112550/ironman/3796)  
- King Tzeng - [【去年我得了IoT組冠軍!?】寫書教戰手冊＆IoT沒那麼難！新手用JavaScript入門做自己的玩具，實作影片化決定！](https://ithelp.ithome.com.tw/users/20103130/ironman/3712)  
- Clarence - [用 CDK 定義 AWS 架構](https://ithelp.ithome.com.tw/users/20117701/ironman/3734)  
- Vita Ora - [為自己而寫，前端工程師之 30 天心得分享](https://ithelp.ithome.com.tw/users/20112656/ironman/3799)  
- 塔塔默 - [用Azure建立一條龍的服務](https://ithelp.ithome.com.tw/users/20112552/ironman/3823)