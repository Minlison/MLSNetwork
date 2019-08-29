# MLSNetworkRequest Class Reference

&nbsp;&nbsp;**Conforms to** ContentType<br />  
__covariant  
&nbsp;&nbsp;**Declared in** MLSNetworkRequest.h  

## Overview

在使用 MLSNetwork 框架的时候，必须要定义一个网络根数据结构，继承 <a href="../Protocols/MLSNetworkRootDataProtocol.html">MLSNetworkRootDataProtocol</a>
可用于重试机制判断

## Tasks

### Other Methods

[&nbsp;&nbsp;requestFullParams](#//api/name/requestFullParams) *property* 

[&nbsp;&nbsp;tipString](#//api/name/tipString) *property* 

[&nbsp;&nbsp;maxRetryCount](#//api/name/maxRetryCount) *property* 

[&nbsp;&nbsp;retryCount](#//api/name/retryCount) *property* 

[&nbsp;&nbsp;needRetry](#//api/name/needRetry) *property* 

[&nbsp;&nbsp;needRetryPreRequest](#//api/name/needRetryPreRequest) *property* 

[&nbsp;&nbsp;retryDelay](#//api/name/retryDelay) *property* 

[&nbsp;&nbsp;retryPreRequest](#//api/name/retryPreRequest) *property* 

[&nbsp;&nbsp;retryPreRequestCodes](#//api/name/retryPreRequestCodes) *property* 

[&nbsp;&nbsp;serverRootData](#//api/name/serverRootData) *property* 

[&nbsp;&nbsp;responseModelData](#//api/name/responseModelData) *property* 

[&nbsp;&nbsp;modelClass](#//api/name/modelClass) *property* 

[&nbsp;&nbsp;cacheManager](#//api/name/cacheManager) *property* 

[&nbsp;&nbsp;modelManager](#//api/name/modelManager) *property* 

[&nbsp;&nbsp;enctyptManager](#//api/name/enctyptManager) *property* 

[&nbsp;&nbsp;serverRootDataClass](#//api/name/serverRootDataClass) *property* 

[&nbsp;&nbsp;logger](#//api/name/logger) *property* 

[&nbsp;&nbsp;modelKeyPath](#//api/name/modelKeyPath) *property* 

[+&nbsp;requestWithParam:](#//api/name/requestWithParam:)  

[&ndash;&nbsp;paramInsert:forKey:](#//api/name/paramInsert:forKey:)  

[&ndash;&nbsp;paramInsert:](#//api/name/paramInsert:)  

[&ndash;&nbsp;paramDelForKey:](#//api/name/paramDelForKey:)  

[&ndash;&nbsp;paramDel:](#//api/name/paramDel:)  

[&ndash;&nbsp;paramDelForKeys:](#//api/name/paramDelForKeys:)  

[&ndash;&nbsp;startWithModelCompletionBlockWithSuccess:failure:](#//api/name/startWithModelCompletionBlockWithSuccess:failure:)  

[&ndash;&nbsp;startWithCache:modelCompletionBlockWithSuccess:failure:](#//api/name/startWithCache:modelCompletionBlockWithSuccess:failure:)  

### RACSignalSupport Methods

[&ndash;&nbsp;rac_signal](#//api/name/rac_signal)  

[&ndash;&nbsp;rac_channelForKey:nilValue:](#//api/name/rac_channelForKey:nilValue:)  

### COObjcSupport Methods

[&ndash;&nbsp;async_request](#//api/name/async_request)  

## Properties

<a name="//api/name/cacheManager" title="cacheManager"></a>
### cacheManager

缓存管理

`@property (nonatomic, strong) id&lt;MLSNetworkCacheProtocol&gt; cacheManager`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/enctyptManager" title="enctyptManager"></a>
### enctyptManager

加解密工具

`@property (nonatomic, strong) id&lt;MLSEncryptProtocol&gt; enctyptManager`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/logger" title="logger"></a>
### logger

日志工具

`@property (nonatomic, strong) id&lt;MLSNetworkLogProtocol&gt; logger`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/maxRetryCount" title="maxRetryCount"></a>
### maxRetryCount

错误最大重试次数
默认 不重试

`@property (nonatomic, assign) NSUInteger maxRetryCount`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/modelClass" title="modelClass"></a>
### modelClass

需要转模型的 Class

`@property (nonatomic, strong) Class modelClass`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/modelKeyPath" title="modelKeyPath"></a>
### modelKeyPath

需要提取的子集模型
{
     &ldquo;code&rdquo;: 0,
     &ldquo;message&rdquo;: &ldquo;成功&rdquo;,
     &ldquo;data&rdquo;: {
         &ldquo;name&rdquo;: &ldquo;BeJson&rdquo;,
         &ldquo;url&rdquo;: &ldquo;<a href="http://www.bejson.com">http://www.bejson.com</a>&rdquo;,
         &ldquo;page&rdquo;: 88,
         &ldquo;isNonProfit&rdquo;: true,
         &ldquo;address&rdquo;: {
             &ldquo;street&rdquo;: &ldquo;科技园路.&rdquo;,
             &ldquo;city&rdquo;: &ldquo;江苏苏州&rdquo;,
             &ldquo;country&rdquo;: &ldquo;中国&rdquo;
         }
     }
}
如果 <a href="#//api/name/modelClass">modelClass</a> 为 links 对应的 class， 想要网络请求完成，自动转换模型为 links 的模型
则 modelKeyPath 设置为 data.links
如果不设置，默认是真个 data 块

`@property (nonatomic, copy) NSString *modelKeyPath`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/modelManager" title="modelManager"></a>
### modelManager

字典转模型工具

`@property (nonatomic, strong) id&lt;MLSNetworkModelProtocol&gt; modelManager`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/needRetry" title="needRetry"></a>
### needRetry

是否需要重试

`@property (nonatomic, assign) BOOL needRetry`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/needRetryPreRequest" title="needRetryPreRequest"></a>
### needRetryPreRequest

是否需要在重试前调用 <a href="#//api/name/retryPreRequest">retryPreRequest</a>

`@property (nonatomic, assign) BOOL needRetryPreRequest`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/requestFullParams" title="requestFullParams"></a>
### requestFullParams

  完成的请求参数，包括 paraInsert 后的参数

`@property (nonatomic, strong, readonly) id requestFullParams`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/responseModelData" title="responseModelData"></a>
### responseModelData

需要提取的 模型数据

`@property (nonatomic, strong, readonly) ContentType responseModelData`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/retryCount" title="retryCount"></a>
### retryCount

错误重试次数 默认 3 次

`@property (nonatomic, assign, readonly) NSUInteger retryCount`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/retryDelay" title="retryDelay"></a>
### retryDelay

延时重试，默认 0

`@property (nonatomic, assign) NSTimeInterval retryDelay`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/retryPreRequest" title="retryPreRequest"></a>
### retryPreRequest

在错误重试前，必须要请求而且成功的 request

`@property (nonatomic, strong) id&lt;MLSRetryPreRequestProtocol&gt; retryPreRequest`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/retryPreRequestCodes" title="retryPreRequestCodes"></a>
### retryPreRequestCodes

需要重试前调用 <a href="#//api/name/retryPreRequest">retryPreRequest</a> 的错误码

`@property (nonatomic, strong) NSMutableSet&lt;NSNumber*&gt; *retryPreRequestCodes`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/serverRootData" title="serverRootData"></a>
### serverRootData

服务器返回的根数据

`@property (nonatomic, strong, readonly) id&lt;MLSNetworkRootDataProtocol&gt; serverRootData`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/serverRootDataClass" title="serverRootDataClass"></a>
### serverRootDataClass

服务器返回的根数据结构

`@property (nonatomic, strong) Class&lt;MLSNetworkRootDataProtocol&gt; serverRootDataClass`

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/tipString" title="tipString"></a>
### tipString

服务器返回的信息
成功，或者失败提示信息

`@property (nonatomic, copy, readonly) NSString *tipString`

#### Declared In
* `MLSNetworkRequest.h`

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/requestWithParam:" title="requestWithParam:"></a>
### requestWithParam:

快速创建网络请求

`+ (instancetype)requestWithParam:(nullable id)*param*`

#### Parameters

*param*  
&nbsp;&nbsp;&nbsp;参数  

#### Return Value
网络请求

#### Declared In
* `MLSNetworkRequest.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/async_request" title="async_request"></a>
### async_request

兼容coobjc处理
其中返回的参数是一个元组 COTuple3
第一个是该网络请求，第二个为请求结果，第三个为错误信息
其中第一个不为空，后两个皆有可能为空
不可以使用 co_getError() 获取错误信息

`- (COPromise&lt;COTuple3&lt;MLSNetworkRequest*,id,NSError*&gt; *&gt; *)async_request`

#### Return Value
COPromise

#### Declared In
* `MLSNetworkRequest+COObjcSupport.h`

<a name="//api/name/paramDel:" title="paramDel:"></a>
### paramDel:

`- (void)paramDel:(NSDictionary *)*delParam*`

<a name="//api/name/paramDelForKey:" title="paramDelForKey:"></a>
### paramDelForKey:

删除参数

`- (void)paramDelForKey:(NSString *)*key*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;对应键  

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/paramDelForKeys:" title="paramDelForKeys:"></a>
### paramDelForKeys:

`- (void)paramDelForKeys:(NSArray *)*delParamKeys*`

<a name="//api/name/paramInsert:" title="paramInsert:"></a>
### paramInsert:

`- (void)paramInsert:(NSDictionary *)*insertParam*`

<a name="//api/name/paramInsert:forKey:" title="paramInsert:forKey:"></a>
### paramInsert:forKey:

插入参数
会覆盖原本参数

`- (void)paramInsert:(id)*obj* forKey:(NSString *)*key*`

#### Parameters

*obj*  
&nbsp;&nbsp;&nbsp;参数  

*key*  
&nbsp;&nbsp;&nbsp;对应键  

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/rac_channelForKey:nilValue:" title="rac_channelForKey:nilValue:"></a>
### rac_channelForKey:nilValue:

RAC 通道

`- (RACChannel *)rac_channelForKey:(NSString *)*key* nilValue:(id)*nilValue*`

#### Return Value
channel

#### Declared In
* `MLSNetworkRequest+RACSignalSupport.h`

<a name="//api/name/rac_signal" title="rac_signal"></a>
### rac_signal

RAC 信号

`- (RACSignal *)rac_signal`

#### Return Value
signal

#### Declared In
* `MLSNetworkRequest+RACSignalSupport.h`

<a name="//api/name/startWithCache:modelCompletionBlockWithSuccess:failure:" title="startWithCache:modelCompletionBlockWithSuccess:failure:"></a>
### startWithCache:modelCompletionBlockWithSuccess:failure:

网络请求

`- (void)startWithCache:(BOOL)*cacheable* modelCompletionBlockWithSuccess:(MLSNetworkRequestCompletionBlock)*success* failure:(MLSNetworkRequestCompletionBlock)*failure*`

#### Parameters

*cacheable*  
&nbsp;&nbsp;&nbsp;是否 缓存  

*success*  
&nbsp;&nbsp;&nbsp;成功回调  

*failure*  
&nbsp;&nbsp;&nbsp;失败回调  

#### Declared In
* `MLSNetworkRequest.h`

<a name="//api/name/startWithModelCompletionBlockWithSuccess:failure:" title="startWithModelCompletionBlockWithSuccess:failure:"></a>
### startWithModelCompletionBlockWithSuccess:failure:

开始网络请求

`- (void)startWithModelCompletionBlockWithSuccess:(MLSNetworkRequestCompletionBlock)*success* failure:(MLSNetworkRequestCompletionBlock)*failure*`

#### Parameters

*success*  
&nbsp;&nbsp;&nbsp;成功回调  

*failure*  
&nbsp;&nbsp;&nbsp;失败回调  

#### Declared In
* `MLSNetworkRequest.h`

