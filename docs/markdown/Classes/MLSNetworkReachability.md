# MLSNetworkReachability Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkReachability.h  

## Tasks

### 

[+&nbsp;shareManager](#//api/name/shareManager)  

[+&nbsp;reachabilityWithHostName:](#//api/name/reachabilityWithHostName:)  

[+&nbsp;reachabilityWithAddress:](#//api/name/reachabilityWithAddress:)  

[+&nbsp;reachabilityForInternetConnection](#//api/name/reachabilityForInternetConnection)  

[&ndash;&nbsp;startNotifier](#//api/name/startNotifier)  

[&ndash;&nbsp;stopNotifier](#//api/name/stopNotifier)  

[&ndash;&nbsp;isWifi](#//api/name/isWifi)  

[&ndash;&nbsp;isWLAN](#//api/name/isWLAN)  

[&ndash;&nbsp;isReachabile](#//api/name/isReachabile)  

[&ndash;&nbsp;setReachabilityStatusChangeBlock:](#//api/name/setReachabilityStatusChangeBlock:)  

[&ndash;&nbsp;currentReachabilityStatus](#//api/name/currentReachabilityStatus)  

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/reachabilityForInternetConnection" title="reachabilityForInternetConnection"></a>
### reachabilityForInternetConnection

检查默认路由是否可用。 不能连接到特定主机。

`+ (instancetype)reachabilityForInternetConnection`

#### Return Value
MLSNetworkReachability Obj 不是单例

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/reachabilityWithAddress:" title="reachabilityWithAddress:"></a>
### reachabilityWithAddress:

根据指定 IP 判断网络状态

`+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)*hostAddress*`

#### Parameters

*hostAddress*  
&nbsp;&nbsp;&nbsp;IP 地址  

#### Return Value
MLSNetworkReachability Obj 不是单例

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/reachabilityWithHostName:" title="reachabilityWithHostName:"></a>
### reachabilityWithHostName:

根据指定域名，来判断网络状态

`+ (instancetype)reachabilityWithHostName:(NSString *)*hostName*`

#### Parameters

*hostName*  
&nbsp;&nbsp;&nbsp;域名  

#### Return Value
MLSNetworkReachability Obj 不是单例

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/shareManager" title="shareManager"></a>
### shareManager

单例，以当前网络连接来判断网络状态

`+ (instancetype)shareManager`

#### Return Value
单例

#### Declared In
* `MLSNetworkReachability.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/currentReachabilityStatus" title="currentReachabilityStatus"></a>
### currentReachabilityStatus

  当前网络状态

`- (MLSNetWorkStatus)currentReachabilityStatus`

#### Return Value
网络状态

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/isReachabile" title="isReachabile"></a>
### isReachabile

是否有网络连接

`- (BOOL)isReachabile`

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/isWLAN" title="isWLAN"></a>
### isWLAN

是否是蜂窝网络

`- (BOOL)isWLAN`

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/isWifi" title="isWifi"></a>
### isWifi

是否是 WIFI

`- (BOOL)isWifi`

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/setReachabilityStatusChangeBlock:" title="setReachabilityStatusChangeBlock:"></a>
### setReachabilityStatusChangeBlock:

设置网络状态监听回调， 只会回调最后一个设置的 block

`- (void)setReachabilityStatusChangeBlock:(nullable void ( ^ ) ( MLSNetWorkStatus status ))*block*`

#### Parameters

*block*  
&nbsp;&nbsp;&nbsp;回调 block  

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/startNotifier" title="startNotifier"></a>
### startNotifier

开启网络监测

`- (BOOL)startNotifier`

#### Return Value
是否开启成功

#### Declared In
* `MLSNetworkReachability.h`

<a name="//api/name/stopNotifier" title="stopNotifier"></a>
### stopNotifier

停止网络监测

`- (void)stopNotifier`

#### Declared In
* `MLSNetworkReachability.h`

