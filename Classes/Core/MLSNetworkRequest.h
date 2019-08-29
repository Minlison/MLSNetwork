//
//  MLSNetworkRequest.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MLSRequest.h"
#import "MLSRequestProtocol.h"
FOUNDATION_EXPORT NSString *const MLSRequestRetryErrorDomain;
//// error 的 userinfo 获取对应错误信息
FOUNDATION_EXPORT NSString *const MLSRequestRetryOriginErrorKey;
FOUNDATION_EXPORT NSString *const MLSRequestRetryRetryErrorKey;

/**
 在使用 MLSNetwork 框架的时候，必须要定义一个网络根数据结构，继承 MLSNetworkRootDataProtocol
 可用于重试机制判断
 */
@protocol MLSNetworkCacheProtocol;
@protocol MLSNetworkModelProtocol;
@protocol MLSEncryptProtocol;
@protocol MLSNetworkRootDataProtocol;
@protocol MLSNetworkLogProtocol;
@interface MLSNetworkRequest <__covariant ContentType> : MLSRequest <MLSRetryPreRequestProtocol>

typedef void(^MLSNetworkRequestCompletionBlock)(__kindof MLSNetworkRequest *request, ContentType model);

/**
  完成的请求参数，包括 paraInsert 后的参数
 */
@property (nonatomic, strong, readonly) id requestFullParams;

/**
 服务器返回的信息
 成功，或者失败提示信息
 */
@property (nonatomic, copy, readonly) NSString *tipString;

/// MARK: - 重试机制
/**
 错误最大重试次数
 默认 不重试
 */
@property (nonatomic, assign) NSUInteger maxRetryCount;

/**
 错误重试次数 默认 3 次
 */
@property (nonatomic, assign, readonly) NSUInteger retryCount;

/**
 是否需要重试
 */
@property (nonatomic, assign) BOOL needRetry;

/**
 是否需要在重试前调用 retryPreRequest
 */
@property (nonatomic, assign) BOOL needRetryPreRequest;

/**
 延时重试，默认 0
 */
@property (nonatomic, assign) NSTimeInterval retryDelay;

/**
 在错误重试前，必须要请求而且成功的 request
 */
@property (nonatomic, strong) id <MLSRetryPreRequestProtocol> retryPreRequest;

/**
 需要重试前调用 retryPreRequest 的错误码
 */
@property (nonatomic, strong) NSMutableSet <NSNumber *>*retryPreRequestCodes;

/// MARK: - Model 相关
/**
 服务器返回的根数据
 */
@property (nonatomic, strong, readonly) id <MLSNetworkRootDataProtocol> serverRootData;

/**
 需要提取的 模型数据
 */
@property (nonatomic, strong, readonly) ContentType responseModelData;

/**
 需要转模型的 Class
 */
@property (nonatomic, strong) Class modelClass;

/// 和 MLSNetworkConfig 的属性一直, 优先级高于 MLSNetworkConfig
/**
 缓存管理
 */
@property (nonatomic, strong) id <MLSNetworkCacheProtocol> cacheManager;

/**
 字典转模型工具
 */
@property (nonatomic, strong) id <MLSNetworkModelProtocol> modelManager;

/**
 加解密工具
 */
@property (nonatomic, strong) id <MLSEncryptProtocol> enctyptManager;

/**
 服务器返回的根数据结构
 */
@property (nonatomic, strong) Class <MLSNetworkRootDataProtocol> serverRootDataClass;

/**
 日志工具
 */
@property (nonatomic, strong) id <MLSNetworkLogProtocol> logger;


/**
 需要提取的子集模型
 {
     "code": 0,
     "message": "成功",
     "data": {
         "name": "BeJson",
         "url": "http://www.bejson.com",
         "page": 88,
         "isNonProfit": true,
         "address": {
             "street": "科技园路.",
             "city": "江苏苏州",
             "country": "中国"
         }
     }
 }
 如果 modelClass 为 links 对应的 class， 想要网络请求完成，自动转换模型为 links 的模型
 则 modelKeyPath 设置为 data.links
 如果不设置，默认是真个 data 块
 */
@property (nonatomic, copy) NSString *modelKeyPath;

/**
 快速创建网络请求

 @param param 参数
 @return 网络请求
 */
+ (instancetype)requestWithParam:(nullable id)param;

/**
 插入参数
 会覆盖原本参数
 @param obj 参数
 @param key 对应键
 */
- (void)paramInsert:(id)obj forKey:(NSString *)key;
- (void)paramInsert:(NSDictionary *)insertParam;

/**
 删除参数
 
 @param key 对应键
 */
- (void)paramDelForKey:(NSString *)key;
- (void)paramDel:(NSDictionary *)delParam;
- (void)paramDelForKeys:(NSArray *)delParamKeys;

/**
 开始网络请求

 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithModelCompletionBlockWithSuccess:(MLSNetworkRequestCompletionBlock)success failure:(MLSNetworkRequestCompletionBlock)failure;

/**
 网络请求

 @param cacheable 是否 缓存
 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithCache:(BOOL)cacheable modelCompletionBlockWithSuccess:(MLSNetworkRequestCompletionBlock)success failure:(MLSNetworkRequestCompletionBlock)failure;

@end
