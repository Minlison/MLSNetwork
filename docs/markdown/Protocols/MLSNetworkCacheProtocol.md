# MLSNetworkCacheProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkConfig.h  

## Overview

网络库缓存协议
对外暴露缓存接口，对每个网络请求数据进行缓存，外部控制每个缓存的过期时间。

## Tasks

### 

[+&nbsp;setObj:forKey:](#//api/name/setObj:forKey:)  *required method*

[+&nbsp;cachedObjectForKey:](#//api/name/cachedObjectForKey:)  *required method*

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/cachedObjectForKey:" title="cachedObjectForKey:"></a>
### cachedObjectForKey:

获取对象

`+ (nullable NSObject&lt;NSCoding&gt; *)cachedObjectForKey:(NSString *)*key*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;key  

#### Return Value
nil or object

#### Declared In
* `MLSNetworkConfig.h`

<a name="//api/name/setObj:forKey:" title="setObj:forKey:"></a>
### setObj:forKey:

缓存对象

`+ (void)setObj:(nullable NSObject&lt;NSCoding&gt; *)*obj* forKey:(NSString *)*key*`

#### Parameters

*obj*  
&nbsp;&nbsp;&nbsp;需要缓存的对象  

*key*  
&nbsp;&nbsp;&nbsp;key  

#### Declared In
* `MLSNetworkConfig.h`

