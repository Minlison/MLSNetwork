# MLSRequestAccessory Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSRequestProtocol.h  

## Overview

网络请求状态监听

## Tasks

### 

[&ndash;&nbsp;requestWillStart:](#//api/name/requestWillStart:)  

[&ndash;&nbsp;requestWillStop:](#//api/name/requestWillStop:)  

[&ndash;&nbsp;requestDidStop:](#//api/name/requestDidStop:)  

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/requestDidStop:" title="requestDidStop:"></a>
### requestDidStop:

网络请求停止

`- (void)requestDidStop:(id)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestWillStart:" title="requestWillStart:"></a>
### requestWillStart:

将要发起请求

`- (void)requestWillStart:(id)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网路请求  

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/requestWillStop:" title="requestWillStop:"></a>
### requestWillStop:

网路请求即将停止

`- (void)requestWillStop:(id)*request*`

#### Parameters

*request*  
&nbsp;&nbsp;&nbsp;网络请求  

#### Declared In
* `MLSRequestProtocol.h`

