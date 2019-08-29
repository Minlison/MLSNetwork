# MLSNetworkQueuePool Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkQueuePool.h  

## Overview

A dispatch <a href="#//api/name/queue">queue</a> pool holds multiple serial queues.
Use this class to control queue&rsquo;s thread count (instead of concurrent <a href="#//api/name/queue">queue</a>).

## Tasks

### 

[&ndash;&nbsp;init](#//api/name/init)  

[+&nbsp;new](#//api/name/new)  

[&ndash;&nbsp;initWithName:queueCount:qos:](#//api/name/initWithName:queueCount:qos:)  

[&nbsp;&nbsp;name](#//api/name/name) *property* 

[&ndash;&nbsp;queue](#//api/name/queue)  

[+&nbsp;defaultPoolForQOS:](#//api/name/defaultPoolForQOS:)  

## Properties

<a name="//api/name/name" title="name"></a>
### name

Pool&rsquo;s name.

`@property (nullable, nonatomic, readonly) NSString *name`

#### Declared In
* `MLSNetworkQueuePool.h`

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/defaultPoolForQOS:" title="defaultPoolForQOS:"></a>
### defaultPoolForQOS:

`+ (instancetype)defaultPoolForQOS:(NSQualityOfService)*qos*`

<a name="//api/name/new" title="new"></a>
### new

`+ (instancetype)new`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/init" title="init"></a>
### init

`- (instancetype)init`

<a name="//api/name/initWithName:queueCount:qos:" title="initWithName:queueCount:qos:"></a>
### initWithName:queueCount:qos:

Creates and returns a dispatch <a href="#//api/name/queue">queue</a> pool.

`- (instancetype)initWithName:(nullable NSString *)*name* queueCount:(NSUInteger)*queueCount* qos:(NSQualityOfService)*qos*`

#### Parameters

*name*  
&nbsp;&nbsp;&nbsp;The <a href="#//api/name/name">name</a> of the pool.  

*queueCount*  
&nbsp;&nbsp;&nbsp;Maxmium <a href="#//api/name/queue">queue</a> count, should in range (1, 32).  

*qos*  
&nbsp;&nbsp;&nbsp;Queue quality of service (QOS).  

#### Return Value
A <a href="#//api/name/new">new</a> pool, or nil if an error occurs.

#### Declared In
* `MLSNetworkQueuePool.h`

<a name="//api/name/queue" title="queue"></a>
### queue

Get a serial queue from pool.

`- (dispatch_queue_t)queue`

#### Declared In
* `MLSNetworkQueuePool.h`

