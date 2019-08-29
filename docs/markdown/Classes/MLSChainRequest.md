# MLSChainRequest Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSChainRequest.h  

## Overview

链式请求
按照数组顺序依次请求，只有第一个请求完成并且成功后，才会进行第二个请求

## Tasks

### Other Methods

[&ndash;&nbsp;requestArray](#//api/name/requestArray)  

[&nbsp;&nbsp;delegate](#//api/name/delegate) *property* 

[&nbsp;&nbsp;requestAccessories](#//api/name/requestAccessories) *property* 

[&ndash;&nbsp;addAccessory:](#//api/name/addAccessory:)  

[&ndash;&nbsp;start](#//api/name/start)  

[&ndash;&nbsp;stop](#//api/name/stop)  

[&ndash;&nbsp;addRequest:callback:](#//api/name/addRequest:callback:)  

### RequestAccessory Methods

[&ndash;&nbsp;toggleAccessoriesWillStartcallback](#//api/name/toggleAccessoriesWillStartcallback)  

[&ndash;&nbsp;toggleAccessoriesWillStopcallback](#//api/name/toggleAccessoriesWillStopcallback)  

[&ndash;&nbsp;toggleAccessoriesDidStopcallback](#//api/name/toggleAccessoriesDidStopcallback)  

## Properties

<a name="//api/name/delegate" title="delegate"></a>
### delegate

代理

`@property (nonatomic, weak, nullable) id&lt;MLSChainRequestDelegate&gt; delegate`

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/requestAccessories" title="requestAccessories"></a>
### requestAccessories

监听网络请求状态

`@property (nonatomic, strong, nullable) NSMutableArray&lt;id&lt;MLSRequestAccessory&gt; &gt; *requestAccessories`

#### Declared In
* `MLSChainRequest.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addAccessory:" title="addAccessory:"></a>
### addAccessory:

添加一个监听网络请求状态

`- (void)addAccessory:(id&lt;MLSRequestAccessory&gt;)*accessory*`

#### Parameters

*accessory*  
&nbsp;&nbsp;&nbsp;监听者  

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/addRequest:callback:" title="addRequest:callback:"></a>
### addRequest:callback:

添加一个网络请求

`- (void)addRequest:(MLSBaseRequest *)*request* callback:(nullable MLSChaincallback)*callback*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

*callback*  
&nbsp;&nbsp;&nbsp;回调  

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/requestArray" title="requestArray"></a>
### requestArray

网络请求数组

`- (NSArray&lt;MLSBaseRequest*&gt; *)requestArray`

#### Return Value
网络请求数组

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/start" title="start"></a>
### start

开始

`- (void)start`

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/stop" title="stop"></a>
### stop

停止

`- (void)stop`

#### Declared In
* `MLSChainRequest.h`

<a name="//api/name/toggleAccessoriesDidStopcallback" title="toggleAccessoriesDidStopcallback"></a>
### toggleAccessoriesDidStopcallback

`- (void)toggleAccessoriesDidStopcallback`

<a name="//api/name/toggleAccessoriesWillStartcallback" title="toggleAccessoriesWillStartcallback"></a>
### toggleAccessoriesWillStartcallback

`- (void)toggleAccessoriesWillStartcallback`

<a name="//api/name/toggleAccessoriesWillStopcallback" title="toggleAccessoriesWillStopcallback"></a>
### toggleAccessoriesWillStopcallback

`- (void)toggleAccessoriesWillStopcallback`

