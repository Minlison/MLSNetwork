//
//  MLSBaseRequest.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MLSRequestProtocol.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MLSUrlFilterProtocol;

typedef void (^MLSRequestUploadProgressBlock)(NSProgress *uploadProgress);
typedef void (^MLSRequestDownloadProgressBlock)(NSProgress *uploadProgress);

/**
 网络请求基类
 */
@interface MLSBaseRequest : NSObject <MLSRequestSubclassHolderProtocol>
#pragma mark - Protocol Property

/**
 回调线程
 默认为 dispatch_get_main_queue()
 callbackOnAsyncQueue 设置两个回调线程
 */
@property (nonatomic, assign, readonly) dispatch_queue_t callbackQueue;

/**
 是否在异步线程回调
 */
@property (nonatomic, assign) BOOL callbackOnAsyncQueue;

/**
 网络请求 URL
 该 URL 的优先级高于 Configuation 的优先级
 根 URL 类似 http://www.baidu.com
 网络请求 URL
 */
@property (nonatomic, copy) NSString *baseUrl;

/**
 二级地址
 如果要请求的地址为 http://www.baidu.com/api/user
 则 baseUrl 为 http://www.baidu.com
 requestUrl 为 /api/user
 
 二级地址
 */
@property (nonatomic, copy) NSString *requestUrl;

/**
 CDN 地址
 
 CDN 地址
 */
@property (nonatomic, copy) NSString *cdnUrl;

/**
 超时时长
 
 超时时长 单位 秒
 */
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;

/**
 HTTP Method
 
 请求方法
 */
@property (nonatomic, assign) MLSRequestMethod requestMethod;

/**
 请求解析类型
 
 请求的参数解析类型
 */
@property (nonatomic, assign) MLSRequestSerializerType requestSerializerType;

/**
 响应内容解析类型
 
 解析类型
 */
@property (nonatomic, assign) MLSResponseSerializerType responseSerializerType;

/**
 请求头授权
 
 授权内容
 */
@property (nonatomic, strong, nullable) NSMutableDictionary *requestAuthorizationHeaderFieldDictionary;

/**
 请求头
 
 请求头参数字典
 */
@property (nonatomic, strong, nullable) NSMutableDictionary *requestHeaderFieldValueDictionary;

/**
 可接收 Content-Type
 
 Content-Types
 */
@property (nonatomic, strong, nullable) NSMutableSet <NSString *>*acceptableContentTypes;

/**
 是否使用 CDN
 
 YES 使用 NO 不使用
 */
@property (nonatomic, assign) BOOL useCDN;

/**
 是否允许蜂窝网络
 默认是 YES
 @return 是否允许蜂窝网络访问
 */
@property (nonatomic, assign) BOOL allowsCellularAccess;

#pragma mark - Request and Response Information

/**
 请求的 task
 */
@property (nonatomic, strong, readonly) NSURLSessionTask *requestTask;

/**
  如果有重定向，则是重定向后的 request
 */
@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;

/**
 请求如果有重定向，是重定向前的 request requestTask.originalRequest
 */
@property (nonatomic, strong, readonly) NSURLRequest *originalRequest;

/**
 网络数据响应内容
 */
@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;

/**
 网络数据响应码
 */
@property (nonatomic, readonly) NSInteger responseHeaderStatusCode;

/**
 响应头
 */
@property (nonatomic, strong, readonly, nullable) NSDictionary *responseHeaders;

/**
 响应数据
 */
@property (nonatomic, strong, readonly, nullable) NSData *responseData;

/**
 响应字符串数据
 */
@property (nonatomic, strong, readonly, nullable) NSString *responseString;

/**
 序列化前的数据， 字符串、NSData
 */
@property (nonatomic, strong, readonly, nullable) id responseObject;

/**
 JSON序列化后的数据，字典、数组、或者为空
 */
@property (nonatomic, strong, readonly, nullable) id responseJSONObject;

/**
 错误描述
 */
@property (nonatomic, strong, readonly, nullable) NSError *error;

/**
 是否取消
 */
