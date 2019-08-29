# MLSBaseRequest Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Conforms to** <a href="../Protocols/MLSRequestSubclassHolderProtocol.html">MLSRequestSubclassHolderProtocol</a>  
&nbsp;&nbsp;**Declared in** MLSBaseRequest.h  

## Overview

网络请求基类

## Tasks

### Other Methods

[&nbsp;&nbsp;callbackQueue](#//api/name/callbackQueue) *property* 

[&nbsp;&nbsp;callbackOnAsyncQueue](#//api/name/callbackOnAsyncQueue) *property* 

[&nbsp;&nbsp;baseUrl](#//api/name/baseUrl) *property* 

[&nbsp;&nbsp;requestUrl](#//api/name/requestUrl) *property* 

[&nbsp;&nbsp;cdnUrl](#//api/name/cdnUrl) *property* 

[&nbsp;&nbsp;requestTimeoutInterval](#//api/name/requestTimeoutInterval) *property* 

[&nbsp;&nbsp;requestMethod](#//api/name/requestMethod) *property* 

[&nbsp;&nbsp;requestSerializerType](#//api/name/requestSerializerType) *property* 

[&nbsp;&nbsp;responseSerializerType](#//api/name/responseSerializerType) *property* 

[&nbsp;&nbsp;requestAuthorizationHeaderFieldDictionary](#//api/name/requestAuthorizationHeaderFieldDictionary) *property* 

[&nbsp;&nbsp;requestHeaderFieldValueDictionary](#//api/name/requestHeaderFieldValueDictionary) *property* 

[&nbsp;&nbsp;acceptableContentTypes](#//api/name/acceptableContentTypes) *property* 

[&nbsp;&nbsp;useCDN](#//api/name/useCDN) *property* 

[&nbsp;&nbsp;allowsCellularAccess](#//api/name/allowsCellularAccess) *property* 

[&nbsp;&nbsp;requestTask](#//api/name/requestTask) *property* 

[&nbsp;&nbsp;currentRequest](#//api/name/currentRequest) *property* 

[&nbsp;&nbsp;originalRequest](#//api/name/originalRequest) *property* 

[&nbsp;&nbsp;response](#//api/name/response) *property* 

[&nbsp;&nbsp;responseHeaderStatusCode](#//api/name/responseHeaderStatusCode) *property* 

[&nbsp;&nbsp;responseHeaders](#//api/name/responseHeaders) *property* 

[&nbsp;&nbsp;responseData](#//api/name/responseData) *property* 

[&nbsp;&nbsp;responseString](#//api/name/responseString) *property* 

[&nbsp;&nbsp;responseObject](#//api/name/responseObject) *property* 

[&nbsp;&nbsp;responseJSONObject](#//api/name/responseJSONObject) *property* 

[&nbsp;&nbsp;error](#//api/name/error) *property* 

[&nbsp;&nbsp;cancelled](#//api/name/cancelled) *property* 

[&nbsp;&nbsp;executing](#//api/name/executing) *property* 

[&nbsp;&nbsp;moudleIdentifier](#//api/name/moudleIdentifier) *property* 

[&nbsp;&nbsp;urlFilters](#//api/name/urlFilters) *property* 

[&nbsp;&nbsp;tag](#//api/name/tag) *property* 

[&nbsp;&nbsp;uuid](#//api/name/uuid) *property* 

[&nbsp;&nbsp;userInfo](#//api/name/userInfo) *property* 

[&nbsp;&nbsp;paramUniqueString](#//api/name/paramUniqueString) *property* 

[&nbsp;&nbsp;delegate](#//api/name/delegate) *property* 

[&nbsp;&nbsp;successCompletionBlock](#//api/name/successCompletionBlock) *property* 

[&nbsp;&nbsp;failureCompletionBlock](#//api/name/failureCompletionBlock) *property* 

[&nbsp;&nbsp;requestAccessories](#//api/name/requestAccessories) *property* 

[&nbsp;&nbsp;constructingBodyBlock](#//api/name/constructingBodyBlock) *property* 

[&nbsp;&nbsp;uploadProgress](#//api/name/uploadProgress) *property* 

[&nbsp;&nbsp;downloadProgress](#//api/name/downloadProgress) *property* 

[&nbsp;&nbsp;resumableDownloadPath](#//api/name/resumableDownloadPath) *property* 

[&nbsp;&nbsp;resumableDownloadProgressBlock](#//api/name/resumableDownloadProgressBlock) *property* 

[&nbsp;&nbsp;)](#//api/name/)) *property* 

[&ndash;&nbsp;setCompletionBlockWithSuccess:failure:](#//api/name/setCompletionBlockWithSuccess:failure:)  

[&ndash;&nbsp;clearCompletionBlock](#//api/name/clearCompletionBlock)  

[&ndash;&nbsp;addAccessory:](#//api/name/addAccessory:)  

[&ndash;&nbsp;removeAccessory:](#//api/name/removeAccessory:)  

[&ndash;&nbsp;addUrlFilter:](#//api/name/addUrlFilter:)  

[&ndash;&nbsp;removeUrlFilter:](#//api/name/removeUrlFilter:)  

[&ndash;&nbsp;start](#//api/name/start)  

[&ndash;&nbsp;stop](#//api/name/stop)  

[&ndash;&nbsp;startWithCompletionBlockWithSuccess:failure:](#//api/name/startWithCompletionBlockWithSuccess:failure:)  

### MLSParams Methods

[&ndash;&nbsp;requestFullParams](#//api/name/requestFullParams)  

### MLSRetry Methods

[&ndash;&nbsp;shouldRemoveFromAgent](#//api/name/shouldRemoveFromAgent)  

### RequestClear Methods

[&ndash;&nbsp;clearCacheVariables](#//api/name/clearCacheVariables)  

### RequestAccessory Methods

[&ndash;&nbsp;toggleAccessoriesWillStartcallback](#//api/name/toggleAccessoriesWillStartcallback)  

[&ndash;&nbsp;toggleAccessoriesWillStopcallback](#//api/name/toggleAccessoriesWillStopcallback)  

[&ndash;&nbsp;toggleAccessoriesDidStopcallback](#//api/name/toggleAccessoriesDidStopcallback)  

## Properties

<a name="//api/name/)" title=")"></a>
### )

请求级别

`@property (nonatomic) MLSRequestPriority requestPriority __IOS_AVAILABLE ( 8.0 )`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/acceptableContentTypes" title="acceptableContentTypes"></a>
### acceptableContentTypes

可接收 Content-Type

`@property (nonatomic, strong, nullable) NSMutableSet&lt;NSString*&gt; *acceptableContentTypes`

#### Discussion
Content-Types

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/allowsCellularAccess" title="allowsCellularAccess"></a>
### allowsCellularAccess

是否允许蜂窝网络
默认是 YES

`@property (nonatomic, assign) BOOL allowsCellularAccess`

#### Return Value
是否允许蜂窝网络访问

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/baseUrl" title="baseUrl"></a>
### baseUrl

网络请求 URL
该 URL 的优先级高于 Configuation 的优先级
根 URL 类似 <a href="http://www.baidu.com">http://www.baidu.com</a>
网络请求 URL

`@property (nonatomic, copy) NSString *baseUrl`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/callbackOnAsyncQueue" title="callbackOnAsyncQueue"></a>
### callbackOnAsyncQueue

是否在异步线程回调

`@property (nonatomic, assign) BOOL callbackOnAsyncQueue`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/callbackQueue" title="callbackQueue"></a>
### callbackQueue

回调线程
默认为 dispatch_get_main_queue()
<a href="#//api/name/callbackOnAsyncQueue">callbackOnAsyncQueue</a> 设置两个回调线程

`@property (nonatomic, assign, readonly) dispatch_queue_t callbackQueue`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/cancelled" title="cancelled"></a>
### cancelled

是否取消

`@property (nonatomic, readonly, getter=isCancelled) BOOL cancelled`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/cdnUrl" title="cdnUrl"></a>
### cdnUrl

CDN 地址

`@property (nonatomic, copy) NSString *cdnUrl`

#### Discussion
CDN 地址

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/constructingBodyBlock" title="constructingBodyBlock"></a>
### constructingBodyBlock

form 表单上传拼接数据

`@property (nonatomic, copy, nullable) AFConstructingBlock constructingBodyBlock`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/currentRequest" title="currentRequest"></a>
### currentRequest

  如果有重定向，则是重定向后的 request

`@property (nonatomic, strong, readonly) NSURLRequest *currentRequest`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/delegate" title="delegate"></a>
### delegate

代理

`@property (nonatomic, weak, nullable) id&lt;MLSRequestDelegate&gt; delegate`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/downloadProgress" title="downloadProgress"></a>
### downloadProgress

下载进度

`@property (nonatomic, copy, nullable) MLSRequestUploadProgressBlock downloadProgress`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/error" title="error"></a>
### error

错误描述

`@property (nonatomic, strong, readonly, nullable) NSError *error`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/executing" title="executing"></a>
### executing

是否正在执行

`@property (nonatomic, readonly, getter=isExecuting) BOOL executing`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/failureCompletionBlock" title="failureCompletionBlock"></a>
### failureCompletionBlock

失败回调

`@property (nonatomic, copy, nullable) MLSRequestCompletionBlock failureCompletionBlock`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/moudleIdentifier" title="moudleIdentifier"></a>
### moudleIdentifier

模块标识，用来回去 <a href="../Classes/MLSNetworkAgent.html">MLSNetworkAgent</a> 和 <a href="../Classes/MLSNetworkConfig.html">MLSNetworkConfig</a>
默认为空
如果要重新设置，请建立baseRequest，并返回对应模块标识

`@property (nonatomic, copy, nullable, readonly) NSString *moudleIdentifier`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/originalRequest" title="originalRequest"></a>
### originalRequest

请求如果有重定向，是重定向前的 request <a href="#//api/name/requestTask">requestTask</a>.originalRequest

`@property (nonatomic, strong, readonly) NSURLRequest *originalRequest`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/paramUniqueString" title="paramUniqueString"></a>
### paramUniqueString

参数的唯一字符串，如果是字典，则进行 key 排序后进行拼接

`@property (nonatomic, copy, readonly) NSString *paramUniqueString`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestAccessories" title="requestAccessories"></a>
### requestAccessories

网络请求监听器

`@property (nonatomic, strong, nullable) NSMutableArray&lt;id&lt;MLSRequestAccessory&gt; &gt; *requestAccessories`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestAuthorizationHeaderFieldDictionary" title="requestAuthorizationHeaderFieldDictionary"></a>
### requestAuthorizationHeaderFieldDictionary

请求头授权

`@property (nonatomic, strong, nullable) NSMutableDictionary *requestAuthorizationHeaderFieldDictionary`

#### Discussion
授权内容

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestHeaderFieldValueDictionary" title="requestHeaderFieldValueDictionary"></a>
### requestHeaderFieldValueDictionary

请求头

`@property (nonatomic, strong, nullable) NSMutableDictionary *requestHeaderFieldValueDictionary`

#### Discussion
请求头参数字典

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestMethod" title="requestMethod"></a>
### requestMethod

HTTP Method

`@property (nonatomic, assign) MLSRequestMethod requestMethod`

#### Discussion
请求方法

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestSerializerType" title="requestSerializerType"></a>
### requestSerializerType

请求解析类型

`@property (nonatomic, assign) MLSRequestSerializerType requestSerializerType`

#### Discussion
请求的参数解析类型

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestTask" title="requestTask"></a>
### requestTask

请求的 task

`@property (nonatomic, strong, readonly) NSURLSessionTask *requestTask`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestTimeoutInterval" title="requestTimeoutInterval"></a>
### requestTimeoutInterval

超时时长

`@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval`

#### Discussion
超时时长 单位 秒

#### Declared In
* `MLSBaseRequest.h`

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
* `MLSBaseRequest.h`

<a name="//api/name/response" title="response"></a>
### response

网络数据响应内容

`@property (nonatomic, strong, readonly) NSHTTPURLResponse *response`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseData" title="responseData"></a>
### responseData

响应数据

`@property (nonatomic, strong, readonly, nullable) NSData *responseData`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseHeaderStatusCode" title="responseHeaderStatusCode"></a>
### responseHeaderStatusCode

网络数据响应码

`@property (nonatomic, readonly) NSInteger responseHeaderStatusCode`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseHeaders" title="responseHeaders"></a>
### responseHeaders

响应头

`@property (nonatomic, strong, readonly, nullable) NSDictionary *responseHeaders`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseJSONObject" title="responseJSONObject"></a>
### responseJSONObject

JSON序列化后的数据，字典、数组、或者为空

`@property (nonatomic, strong, readonly, nullable) id responseJSONObject`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseObject" title="responseObject"></a>
### responseObject

序列化前的数据， 字符串、NSData

`@property (nonatomic, strong, readonly, nullable) id responseObject`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseSerializerType" title="responseSerializerType"></a>
### responseSerializerType

响应内容解析类型

`@property (nonatomic, assign) MLSResponseSerializerType responseSerializerType`

#### Discussion
解析类型

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/responseString" title="responseString"></a>
### responseString

响应字符串数据

`@property (nonatomic, strong, readonly, nullable) NSString *responseString`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/resumableDownloadPath" title="resumableDownloadPath"></a>
### resumableDownloadPath

继续下载的 resumeData 存放路径

`@property (nonatomic, strong, nullable) NSString *resumableDownloadPath`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/resumableDownloadProgressBlock" title="resumableDownloadProgressBlock"></a>
### resumableDownloadProgressBlock

下载进度回调

`@property (nonatomic, copy, nullable) AFURLSessionTaskProgressBlock resumableDownloadProgressBlock`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/successCompletionBlock" title="successCompletionBlock"></a>
### successCompletionBlock

完成回调（成功）

`@property (nonatomic, copy, nullable) MLSRequestCompletionBlock successCompletionBlock`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/tag" title="tag"></a>
### tag

标签

`@property (nonatomic) NSInteger tag`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/uploadProgress" title="uploadProgress"></a>
### uploadProgress

上传进度

`@property (nonatomic, copy, nullable) MLSRequestUploadProgressBlock uploadProgress`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/urlFilters" title="urlFilters"></a>
### urlFilters

网络请求过滤器
优先级高于 Config

`@property (nonatomic, strong, readonly, nullable) NSMutableArray&lt;id&lt;MLSUrlFilterProtocol&gt; &gt; *urlFilters`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/useCDN" title="useCDN"></a>
### useCDN

是否使用 CDN

`@property (nonatomic, assign) BOOL useCDN`

#### Discussion
YES 使用 NO 不使用

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/userInfo" title="userInfo"></a>
### userInfo

对当前 request 的描述信息，内部变量必须遵守 NSCoding 协议

`@property (nonatomic, strong, nullable) NSDictionary *userInfo`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/uuid" title="uuid"></a>
### uuid

唯一标识符
每个网络请求，只有一个 uuid， 根据时间戳，参数 md5 后的值

`@property (nonatomic, copy, readonly, nonnull) NSString *uuid`

#### Declared In
* `MLSBaseRequest.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addAccessory:" title="addAccessory:"></a>
### addAccessory:

添加网络请求监听器

`- (void)addAccessory:(id&lt;MLSRequestAccessory&gt;)*accessory*`

#### Parameters

*accessory*  
&nbsp;&nbsp;&nbsp;网络请求监听器  

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/addUrlFilter:" title="addUrlFilter:"></a>
### addUrlFilter:

增加一个请求过滤器

`- (void)addUrlFilter:(id&lt;MLSUrlFilterProtocol&gt;)*filter*`

#### Parameters

*filter*  
&nbsp;&nbsp;&nbsp;过滤器  

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/clearCacheVariables" title="clearCacheVariables"></a>
### clearCacheVariables

`- (void)clearCacheVariables`

<a name="//api/name/clearCompletionBlock" title="clearCompletionBlock"></a>
### clearCompletionBlock

清除 block，放置 block 循环引用

`- (void)clearCompletionBlock`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/removeAccessory:" title="removeAccessory:"></a>
### removeAccessory:

删除网络请求监听器

`- (void)removeAccessory:(id&lt;MLSRequestAccessory&gt;)*accessory*`

#### Parameters

*accessory*  
&nbsp;&nbsp;&nbsp;网络请求监听器  

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/removeUrlFilter:" title="removeUrlFilter:"></a>
### removeUrlFilter:

移除过滤器

`- (void)removeUrlFilter:(id&lt;MLSUrlFilterProtocol&gt;)*filter*`

#### Parameters

*filter*  
&nbsp;&nbsp;&nbsp;过滤器  

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/requestFullParams" title="requestFullParams"></a>
### requestFullParams

`- (id)requestFullParams`

<a name="//api/name/setCompletionBlockWithSuccess:failure:" title="setCompletionBlockWithSuccess:failure:"></a>
### setCompletionBlockWithSuccess:failure:

设置回调 block

`- (void)setCompletionBlockWithSuccess:(nullable MLSRequestCompletionBlock)*success* failure:(nullable MLSRequestCompletionBlock)*failure*`

#### Parameters

*success*  
&nbsp;&nbsp;&nbsp;成功  

*failure*  
&nbsp;&nbsp;&nbsp;失败  

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/shouldRemoveFromAgent" title="shouldRemoveFromAgent"></a>
### shouldRemoveFromAgent

`- (BOOL)shouldRemoveFromAgent`

<a name="//api/name/start" title="start"></a>
### start

开始网络请求

`- (void)start`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/startWithCompletionBlockWithSuccess:failure:" title="startWithCompletionBlockWithSuccess:failure:"></a>
### startWithCompletionBlockWithSuccess:failure:

开始网络请求

`- (void)startWithCompletionBlockWithSuccess:(nullable MLSRequestCompletionBlock)*success* failure:(nullable MLSRequestCompletionBlock)*failure*`

#### Parameters

*success*  
&nbsp;&nbsp;&nbsp;成功回调  

*failure*  
&nbsp;&nbsp;&nbsp;失败回调  

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/stop" title="stop"></a>
### stop

停止网络请求

`- (void)stop`

#### Declared In
* `MLSBaseRequest.h`

<a name="//api/name/toggleAccessoriesDidStopcallback" title="toggleAccessoriesDidStopcallback"></a>
### toggleAccessoriesDidStopcallback

`- (void)toggleAccessoriesDidStopcallback`

<a name="//api/name/toggleAccessoriesWillStartcallback" title="toggleAccessoriesWillStartcallback"></a>
### toggleAccessoriesWillStartcallback

`- (void)toggleAccessoriesWillStartcallback`

<a name="//api/name/toggleAccessoriesWillStopcallback" title="toggleAccessoriesWillStopcallback"></a>
### toggleAccessoriesWillStopcallback

`- (void)toggleAccessoriesWillStopcallback`

