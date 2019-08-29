# MLSChainRequestDelegate Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSChainRequest.h  

## Overview

链式请求代理

## Tasks

### 

[&ndash;&nbsp;chainRequestFinished:](#//api/name/chainRequestFinished:)  

[&ndash;&nbsp;chainRequestFailed:failedBaseRequest:](#//api/name/chainRequestFailed:failedBaseRequest:)  

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/chainRequestFailed:failedBaseRequest:" title="chainRequestFailed:failedBaseRequest:"></a>
### chainRequestFailed:failedBaseRequest:

请求失败

`- (void)chainRequestFailed:(MLSChainRequest *)*chainRequest* failedBaseRequest:(MLSBaseRequest *)*request*`

#### Parameters

*chainRequest*  
&nbsp;&nbsp;&nbsp;<a href="../Classes/MLSChainRequest.html">MLSChainRequest</a>  

*request*  
&nbsp;&nbsp;&nbsp;失败的 request  

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/chainRequestFinished:" title="chainRequestFinished:"></a>
### chainRequestFinished:

请求成功

`- (void)chainRequestFinished:(MLSChainRequest *)*chainRequest*`

#### Parameters

*chainRequest*  
&nbsp;&nbsp;&nbsp;<a href="../Classes/MLSChainRequest.html">MLSChainRequest</a>  

#### Declared In
* `MLSChainRequest.h`

