# MLSNetworkConfig Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkConfig.h  

## Overview

MARK: - 全局网络配置

## Tasks

### 

[+&nbsp;sharedConfig](#//api/name/sharedConfig)  

[+&nbsp;sharedConfigWithMoudleIdentifier:](#//api/name/sharedConfigWithMoudleIdentifier:)  

[&nbsp;&nbsp;securityPolicy](#//api/name/securityPolicy) *property* 

[&nbsp;&nbsp;debugLogEnabled](#//api/name/debugLogEnabled) *property* 

[&nbsp;&nbsp;sessionConfiguration](#//api/name/sessionConfiguration) *property* 

[&nbsp;&nbsp;baseUrl](#//api/name/baseUrl) *property* 

[&nbsp;&nbsp;cdnUrl](#//api/name/cdnUrl) *property* 

[&nbsp;&nbsp;urlFilters](#//api/name/urlFilters) *property* 

[&nbsp;&nbsp;logger](#//api/name/logger) *property* 

[&nbsp;&nbsp;cacheManager](#//api/name/cacheManager) *property* 

[&nbsp;&nbsp;modelManager](#//api/name/modelManager) *property* 

[&nbsp;&nbsp;enctyptManager](#//api/name/enctyptManager) *property* 

[&nbsp;&nbsp;serverRootDataClass](#//api/name/serverRootDataClass) *property* 

[&ndash;&nbsp;addUrlFilter:](#//api/name/addUrlFilter:)  

[&ndash;&nbsp;removeUrlFilter:](#//api/name/removeUrlFilter:)  

[&ndash;&nbsp;clearUrlFilter](#//api/name/clearUrlFilter)  

## Properties

<a name="//api/name/baseUrl" title="baseUrl"></a>
### baseUrl

域名
<a href="../Classes/MLSBaseRequest.html">MLSBaseRequest</a> 可重写

`@property (nonatomic, strong) NSString *baseUrl`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/cacheManager" title="cacheManager"></a>
### cacheManager

缓存管理
<a href="../Classes/MLSNetworkRequest.html">MLSNetworkRequest</a> 可重写

`@property (nonatomic, strong) id&lt;MLSNetworkCacheProtocol&gt; cacheManager`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/cdnUrl" title="cdnUrl"></a>
### cdnUrl

CDN 地址
<a href="../Classes/MLSBaseRequest.html">MLSBaseRequest</a> 可重写

`@property (nonatomic, strong) NSString *cdnUrl`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/debugLogEnabled" title="debugLogEnabled"></a>
### debugLogEnabled

是否开启 log 日志

`@property (nonatomic) BOOL debugLogEnabled`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/enctyptManager" title="enctyptManager"></a>
### enctyptManager

加解密工具
<a href="../Classes/MLSNetworkRequest.html">MLSNetworkRequest</a> 可重写

`@property (nonatomic, strong) id&lt;MLSEncryptProtocol&gt; enctyptManager`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/logger" title="logger"></a>
### logger

日志工具
默认使用 NSLog
<a href="../Classes/MLSNetworkRequest.html">MLSNetworkRequest</a> 可重写

`@property (nonatomic, strong) id&lt;MLSNetworkLogProtocol&gt; logger`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/modelManager" title="modelManager"></a>
### modelManager

字典转模型工具
<a href="../Classes/MLSNetworkRequest.html">MLSNetworkRequest</a> 可重写

`@property (nonatomic, strong) id&lt;MLSNetworkModelProtocol&gt; modelManager`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/securityPolicy" title="securityPolicy"></a>
### securityPolicy

https 配置

`@property (nonatomic, strong) AFSecurityPolicy *securityPolicy`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/serverRootDataClass" title="serverRootDataClass"></a>
### serverRootDataClass

服务器返回的根数据结构
<a href="../Classes/MLSNetworkRequest.html">MLSNetworkRequest</a> 可重写

`@property (nonatomic, strong) Class&lt;MLSNetworkRootDataProtocol&gt; serverRootDataClass`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/sessionConfiguration" title="sessionConfiguration"></a>
### sessionConfiguration

网络 Session 配置

`@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/urlFilters" title="urlFilters"></a>
### urlFilters

网络请求过滤器
<a href="../Classes/MLSBaseRequest.html">MLSBaseRequest</a> 可重写

`@property (nonatomic, strong, readonly) NSArray&lt;id&lt;MLSUrlFilterProtocol&gt; &gt; *urlFilters`

#### Declared In
* `MLSNetworkConfig.h`

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/sharedConfig" title="sharedConfig"></a>
### sharedConfig

单利

`+ (MLSNetworkConfig *)sharedConfig`

#### Return Value
配置中心

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/sharedConfigWithMoudleIdentifier:" title="sharedConfigWithMoudleIdentifier:"></a>
### sharedConfigWithMoudleIdentifier:

模块配置
通过配置 request 的 moduleIdentifier, request 会根据 此id查找相应配置

`+ (MLSNetworkConfig *)sharedConfigWithMoudleIdentifier:(NSString *)*moudleIdentifier*`

#### Parameters

*moudleIdentifier*  
&nbsp;&nbsp;&nbsp;模块标识  

#### Return Value
配置中心

#### Declared In
* `MLSNetworkConfig.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addUrlFilter:" title="addUrlFilter:"></a>
### addUrlFilter:

增加一个请求过滤器

`- (void)addUrlFilter:(id&lt;MLSUrlFilterProtocol&gt;)*filter*`

#### Parameters

*filter*  
&nbsp;&nbsp;&nbsp;过滤器  

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/clearUrlFilter" title="clearUrlFilter"></a>
### clearUrlFilter

删除全部 url 过滤器

`- (void)clearUrlFilter`

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/removeUrlFilter:" title="removeUrlFilter:"></a>
### removeUrlFilter:

移除过滤器

`- (void)removeUrlFilter:(id&lt;MLSUrlFilterProtocol&gt;)*filter*`

#### Parameters

*filter*  
&nbsp;&nbsp;&nbsp;过滤器  

#### Declared In
* `MLSNetworkConfig.h`

