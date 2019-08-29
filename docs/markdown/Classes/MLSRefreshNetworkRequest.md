# MLSRefreshNetworkRequest Class Reference

&nbsp;&nbsp;**Conforms to** ContentType<br />  
__covariant  
&nbsp;&nbsp;**Declared in** MLSRefreshNetworkRequest.h  

## Overview

在使用此类的时候，需要进行强持有，才能保证刷新页码递增，如果不强持有，每次都会从0开始
属性列表中，所有以 Key 结尾的属性，如果为空，那么对应字段不再写入参数中

## Tasks

### 

[&nbsp;&nbsp;pageKey](#//api/name/pageKey) *property* 

[&nbsp;&nbsp;pageStartNum](#//api/name/pageStartNum) *property* 

[&nbsp;&nbsp;currentPage](#//api/name/currentPage) *property* 

[&nbsp;&nbsp;pageLimitKey](#//api/name/pageLimitKey) *property* 

[&nbsp;&nbsp;pageLimitValue](#//api/name/pageLimitValue) *property* 

[&ndash;&nbsp;pullDown](#//api/name/pullDown)  

[&ndash;&nbsp;pullUp](#//api/name/pullUp)  

## Properties

<a name="//api/name/currentPage" title="currentPage"></a>
### currentPage

当前是第几页

`@property (nonatomic, assign, readonly) NSUInteger currentPage`

#### Declared In
* `MLSRefreshNetworkRequest.h`

<a name="//api/name/pageKey" title="pageKey"></a>
### pageKey

刷新页码键值 key

`@property (nonatomic, copy, nullable) NSString *pageKey`

#### Declared In
* `MLSRefreshNetworkRequest.h`

<a name="//api/name/pageLimitKey" title="pageLimitKey"></a>
### pageLimitKey

每页获取多少 Key

`@property (nonatomic, copy, nullable) NSString *pageLimitKey`

#### Declared In
* `MLSRefreshNetworkRequest.h`

<a name="//api/name/pageLimitValue" title="pageLimitValue"></a>
### pageLimitValue

每页获取多少 Value

`@property (nonatomic, assign) NSUInteger pageLimitValue`

#### Declared In
* `MLSRefreshNetworkRequest.h`

<a name="//api/name/pageStartNum" title="pageStartNum"></a>
### pageStartNum

起始页码，也就是第一次网络请求的页码

`@property (nonatomic, assign) NSUInteger pageStartNum`

#### Declared In
* `MLSRefreshNetworkRequest.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/pullDown" title="pullDown"></a>
### pullDown

下拉刷新

`- (MLSRefreshNetworkRequest *)pullDown`

#### Return Value
request 本身，内部只对参数进行处理

#### Declared In
* `MLSRefreshNetworkRequest.h`

<a name="//api/name/pullUp" title="pullUp"></a>
### pullUp

上拉加载

`- (MLSRefreshNetworkRequest *)pullUp`

#### Return Value
request 本身，内部只对参数进行处理

#### Declared In
* `MLSRefreshNetworkRequest.h`

