# MLSNetworkAgent Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkAgent.h  

## Overview

网络请求代理
用来管理项目中所有的网络请求，在项目中使用 request 的时候，不用强持有，创建后直接运行即可

## Tasks

### Other Methods

[&ndash;&nbsp;init](#//api/name/init)  

[+&nbsp;new](#//api/name/new)  

[+&nbsp;sharedAgent](#//api/name/sharedAgent)  

[+&nbsp;shareAgentWithMoudleIdentifer:](#//api/name/shareAgentWithMoudleIdentifer:)  

[&ndash;&nbsp;addRequest:](#//api/name/addRequest:)  

[&ndash;&nbsp;cancelRequest:](#//api/name/cancelRequest:)  

[&ndash;&nbsp;cancelAllRequests](#//api/name/cancelAllRequests)  

[&ndash;&nbsp;buildRequestUrl:](#//api/name/buildRequestUrl:)  

### Private Methods

[&ndash;&nbsp;manager](#//api/name/manager)  

[&ndash;&nbsp;resetURLSessionManager](#//api/name/resetURLSessionManager)  

[&ndash;&nbsp;resetURLSessionManagerWithConfiguration:](#//api/name/resetURLSessionManagerWithConfiguration:)  

[&ndash;&nbsp;requestDidSucceedWithRequest:](#//api/name/requestDidSucceedWithRequest:)  

[&ndash;&nbsp;requestDidFailWithRequest:error:](#//api/name/requestDidFailWithRequest:error:)  

[&ndash;&nbsp;incompleteDownloadTempCacheFolder](#//api/name/incompleteDownloadTempCacheFolder)  

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/new" title="new"></a>
### new

`+ (instancetype)new`

<a name="//api/name/shareAgentWithMoudleIdentifer:" title="shareAgentWithMoudleIdentifer:"></a>
### shareAgentWithMoudleIdentifer:

模块化代理
会获取request的

`+ (MLSNetworkAgent *)shareAgentWithMoudleIdentifer:(NSString *)*moudleIdentifier*`

#### Return Value
agent

#### Declared In
* `MLSNetworkAgent.h`

<a name="//api/name/sharedAgent" title="sharedAgent"></a>
### sharedAgent

单利

`+ (MLSNetworkAgent *)sharedAgent`

#### Return Value
单利

#### Declared In
* `MLSNetworkAgent.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addRequest:" title="addRequest:"></a>
### addRequest:

添加一个网络请求

`- (void)addRequest:(MLSBaseRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSNetworkAgent.h`

<a name="//api/name/buildRequestUrl:" title="buildRequestUrl:"></a>
### buildRequestUrl:

构建 url

`- (NSString *)buildRequestUrl:(MLSBaseRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Return Value
url

#### Declared In
* `MLSNetworkAgent.h`

<a name="//api/name/cancelAllRequests" title="cancelAllRequests"></a>
### cancelAllRequests

取消所有的网络请求

`- (void)cancelAllRequests`

#### Declared In
* `MLSNetworkAgent.h`

<a name="//api/name/cancelRequest:" title="cancelRequest:"></a>
### cancelRequest:

取消一个网络请求

`- (void)cancelRequest:(MLSBaseRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSNetworkAgent.h`

<a name="//api/name/incompleteDownloadTempCacheFolder" title="incompleteDownloadTempCacheFolder"></a>
### incompleteDownloadTempCacheFolder

`- (NSString *)incompleteDownloadTempCacheFolder`

<a name="//api/name/init" title="init"></a>
### init

`- (instancetype)init`

<a name="//api/name/manager" title="manager"></a>
### manager

`- (AFHTTPSessionManager *)manager`

<a name="//api/name/requestDidFailWithRequest:error:" title="requestDidFailWithRequest:error:"></a>
### requestDidFailWithRequest:error:

`- (void)requestDidFailWithRequest:(MLSBaseRequest *)*request* error:(NSError *)*error*`

<a name="//api/name/requestDidSucceedWithRequest:" title="requestDidSucceedWithRequest:"></a>
### requestDidSucceedWithRequest:

`- (void)requestDidSucceedWithRequest:(MLSBaseRequest *)*request*`

<a name="//api/name/resetURLSessionManager" title="resetURLSessionManager"></a>
### resetURLSessionManager

`- (void)resetURLSessionManager`

<a name="//api/name/resetURLSessionManagerWithConfiguration:" title="resetURLSessionManagerWithConfiguration:"></a>
### resetURLSessionManagerWithConfiguration:

`- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)*configuration*`

