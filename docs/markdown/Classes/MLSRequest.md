# MLSRequest Class Reference

&nbsp;&nbsp;**Inherits from** <a href="../Classes/MLSBaseRequest.html">MLSBaseRequest</a> :   
NSObject  
&nbsp;&nbsp;**Declared in** MLSRequest.h  

## Overview

带有缓存功能的 Request

## Tasks

### Other Methods

[&nbsp;&nbsp;ignoreCache](#//api/name/ignoreCache) *property* 

[&nbsp;&nbsp;cacheable](#//api/name/cacheable) *property* 

[&ndash;&nbsp;isDataFromCache](#//api/name/isDataFromCache)  

[&ndash;&nbsp;loadCacheWithError:](#//api/name/loadCacheWithError:)  

[&ndash;&nbsp;startWithoutCache](#//api/name/startWithoutCache)  

[&ndash;&nbsp;saveResponseDataToCacheFile:](#//api/name/saveResponseDataToCacheFile:)  

[&ndash;&nbsp;cacheTimeInSeconds](#//api/name/cacheTimeInSeconds)  

[&ndash;&nbsp;cacheVersion](#//api/name/cacheVersion)  

[&ndash;&nbsp;cacheVersionString](#//api/name/cacheVersionString)  

[&ndash;&nbsp;cacheSensitiveData](#//api/name/cacheSensitiveData)  

[&ndash;&nbsp;writeCacheAsynchronously](#//api/name/writeCacheAsynchronously)  

[&ndash;&nbsp;startWithCache:withCompletionBlockWithSuccess:failure:](#//api/name/startWithCache:withCompletionBlockWithSuccess:failure:)  

[&ndash;&nbsp;clearCache](#//api/name/clearCache)  

### Getter Methods

[&ndash;&nbsp;cacheBasePath](#//api/name/cacheBasePath)  

## Properties

<a name="//api/name/cacheable" title="cacheable"></a>
### cacheable

是否允许缓存

`@property (nonatomic, assign) BOOL cacheable`

#### Declared In
* `MLSRequest.h`

<a name="//api/name/ignoreCache" title="ignoreCache"></a>
### ignoreCache

是否忽略本地缓存

`@property (nonatomic, assign) BOOL ignoreCache`

#### Declared In
* `MLSRequest.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/cacheBasePath" title="cacheBasePath"></a>
### cacheBasePath

`- (NSString *)cacheBasePath`

<a name="//api/name/cacheSensitiveData" title="cacheSensitiveData"></a>
### cacheSensitiveData

缓存 key 的增加标识，用于标识哪些内容需要过期处理

`- (nullable id)cacheSensitiveData`

#### Return Value
<code>NSArray</code> or <code>NSDictionary</code>， 或者是字符串，或者是自定义类的 <code>description</code> 字段

#### Declared In
* `MLSRequest.h`

<a name="//api/name/cacheTimeInSeconds" title="cacheTimeInSeconds"></a>
### cacheTimeInSeconds

缓存时间
如果自定义缓存功能，则该方法失效

`- (NSInteger)cacheTimeInSeconds`

#### Return Value
缓存时间，单位 s

#### Declared In
* `MLSRequest.h`

<a name="//api/name/cacheVersion" title="cacheVersion"></a>
### cacheVersion

缓存版本号

`- (long long)cacheVersion`

#### Return Value
版本号

#### Declared In
* `MLSRequest.h`

<a name="//api/name/cacheVersionString" title="cacheVersionString"></a>
### cacheVersionString

版本号字符串

`- (NSString *)cacheVersionString`

#### Return Value
版本号字符串

#### Declared In
* `MLSRequest.h`

<a name="//api/name/clearCache" title="clearCache"></a>
### clearCache

清除缓存

`- (void)clearCache`

#### Declared In
* `MLSRequest.h`

<a name="//api/name/isDataFromCache" title="isDataFromCache"></a>
### isDataFromCache

内容是否是从缓存中获取

`- (BOOL)isDataFromCache`

#### Return Value
是否从缓存中获取

#### Declared In
* `MLSRequest.h`

<a name="//api/name/loadCacheWithError:" title="loadCacheWithError:"></a>
### loadCacheWithError:

获取缓存

`- (BOOL)loadCacheWithError:(NSError *__autoreleasing *)*error*`

#### Parameters

*error*  
&nbsp;&nbsp;&nbsp;错误信息  

#### Return Value
是否获取成功

#### Declared In
* `MLSRequest.h`

<a name="//api/name/saveResponseDataToCacheFile:" title="saveResponseDataToCacheFile:"></a>
### saveResponseDataToCacheFile:

缓存内容

`- (void)saveResponseDataToCacheFile:(NSData *)*data*`

#### Parameters

*data*  
&nbsp;&nbsp;&nbsp;网络内容  

#### Declared In
* `MLSRequest.h`

<a name="//api/name/startWithCache:withCompletionBlockWithSuccess:failure:" title="startWithCache:withCompletionBlockWithSuccess:failure:"></a>
### startWithCache:withCompletionBlockWithSuccess:failure:

开始网络请求

`- (void)startWithCache:(BOOL)*cacheable* withCompletionBlockWithSuccess:(MLSRequestCompletionBlock)*success* failure:(MLSRequestCompletionBlock)*failure*`

#### Parameters

*cacheable*  
&nbsp;&nbsp;&nbsp;是否缓存  

*success*  
&nbsp;&nbsp;&nbsp;成功回调  

*failure*  
&nbsp;&nbsp;&nbsp;失败回调  

#### Declared In
* `MLSRequest.h`

<a name="//api/name/startWithoutCache" title="startWithoutCache"></a>
### startWithoutCache

请求，不使用缓存

`- (void)startWithoutCache`

#### Declared In
* `MLSRequest.h`

<a name="//api/name/writeCacheAsynchronously" title="writeCacheAsynchronously"></a>
### writeCacheAsynchronously

是否异步写入缓存

`- (BOOL)writeCacheAsynchronously`

#### Return Value
默认 YES 异步

#### Declared In
* `MLSRequest.h`

