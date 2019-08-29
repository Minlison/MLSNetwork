# MLSRequestSubclassHolderProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSRequestProtocol.h  

## Overview

子类继承可实现的方法

## Tasks

### 

[&nbsp;&nbsp;baseUrl](#//api/name/baseUrl) *property* *required method*

[&nbsp;&nbsp;requestUrl](#//api/name/requestUrl) *property* *required method*

[&nbsp;&nbsp;cdnUrl](#//api/name/cdnUrl) *property* *required method*

[&nbsp;&nbsp;requestTimeoutInterval](#//api/name/requestTimeoutInterval) *property* *required method*

[&nbsp;&nbsp;requestMethod](#//api/name/requestMethod) *property* *required method*

[&nbsp;&nbsp;requestSerializerType](#//api/name/requestSerializerType) *property* *required method*

[&nbsp;&nbsp;responseSerializerType](#//api/name/responseSerializerType) *property* *required method*

[&nbsp;&nbsp;requestAuthorizationHeaderFieldDictionary](#//api/name/requestAuthorizationHeaderFieldDictionary) *property* *required method*

[&nbsp;&nbsp;requestHeaderFieldValueDictionary](#//api/name/requestHeaderFieldValueDictionary) *property* *required method*

[&nbsp;&nbsp;acceptableContentTypes](#//api/name/acceptableContentTypes) *property* *required method*

[&nbsp;&nbsp;useCDN](#//api/name/useCDN) *property* *required method*

[&nbsp;&nbsp;allowsCellularAccess](#//api/name/allowsCellularAccess) *property* *required method*

[&ndash;&nbsp;requestCompletePreprocessor](#//api/name/requestCompletePreprocessor)  *required method*

[&ndash;&nbsp;requestCompleteFilter](#//api/name/requestCompleteFilter)  *required method*

[&ndash;&nbsp;requestFailedPreprocessor](#//api/name/requestFailedPreprocessor)  *required method*

[&ndash;&nbsp;requestFailedFilter](#//api/name/requestFailedFilter)  *required method*

[&ndash;&nbsp;requestArgument](#//api/name/requestArgument)  *required method*

[&ndash;&nbsp;requestQueryArgument](#//api/name/requestQueryArgument)  *required method*

[&ndash;&nbsp;cacheFileNameFilterForRequestArgument:](#//api/name/cacheFileNameFilterForRequestArgument:)  *required method*

[&ndash;&nbsp;queryStringSerializationRequest:param:error:](#//api/name/queryStringSerializationRequest:param:error:)  *required method*

[&ndash;&nbsp;buildCustomUrlRequest](#//api/name/buildCustomUrlRequest)  *required method*

[&ndash;&nbsp;jsonValidator](#//api/name/jsonValidator)  *required method*

[&ndash;&nbsp;statusCodeValidator:](#//api/name/statusCodeValidator:)  *required method*

## Properties

<a name="//api/name/acceptableContentTypes" title="acceptableContentTypes"></a>
### acceptableContentTypes

可接收 Content-Type

`@property (nonatomic, strong) NSSet&lt;NSString*&gt; *acceptableContentTypes`

#### Discussion
Content-Types

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/allowsCellularAccess" title="allowsCellularAccess"></a>
### allowsCellularAccess

是否允许蜂窝网络
默认是 YES

`@property (nonatomic, assign) BOOL allowsCellularAccess`

#### Return Value
是否允许蜂窝网络访问

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/baseUrl" title="baseUrl"></a>
### baseUrl

网络请求 URL
该 URL 的优先级高于 Configuation 的优先级
根 URL 类似 <a href="http://www.baidu.com">http://www.baidu.com</a>
网络请求 URL

`@property (nonatomic, copy) NSString *baseUrl`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/cdnUrl" title="cdnUrl"></a>
### cdnUrl

CDN 地址

`@property (nonatomic, copy) NSString *cdnUrl`

#### Discussion
CDN 地址

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestAuthorizationHeaderFieldDictionary" title="requestAuthorizationHeaderFieldDictionary"></a>
### requestAuthorizationHeaderFieldDictionary

请求头授权

`@property (nonatomic, strong) NSDictionary *requestAuthorizationHeaderFieldDictionary`

#### Discussion
  授权内容

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestHeaderFieldValueDictionary" title="requestHeaderFieldValueDictionary"></a>
### requestHeaderFieldValueDictionary

请求头

`@property (nonatomic, strong) NSDictionary *requestHeaderFieldValueDictionary`

#### Discussion
请求头参数字典

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestMethod" title="requestMethod"></a>
### requestMethod

HTTP Method

`@property (nonatomic, assign) MLSRequestMethod requestMethod`

#### Discussion
  请求方法

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestSerializerType" title="requestSerializerType"></a>
### requestSerializerType

请求解析类型

`@property (nonatomic, assign) MLSRequestSerializerType requestSerializerType`

#### Discussion
请求的参数解析类型

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestTimeoutInterval" title="requestTimeoutInterval"></a>
### requestTimeoutInterval

超时时长

`@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval`

#### Discussion
超时时长 单位 秒

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestUrl" title="requestUrl"></a>
### requestUrl

二级地址
如果要请求的地址为 <a href="http://www.baidu.com/api/user">http://www.baidu.com/api/user</a>
则 baseUrl 为 <a href="http://www.baidu.com">http://www.baidu.com</a>
requestUrl 为 /api/user

`@property (nonatomic, copy) NSString *requestUrl`

#### Discussion
二级地址

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/responseSerializerType" title="responseSerializerType"></a>
### responseSerializerType

响应内容解析类型

`@property (nonatomic, assign) MLSResponseSerializerType responseSerializerType`

#### Discussion
解析类型

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/useCDN" title="useCDN"></a>
### useCDN

是否使用 CDN

`@property (nonatomic, assign) BOOL useCDN`

#### Discussion
YES 使用 NO 不使用

#### Declared In
* `MLSRequestProtocol.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/buildCustomUrlRequest" title="buildCustomUrlRequest"></a>
### buildCustomUrlRequest

自定义构建一个 URLRequest
如果该方法返回不为空 <a href="#//api/name/requestUrl"><code>requestUrl</code></a>, <a href="#//api/name/requestTimeoutInterval"><code>requestTimeoutInterval</code></a>, <a href="#//api/name/requestArgument"><code>requestArgument</code></a>, <a href="#//api/name/allowsCellularAccess"><code>allowsCellularAccess</code></a>, <a href="#//api/name/requestMethod"><code>requestMethod</code></a> and <a href="#//api/name/requestSerializerType"><code>requestSerializerType</code></a> 方法都不会调用

`- (nullable NSURLRequest *)buildCustomUrlRequest`

#### Return Value
自定义 URLRequest

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/cacheFileNameFilterForRequestArgument:" title="cacheFileNameFilterForRequestArgument:"></a>
### cacheFileNameFilterForRequestArgument:

缓存的文件名，或者 key

`- (id)cacheFileNameFilterForRequestArgument:(id)*argument*`

#### Parameters

*argument*  
&nbsp;&nbsp;&nbsp;请求参数  

#### Return Value
缓存的文件名或者 key

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/jsonValidator" title="jsonValidator"></a>
### jsonValidator

JSON 校验
用来校验，JSON 格式是否正确
return @{
@&ldquo;userId&rdquo;: [NSNumber class],
@&ldquo;nick&rdquo;: [NSString class],
@&ldquo;level&rdquo;: [NSNumber class]
};

`- (nullable id)jsonValidator`

#### Return Value
校验 JSON

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/queryStringSerializationRequest:param:error:" title="queryStringSerializationRequest:param:error:"></a>
### queryStringSerializationRequest:param:error:

对一个请求进行参数排列

`- (nullable NSString *)queryStringSerializationRequest:(NSURLRequest *)*request* param:(NSDictionary *)*param* error:(NSError **)*error*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

*param*  
&nbsp;&nbsp;&nbsp;参数  

*error*  
&nbsp;&nbsp;&nbsp;错误  

#### Return Value
排列后的参数

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestArgument" title="requestArgument"></a>
### requestArgument

参数

`- (nullable id)requestArgument`

#### Return Value
参数 NSDictionary

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestCompleteFilter" title="requestCompleteFilter"></a>
### requestCompleteFilter

网络请求成功后，会调用该方法（主线程）

`- (void)requestCompleteFilter`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestCompletePreprocessor" title="requestCompletePreprocessor"></a>
### requestCompletePreprocessor

在网络请求完成，没有回调到主线程之前，会调用该方法
如果是从缓存中获取的内容，则会在主线程中调用该方法，相当于 <a href="#//api/name/requestCompleteFilter"><code>requestCompleteFilter</code></a>
如果返回 NO， 则不会调用 <a href="#//api/name/requestCompleteFilter">requestCompleteFilter</a> 方法，该网络请求不会结束

`- (BOOL)requestCompletePreprocessor`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestFailedFilter" title="requestFailedFilter"></a>
### requestFailedFilter

网络请求失败调用
类似 <a href="#//api/name/requestCompleteFilter"><code>requestCompleteFilter</code></a>.

`- (void)requestFailedFilter`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestFailedPreprocessor" title="requestFailedPreprocessor"></a>
### requestFailedPreprocessor

网络请求失败调用
类似 <a href="#//api/name/requestCompletePreprocessor"><code>requestCompletePreprocessor</code></a>.

`- (BOOL)requestFailedPreprocessor`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestQueryArgument" title="requestQueryArgument"></a>
### requestQueryArgument

拼接到url中的参数，主要针对 非GET请求，url拼接参数使用

`- (nullable NSDictionary *)requestQueryArgument`

#### Return Value
参数 NSDictionary

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/statusCodeValidator:" title="statusCodeValidator:"></a>
### statusCodeValidator:

响应代码校验

`- (BOOL)statusCodeValidator:(NSError **)*error*`

#### Return Value
StatusCode 是否正确，如果返回 NO ，则进行错误回调

#### Declared In
* `MLSRequestProtocol.h`

