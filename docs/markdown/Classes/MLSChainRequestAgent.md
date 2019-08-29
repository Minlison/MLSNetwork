# MLSChainRequestAgent Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSChainRequestAgent.h  

## Overview

链式请求代理
用来管理项目中所有的链式网络请求

## Tasks

### 

[&ndash;&nbsp;init](#//api/name/init)  

[+&nbsp;new](#//api/name/new)  

[+&nbsp;sharedAgent](#//api/name/sharedAgent)  

[+&nbsp;shareAgentWithMoudleIdentifer:](#//api/name/shareAgentWithMoudleIdentifer:)  

[&ndash;&nbsp;addChainRequest:](#//api/name/addChainRequest:)  

[&ndash;&nbsp;removeChainRequest:](#//api/name/removeChainRequest:)  

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/new" title="new"></a>
### new

`+ (instancetype)new`

<a name="//api/name/shareAgentWithMoudleIdentifer:" title="shareAgentWithMoudleIdentifer:"></a>
### shareAgentWithMoudleIdentifer:

模块化代理
会获取request的

`+ (MLSChainRequestAgent *)shareAgentWithMoudleIdentifer:(NSString *)*moudleIdentifier*`

#### Return Value
agent

#### Declared In
* `MLSChainRequestAgent.h`

<a name="//api/name/sharedAgent" title="sharedAgent"></a>
### sharedAgent

单利

`+ (MLSChainRequestAgent *)sharedAgent`

#### Return Value
代理单利

#### Declared In
* `MLSChainRequestAgent.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/addChainRequest:" title="addChainRequest:"></a>
### addChainRequest:

添加一个链式请求

`- (void)addChainRequest:(MLSChainRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;链式请求  

#### Declared In
* `MLSChainRequestAgent.h`

<a name="//api/name/init" title="init"></a>
### init

`- (instancetype)init`

<a name="//api/name/removeChainRequest:" title="removeChainRequest:"></a>
### removeChainRequest:

移除一个链式请求

`- (void)removeChainRequest:(MLSChainRequest *)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;链式请求  

#### Declared In
* `MLSChainRequestAgent.h`