@property (nonatomic, readonly, getter=isCancelled) BOOL cancelled;

/**
 是否正在执行
 */
@property (nonatomic, readonly, getter=isExecuting) BOOL executing;


#pragma mark - Request Configuration

/**
 模块标识，用来回去 MLSNetworkAgent 和 MLSNetworkConfig
 默认为空
 如果要重新设置，请建立baseRequest，并返回对应模块标识
 */
@property (nonatomic, copy, nullable, readonly) NSString *moudleIdentifier;

/**
 网络请求过滤器
 优先级高于 Config
 */
@property (nonatomic, strong, readonly, nullable) NSMutableArray < id <MLSUrlFilterProtocol> > *urlFilters;

/**
 标签
 */
@property (nonatomic) NSInteger tag;

/**
 唯一标识符
 每个网络请求，只有一个 uuid， 根据时间戳，参数 md5 后的值
 */
@property (nonatomic, copy, readonly, nonnull) NSString *uuid;

/**
 对当前 request 的描述信息，内部变量必须遵守 NSCoding 协议
 */
@property (nonatomic, strong, nullable) NSDictionary *userInfo;

/**
 参数的唯一字符串，如果是字典，则进行 key 排序后进行拼接
 */
@property (nonatomic, copy, readonly) NSString *paramUniqueString;

/**
 代理
 */
@property (nonatomic, weak, nullable) id<MLSRequestDelegate> delegate;

/**
 完成回调（成功）
 */
@property (nonatomic, copy, nullable) MLSRequestCompletionBlock successCompletionBlock;

/**
 失败回调
 */
@property (nonatomic, copy, nullable) MLSRequestCompletionBlock failureCompletionBlock;

/**
 网络请求监听器
 */
@property (nonatomic, strong, nullable) NSMutableArray< id <MLSRequestAccessory> > *requestAccessories;

/**
 form 表单上传拼接数据
 */
@property (nonatomic, copy, nullable) AFConstructingBlock constructingBodyBlock;

/**
 上传进度
 */
@property (nonatomic, copy, nullable) MLSRequestUploadProgressBlock uploadProgress;

/**
 下载进度
 */
@property (nonatomic, copy, nullable) MLSRequestUploadProgressBlock downloadProgress;

/**
 继续下载的 resumeData 存放路径
 */
@property (nonatomic, strong, nullable) NSString *resumableDownloadPath;

/**
 下载进度回调
 */
@property (nonatomic, copy, nullable) AFURLSessionTaskProgressBlock resumableDownloadProgressBlock;

/**
 请求级别
 */
@property (nonatomic) MLSRequestPriority requestPriority __IOS_AVAILABLE(8.0);


/**
 设置回调 block

 @param success  成功
 @param failure 失败
 */
- (void)setCompletionBlockWithSuccess:(nullable MLSRequestCompletionBlock)success
                              failure:(nullable MLSRequestCompletionBlock)failure;


/**
 清除 block，放置 block 循环引用
 */
- (void)clearCompletionBlock;

/**
 添加网络请求监听器

 @param accessory 网络请求监听器
 */
- (void)addAccessory:(id<MLSRequestAccessory>)accessory;

/**
 删除网络请求监听器
 
 @param accessory 网络请求监听器
 */
- (void)removeAccessory:(id<MLSRequestAccessory>)accessory;

/**
 增加一个请求过滤器
 
 @param filter 过滤器
 */
- (void)addUrlFilter:(id<MLSUrlFilterProtocol>)filter;

/**
 移除过滤器
 
 @param filter 过滤器
 */
- (void)removeUrlFilter:(id<MLSUrlFilterProtocol>)filter;

#pragma mark - Request Action

/**
 开始网络请求
 */
- (void)start;

/**
 停止网络请求
 */
- (void)stop;

/**
 开始网络请求

 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithCompletionBlockWithSuccess:(nullable MLSRequestCompletionBlock)success
                                    failure:(nullable MLSRequestCompletionBlock)failure;

@end

NS_ASSUME_NONNULL_END
