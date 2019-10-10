# MLSNetwork 网络工具
-----

![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)

### MLSNetwork 是什么

MLSNetwork 是个人基于 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 二次修改的 iOS 高性能网络请求库，提供了更高层次的网络访问抽象。

## MLSNetwork 提供了哪些功能

相比 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 提供了更多层面的抽象API

基于 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 代码二次修改封装，

 * 支持自定义规则缓存网络请求内容，遵守 [MLSNetworkCacheProtocol](./docs/markdown/Protocols/MLSNetworkCacheProtocol.md) 并实现协议方法，可配置独立的 Request 也可使用全局  [MLSNetworkConfig](./docs/markdown/Classes/MLSNetworkConfig.md) 配置全局规则。
 * 支持独立 Request 设置服务器和 CDN 的地址
 * 支持网络请求加密和解密。 [MLSEncryptProtocol](./docs/markdown/Protocols/MLSEncryptProtocol.md)
 * 支持网络日志自定义输出和记录。 [MLSNetworkLogProtocol](./docs/markdown/Protocols/MLSNetworkLogProtocol.md) 
 * 支持网络数据转模型： [MLSNetworkModelProtocol](./docs/markdown/Protocols/MLSNetworkModelProtocol.md) 
 * 支持根据特定错误码重试网络请求 [MLSNetworkRequest](./docs/markdown/Classes/MLSNetworkRequest.md) retryCount 属性。
 * 支持统一网络跟数据结构，为了防止根数据不同意，导致上层调用时各种处理。  [MLSNetworkRootDataProtocol](./docs/markdown/Protocols/MLSNetworkRootDataProtocol.md)
 * 支持批量的网络请求发送，并统一设置它们的回调（实现在 `YTKBatchRequest` 类中）
 * 支持在发起网络请求前，先发起另外一个网络请求，适配场景：Token过期重新获取。 [MLSNetworkRequest](./docs/markdown/Classes/MLSNetworkRequest.md) preRetryRequest 属性。
 * 支持下拉刷新，上拉加载式网络请求，[MLSRefreshNetworkRequest](./docs/markdown/Classes/MLSRefreshNetworkRequest.md)
 * 支持 RAC、Coobjc 编程
	
注意：独立 Request 的配置优先级比全局优先级高，为了模块独立使用而生。

## 哪些项目适合使用 MLSNetwork

可使用在所有项目中，MLSNetwork 提供两套机制: 一种是配置后网络请求。一种是独立发起网络请求。
* 配置后网络请求：比较适用于大型项目，可校验证书，加解密，记录日志等功能。
	* 第一种方式：适用于非组件化项目，直接配置 [MLSNetworkConfig](./docs/markdown/Classes/MLSNetworkConfig.md) 即可。
	* 第二种方式：适用于组件化项目，在配置完 [MLSNetworkConfig](./docs/markdown/Classes/MLSNetworkConfig.md) 后，每个组件继承 [MLSNetworkRequest](./docs/markdown/Classes/MLSNetworkRequest.md) 独立出一个或者多个基类 Request, 该模块下网络请求发起以此为准，自定义一些模块化网络请求参数。例如：请求头，加解密等配置信息。
* 独立简答网络请求：比较适用于小型项目，没有过多要求，只需要获取网络数据，全部使用内部默认配置。
	* 直接使用 [MLSNetworkRequest](./docs/markdown/Classes/MLSNetworkRequest.md) 发起网络请求即可。

## MLSNetwork 基本思想
参考 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 后，并基于作者本人的工作经验，进行一系列常用功能的封装
* 利用重试机制，保证网络请求的健壮性，服务器临时宕机重启的几秒钟，请求不到数据，主动帮助用户重试网络请求，提升用户体验。
* 抽取全局Config配置到 Request 中，独立Request，降低与 Config 的耦合度，适配组件化多样定制化请求。
* 继承 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 的每个网络请求都是一个对象的思想，独立网路请求模块，网络层，模型层独立，可独立开发，不影响主项目工程的使用，可提前准备本地Mock数据，不依赖服务端的研发进度。
* 独立出各种协议，提升可扩展性，保证外界使用的独立性，降低耦合度。日志处理、字典转模型、加解密、根数据统一等。

## MLSNetwork 安装
你可以在 Podfile 最上方增加source源，

	source 'https://github.com/Minlison/Specs.git'

加入下面一行代码来使用 MLSNetwork

    pod 'MLSNetwork'

或者直接使用源码依赖

## 安装要求

| MLSNetwork 版本 | AFNetworking 版本 |  最低 iOS Target | 注意 |
|:----------------:|:----------------:|:----------------:|:-----|
| 1.x | 3.x | iOS 8 | 要求 Xcode 8 以上  |

## 相关的使用教程和 Demo
可参考项目中的Demo项目，不再做过多代码式的 Demo 文档，也可参考 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 的文档

## 作者
MLSNetwork 属于个人研发

## 感谢

MLSNetwork 基于 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 进行开发，感谢他们对开源社区做出的贡献。

## 协议

MLSNetwork 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。