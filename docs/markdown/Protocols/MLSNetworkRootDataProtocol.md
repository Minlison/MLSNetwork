# MLSNetworkRootDataProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSRequestProtocol.h  

## Overview

网络返回数据根数据结构（常规）

## Tasks

### 

[&nbsp;&nbsp;code](#//api/name/code) *property* *required method*

[&nbsp;&nbsp;responseHeaderStatusCode](#//api/name/responseHeaderStatusCode) *property* *required method*

[&nbsp;&nbsp;message](#//api/name/message) *property* *required method*

[&nbsp;&nbsp;remark](#//api/name/remark) *property* *required method*

[&nbsp;&nbsp;data](#//api/name/data) *property* *required method*

[&ndash;&nbsp;isValid](#//api/name/isValid)  *required method*

[&ndash;&nbsp;responseHeaderStatusCodeIsValid](#//api/name/responseHeaderStatusCodeIsValid)  *required method*

[&ndash;&nbsp;validError](#//api/name/validError)  *required method*

[&ndash;&nbsp;needRetryPreRequest](#//api/name/needRetryPreRequest)  *required method*

[&ndash;&nbsp;needRetry](#//api/name/needRetry)  *required method*

[&ndash;&nbsp;retryPreRequest](#//api/name/retryPreRequest)  *required method*

## Properties

<a name="//api/name/code" title="code"></a>
### code

错误码 （服务器返回）

`@property (nonatomic, assign) NSInteger code`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/data" title="data"></a>
### data

数据内容

`@property (nonatomic, strong) id data`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/message" title="message"></a>
### message

提示信息

`@property (nonatomic, copy) NSString *message`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/remark" title="remark"></a>
### remark

日志信息

`@property (nonatomic, copy) NSString *remark`

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/responseHeaderStatusCode" title="responseHeaderStatusCode"></a>
### responseHeaderStatusCode

HTTP 错误码 （request 内部会对其赋值）

`@property (nonatomic, assign) NSInteger responseHeaderStatusCode`

#### Declared In
* `MLSRequestProtocol.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/isValid" title="isValid"></a>
### isValid

是否有效
如果返回 NO ，则会重新请求该网络，并且不会缓存该网络内容

`- (BOOL)isValid`

#### Return Value
是否有效

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/needRetry" title="needRetry"></a>
### needRetry

是否需要重新请求

`- (BOOL)needRetry`

#### Return Value
是否重新请求

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/needRetryPreRequest" title="needRetryPreRequest"></a>
### needRetryPreRequest

是否需要在重试请求前，去请求对应 Request 的 preRequest

`- (BOOL)needRetryPreRequest`

#### Return Value
是否在重试前请求 preRequest

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/responseHeaderStatusCodeIsValid" title="responseHeaderStatusCodeIsValid"></a>
### responseHeaderStatusCodeIsValid

HTTP 响应码是否有效

`- (BOOL)responseHeaderStatusCodeIsValid`

#### Return Value
是否有效

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/retryPreRequest" title="retryPreRequest"></a>
### retryPreRequest

<a href="#//api/name/needRetryPreRequest"><code>needRetryPreRequest</code></a> 返回 YES 后， 并且对应的 Request <code>retryPreRequest</code> 字段为 nil, 则使用该网络请求

`- (nullable id&lt;MLSRetryPreRequestProtocol&gt;)retryPreRequest`

#### Return Value
预处理请求

#### Declared In
* `MLSRequestProtocol.h`

<a name="//api/name/validError" title="validError"></a>
### validError

错误信息

`- (nullable NSError *)validError`

#### Declared In
* `MLSRequestProtocol.h`

