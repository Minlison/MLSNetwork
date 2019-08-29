# MLSBatchRequestAgent Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSBatchRequestAgent.h  

## Overview

网络请求代理
用来管理项目中所有的并发网络请求

## Tasks

### 

[&ndash;&nbsp;init](#//api/name/init)  

[+&nbsp;new](#//api/name/new)  

[+&nbsp;sharedAgent](#//api/name/sharedAgent)  

[+&nbsp;shareAgentWithMoudleIdentifer:](#//api/name/shareAgentWithMoudleIdentifer:)  

[&ndash;&nbsp;addBatchRequest:](#//api/name/addBatchRequest:)  

[&ndash;&nbsp;removeBatchRequest:](#//api/name/removeBatchRequest:)  

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/new" title="new"></a>
### new

`+ (instancetype)new`

<a name="//api/name/shareAgentWithMoudleIdentifer:" title="shareAgentWithMoudleIdentifer:"></a>
### shareAgentWithMoudleIdentifer:

模块化代理
会获取request的

`+ (MLSBatchRequestAgent *)shareAgentWithMoudleIdentifer:(NSString *)*moudleIdentifier*`

#### Return Value
agent

#### Declared In
* `MLSBatchRequestAgent.h`

<a name="//api/name/sharedAgent" title="sharedAgent"></a>
### sharedAgent

单利

`+ (MLSBatchRequestAgent *)sharedAgent`

#### Return Value
单利代理

#### Declared In
* `MLSBatchRequestAgent.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addBatchRequest:" title="addBatchRequest:"></a>
### addBatchRequest:

添加一个并发网络请求

`- (void)addBatchRequest:(MLSBatchRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSBatchRequestAgent.h`

<a name="//api/name/init" title="init"></a>
### init

`- (instancetype)init`

<a name="//api/name/removeBatchRequest:" title="removeBatchRequest:"></a>
### removeBatchRequest:

移除一个并发网络请求

`- (void)removeBatchRequest:(MLSBatchRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSBatchRequestAgent.h`

