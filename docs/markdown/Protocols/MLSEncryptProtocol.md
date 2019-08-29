# MLSEncryptProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkConfig.h  

## Overview

加密解密协议，只针对网络数据，全部加解密处理，如果需要对返回的某个字段进行加解密，请在外部处理

## Tasks

### 

[+&nbsp;encryptSubmitParam:](#//api/name/encryptSubmitParam:)  *required method*

[+&nbsp;decryptServerData:](#//api/name/decryptServerData:)  *required method*

[+&nbsp;encryptSubmitData:](#//api/name/encryptSubmitData:)  *required method*

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/decryptServerData:" title="decryptServerData:"></a>
### decryptServerData:

解密服务器返回的数据

`+ (NSData *)decryptServerData:(NSData *)*data*`

#### Parameters

*data*  
&nbsp;&nbsp;&nbsp;服务器返回的加密数据  

#### Return Value
解密后的数据 (NSData)

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/encryptSubmitData:" title="encryptSubmitData:"></a>
### encryptSubmitData:

加密数据数据

`+ (NSData *)encryptSubmitData:(NSData *)*data*`

#### Parameters

*data*  
&nbsp;&nbsp;&nbsp;加密前s的数据  

#### Return Value
加密后的数据 (NSData)

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/encryptSubmitParam:" title="encryptSubmitParam:"></a>
### encryptSubmitParam:

加密参数

`+ (NSDictionary *)encryptSubmitParam:(NSDictionary *)*param*`

#### Parameters

*param*  
&nbsp;&nbsp;&nbsp;参数  

#### Return Value
加密后的参数

#### Declared In
* `MLSNetworkConfig.h`

