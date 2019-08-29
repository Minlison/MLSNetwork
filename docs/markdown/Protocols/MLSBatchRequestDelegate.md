# MLSBatchRequestDelegate Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSBatchRequest.h  

## Overview

批量请求

## Tasks

### 

[&ndash;&nbsp;batchRequestFinished:](#//api/name/batchRequestFinished:)  

[&ndash;&nbsp;batchRequestFailed:](#//api/name/batchRequestFailed:)  

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/batchRequestFailed:" title="batchRequestFailed:"></a>
### batchRequestFailed:

批量请求失败

`- (void)batchRequestFailed:(MLSBatchRequest *)*batchRequest*`

#### Parameters

*batchRequest*  
&nbsp;&nbsp;&nbsp;批量请求  

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/batchRequestFinished:" title="batchRequestFinished:"></a>
### batchRequestFinished:

批量请求成功

`- (void)batchRequestFinished:(MLSBatchRequest *)*batchRequest*`

#### Parameters

*batchRequest*  
&nbsp;&nbsp;&nbsp;批量请求  

#### Declared In
* `MLSBatchRequest.h`

