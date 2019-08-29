# MLSRequestDelegate Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSRequestProtocol.h  

## Overview

网络请求代理

## Tasks

### 

[&ndash;&nbsp;requestFinished:](#//api/name/requestFinished:)  

[&ndash;&nbsp;requestFailed:](#//api/name/requestFailed:)  

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/requestFailed:" title="requestFailed:"></a>
### requestFailed:

失败回调
查看错误信息 request.error

`- (void)requestFailed:(__kindof MLSBaseRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestFinished:" title="requestFinished:"></a>
### requestFinished:

请求完成（成功回调）

`- (void)requestFinished:(__kindof MLSBaseRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSRequestProtocol.h`

