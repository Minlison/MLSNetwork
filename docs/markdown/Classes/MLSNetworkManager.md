# MLSNetworkManager Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Declared in** MLSNetworkManager.h  

## Tasks

### 

[+&nbsp;configWithMoudleIdentifier:](#//api/name/configWithMoudleIdentifier:)  

[+&nbsp;agentWithMoudleIdentifier:](#//api/name/agentWithMoudleIdentifier:)  

[+&nbsp;batchAgentWithMoudleIdentifier:](#//api/name/batchAgentWithMoudleIdentifier:)  

[+&nbsp;chainAgentWithMoudleIdentifier:](#//api/name/chainAgentWithMoudleIdentifier:)  

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/agentWithMoudleIdentifier:" title="agentWithMoudleIdentifier:"></a>
### agentWithMoudleIdentifier:

根据moudleIdentifier获取agent信息
如果没有，则会创建

`+ (MLSNetworkAgent *)agentWithMoudleIdentifier:(NSString *)*moudleIdentifier*`

#### Parameters

*moudleIdentifier*  
&nbsp;&nbsp;&nbsp;模块标识  

#### Return Value
<a href="../Classes/MLSNetworkAgent.html">MLSNetworkAgent</a>

#### Declared In
* `MLSNetworkManager.h`

<a name="//api/name/batchAgentWithMoudleIdentifier:" title="batchAgentWithMoudleIdentifier:"></a>
### batchAgentWithMoudleIdentifier:

根据moudleIdentifier获取batchAgent信息
如果没有，则会创建

`+ (MLSBatchRequestAgent *)batchAgentWithMoudleIdentifier:(NSString *)*moudleIdentifier*`

#### Parameters

*moudleIdentifier*  
&nbsp;&nbsp;&nbsp;模块标识  

#### Return Value
<a href="../Classes/MLSBatchRequestAgent.html">MLSBatchRequestAgent</a>

#### Declared In
* `MLSNetworkManager.h`

<a name="//api/name/chainAgentWithMoudleIdentifier:" title="chainAgentWithMoudleIdentifier:"></a>
### chainAgentWithMoudleIdentifier:

根据moudleIdentifier获取chainAgent信息
如果没有，则会创建

`+ (MLSChainRequestAgent *)chainAgentWithMoudleIdentifier:(NSString *)*moudleIdentifier*`

#### Parameters

*moudleIdentifier*  
&nbsp;&nbsp;&nbsp;模块标识  

#### Return Value
<a href="../Classes/MLSChainRequestAgent.html">MLSChainRequestAgent</a>

#### Declared In
* `MLSNetworkManager.h`

<a name="//api/name/configWithMoudleIdentifier:" title="configWithMoudleIdentifier:"></a>
### configWithMoudleIdentifier:

根据moudleIdentifier获取配置信息
如果没有，则会创建

`+ (MLSNetworkConfig *)configWithMoudleIdentifier:(NSString *)*moudleIdentifier*`

#### Parameters

*moudleIdentifier*  
&nbsp;&nbsp;&nbsp;模块标识  

#### Return Value
<a href="../Classes/MLSNetworkConfig.html">MLSNetworkConfig</a>

#### Declared In
* `MLSNetworkManager.h`

