# MLSNetworkModelProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkConfig.h  

## Overview

对外暴露接口，字典转模型

## Tasks

### 

[+&nbsp;modelWithClass:isArray:withJSON:](#//api/name/modelWithClass:isArray:withJSON:)  *required method*

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/modelWithClass:isArray:withJSON:" title="modelWithClass:isArray:withJSON:"></a>
### modelWithClass:isArray:withJSON:

字典转模型

`+ (id)modelWithClass:(Class)*modelClass* isArray:(BOOL)*isArray* withJSON:(id)*json*`

#### Parameters

*modelClass*  
&nbsp;&nbsp;&nbsp;模型 Class  

*json*  
&nbsp;&nbsp;&nbsp;<code>NSDictionary</code>, <code>NSString</code> or <code>NSData</code>.  

#### Return Value
nil 或者 ModelClass 对应的 Model

#### Declared In
* `MLSNetworkConfig.h`

