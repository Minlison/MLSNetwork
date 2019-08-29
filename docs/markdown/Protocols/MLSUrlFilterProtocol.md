# MLSUrlFilterProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkConfig.h  

## Overview

url 过滤协议
在每个网络请求发送前，都会调用改方法，用来对网络请求增加一些公共参数

## Tasks

### 

[&ndash;&nbsp;filterUrl:withRequest:](#//api/name/filterUrl:withRequest:)  

[&ndash;&nbsp;filterParams:withRequest:](#//api/name/filterParams:withRequest:)  

[&ndash;&nbsp;filterHeaderFieldValue:withRequest:](#//api/name/filterHeaderFieldValue:withRequest:)  

[&ndash;&nbsp;filterAuthorizationHeaderFieldValue:withRequest:](#//api/name/filterAuthorizationHeaderFieldValue:withRequest:)  

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/filterAuthorizationHeaderFieldValue:withRequest:" title="filterAuthorizationHeaderFieldValue:withRequest:"></a>
### filterAuthorizationHeaderFieldValue:withRequest:

  授权过滤

`- (BOOL)filterAuthorizationHeaderFieldValue:(NSMutableDictionary&lt;NSString*,NSString*&gt; *)*authorizationHeaderFieldValue* withRequest:(MLSBaseRequest *)*request*`

#### Parameters

*authorizationHeaderFieldValue*  
&nbsp;&nbsp;&nbsp;授权 username  password  

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Return Value
是否修改过 ，如果修改过，则返回 YES， 否则返回 NO

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/filterHeaderFieldValue:withRequest:" title="filterHeaderFieldValue:withRequest:"></a>
### filterHeaderFieldValue:withRequest:

过滤请求头

`- (BOOL)filterHeaderFieldValue:(NSMutableDictionary&lt;NSString*,NSString*&gt; *)*originHeaderFieldValue* withRequest:(MLSBaseRequest *)*request*`

#### Parameters

*originHeaderFieldValue*  
&nbsp;&nbsp;&nbsp;原始请求头，可变字典，可以直接增加或者删除参数  

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Return Value
是否修改过参数，如果修改过，则返回 YES， 否则返回 NO

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/filterParams:withRequest:" title="filterParams:withRequest:"></a>
### filterParams:withRequest:

  过滤参数

`- (id)filterParams:(id)*originParams* withRequest:(MLSBaseRequest *)*request*`

#### Parameters

*originParams*  
&nbsp;&nbsp;&nbsp;原始参数  

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Return Value
返回修改过后的参数

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/filterUrl:withRequest:" title="filterUrl:withRequest:"></a>
### filterUrl:withRequest:

在网络请求发送前，对 request 进行解析

`- (NSString *)filterUrl:(NSString *)*originUrl* withRequest:(MLSBaseRequest *)*request*`

#### Parameters

*originUrl*  
&nbsp;&nbsp;&nbsp;原 url  

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Return Value
新的 url ，如果 url 本身不拼接参数，直接返回 originUrl

#### Declared In
* `MLSNetworkConfig.h`

