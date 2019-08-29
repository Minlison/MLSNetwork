# MLSNetwork 网络工具
-----

## 模块说明
基于 [YTKNetwork](https://github.com/yuantiku/YTKNetwork) 代码二次修改封装，
功能点：

	1. 日志和缓存由协议配置处理
	2. 对网络请求有缓存管理
	3. 网络错误重试功能
	
[模块接口文档](./docs/html/index.html)

## 主要功能
1. MLSNetworkRequest 网络请求基类，每个网络请求，都应继承该基类。一个借口对应一个 Request 的原则进行处理
2. MLSRefreshNetworkRequest，具有刷新功能的网络请求


## 项目依赖
因源码需要修改，所有源码均下载修改后使用

## 使用说明

* 第一步：在编辑好的 Podfile 中，添加 pod 依赖，添加 `pod 'MLSNetwork', :path => '相对路径'`
* 第二步：执行命令 `pod install`, 并引入 `#import <MLSNetwork/MLSNetwork.h>` 头文件

* 第三步：继承 `MLSNetworkRequest ` 或者 `MLSRefreshNetworkRequest` 写对应接口。
* 第四步：发起请求。
