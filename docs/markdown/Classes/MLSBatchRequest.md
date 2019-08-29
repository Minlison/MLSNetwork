# MLSBatchRequest Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSBatchRequest.h  

## Overview

批量请求处理
内部的每个网络请求还走其原有的代理和回调方法

## Tasks

### Other Methods

[&nbsp;&nbsp;requestArray](#//api/name/requestArray) *property* 

[&nbsp;&nbsp;delegate](#//api/name/delegate) *property* 

[&nbsp;&nbsp;successCompletionBlock](#//api/name/successCompletionBlock) *property* 

[&nbsp;&nbsp;failureCompletionBlock](#//api/name/failureCompletionBlock) *property* 

[&nbsp;&nbsp;tag](#//api/name/tag) *property* 

[&nbsp;&nbsp;requestAccessories](#//api/name/requestAccessories) *property* 

[&nbsp;&nbsp;failedRequest](#//api/name/failedRequest) *property* 

[&ndash;&nbsp;initWithRequestArray:](#//api/name/initWithRequestArray:)  

[&ndash;&nbsp;setCompletionBlockWithSuccess:failure:](#//api/name/setCompletionBlockWithSuccess:failure:)  

[&ndash;&nbsp;clearCompletionBlock](#//api/name/clearCompletionBlock)  

[&ndash;&nbsp;addAccessory:](#//api/name/addAccessory:)  

[&ndash;&nbsp;start](#//api/name/start)  

[&ndash;&nbsp;stop](#//api/name/stop)  

[&ndash;&nbsp;startWithCompletionBlockWithSuccess:failure:](#//api/name/startWithCompletionBlockWithSuccess:failure:)  

[&ndash;&nbsp;isDataFromCache](#//api/name/isDataFromCache)  

### RequestAccessory Methods

[&ndash;&nbsp;toggleAccessoriesWillStartcallback](#//api/name/toggleAccessoriesWillStartcallback)  

[&ndash;&nbsp;toggleAccessoriesWillStopcallback](#//api/name/toggleAccessoriesWillStopcallback)  

[&ndash;&nbsp;toggleAccessoriesDidStopcallback](#//api/name/toggleAccessoriesDidStopcallback)  

## Properties

<a name="//api/name/delegate" title="delegate"></a>
### delegate

代理

`@property (nonatomic, weak, nullable) id&lt;MLSBatchRequestDelegate&gt; delegate`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/failedRequest" title="failedRequest"></a>
### failedRequest

失败的 request

`@property (nonatomic, strong, readonly, nullable) MLSRequest *failedRequest`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/failureCompletionBlock" title="failureCompletionBlock"></a>
### failureCompletionBlock

失败回调

`@property (nonatomic, copy, nullable) void ( ^ ) ( MLSBatchRequest *) failureCompletionBlock`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/requestAccessories" title="requestAccessories"></a>
### requestAccessories

网络监听

`@property (nonatomic, strong, nullable) NSMutableArray&lt;id&lt;MLSRequestAccessory&gt; &gt; *requestAccessories`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/requestArray" title="requestArray"></a>
### requestArray

批量请求数组

`@property (nonatomic, strong, readonly) NSArray&lt;MLSRequest*&gt; *requestArray`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/successCompletionBlock" title="successCompletionBlock"></a>
### successCompletionBlock

成功回调

`@property (nonatomic, copy, nullable) void ( ^ ) ( MLSBatchRequest *) successCompletionBlock`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/tag" title="tag"></a>
### tag

网络 tag

`@property (nonatomic) NSInteger tag`

#### Declared In
* `MLSBatchRequest.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addAccessory:" title="addAccessory:"></a>
### addAccessory:

添加网络请求状态监听

`- (void)addAccessory:(id&lt;MLSRequestAccessory&gt;)*accessory*`

#### Parameters

*accessory*  
&nbsp;&nbsp;&nbsp;监听  

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/clearCompletionBlock" title="clearCompletionBlock"></a>
### clearCompletionBlock

清除 block

`- (void)clearCompletionBlock`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/initWithRequestArray:" title="initWithRequestArray:"></a>
### initWithRequestArray:

初试化方法

`- (instancetype)initWithRequestArray:(NSArray&lt;MLSRequest*&gt; *)*requestArray*`

#### Parameters

*requestArray*  
&nbsp;&nbsp;&nbsp;网络请求数组  

#### Return Value
MLSBatchRequest

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/isDataFromCache" title="isDataFromCache"></a>
### isDataFromCache

是否是缓存的数据

`- (BOOL)isDataFromCache`

#### Return Value
是否是缓存的数据

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/setCompletionBlockWithSuccess:failure:" title="setCompletionBlockWithSuccess:failure:"></a>
### setCompletionBlockWithSuccess:failure:

设置回调 block

`- (void)setCompletionBlockWithSuccess:(nullable void ( ^ ) ( MLSBatchRequest *batchRequest ))*success* failure:(nullable void ( ^ ) ( MLSBatchRequest *batchRequest ))*failure*`

#### Parameters

*success*  
&nbsp;&nbsp;&nbsp;成功  

*failure*  
&nbsp;&nbsp;&nbsp;失败  

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/start" title="start"></a>
### start

开始

`- (void)start`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/startWithCompletionBlockWithSuccess:failure:" title="startWithCompletionBlockWithSuccess:failure:"></a>
### startWithCompletionBlockWithSuccess:failure:

开始

`- (void)startWithCompletionBlockWithSuccess:(nullable void ( ^ ) ( MLSBatchRequest *batchRequest ))*success* failure:(nullable void ( ^ ) ( MLSBatchRequest *batchRequest ))*failure*`

#### Parameters

*success*  
&nbsp;&nbsp;&nbsp;成功 block  

*failure*  
&nbsp;&nbsp;&nbsp;失败 block  

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/stop" title="stop"></a>
### stop

停止

`- (void)stop`

#### Declared In
* `MLSBatchRequest.h`

<a name="//api/name/toggleAccessoriesDidStopcallback" title="toggleAccessoriesDidStopcallback"></a>
### toggleAccessoriesDidStopcallback

`- (void)toggleAccessoriesDidStopcallback`

<a name="//api/name/toggleAccessoriesWillStartcallback" title="toggleAccessoriesWillStartcallback"></a>
### toggleAccessoriesWillStartcallback

`- (void)toggleAccessoriesWillStartcallback`

<a name="//api/name/toggleAccessoriesWillStopcallback" title="toggleAccessoriesWillStopcallback"></a>
### toggleAccessoriesWillStopcallback

`- (void)toggleAccessoriesWillStopcallback`

