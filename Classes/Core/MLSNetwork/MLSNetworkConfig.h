//
//  MLSNetworkConfig.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLSBaseRequest;
@class AFSecurityPolicy;
@protocol MLSNetworkLogProtocol;
@protocol MLSNetworkCacheProtocol;
@protocol MLSNetworkRootDataProtocol;
/**
 url 过滤协议
 在每个网络请求发送前，都会调用改方法，用来对网络请求增加一些公共参数
 */
@protocol MLSUrlFilterProtocol <NSObject>
@optional
/**
 在网络请求发送前，对 request 进行解析

 @param originUrl 原 url
 @param request 网络请求
 @return 新的 url ，如果 url 本身不拼接参数，直接返回 originUrl
 */
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(MLSBaseRequest *)request;

/**
  过滤参数

 @param originParams 原始参数
 @param request 网络请求
 @return 返回修改过后的参数
 */
- (id)filterParams:(id)originParams withRequest:(MLSBaseRequest *)request;

/**
 过滤请求头

 @param originHeaderFieldValue 原始请求头，可变字典，可以直接增加或者删除参数
 @param request 网络请求
 @return 是否修改过参数，如果修改过，则返回 YES， 否则返回 NO
 */
- (BOOL)filterHeaderFieldValue:(NSMutableDictionary <NSString *, NSString *> *)originHeaderFieldValue withRequest:(MLSBaseRequest *)request;

/**
  授权过滤

 @param authorizationHeaderFieldValue 授权 username  password
 @param request  网络请求
 @return 是否修改过 ，如果修改过，则返回 YES， 否则返回 NO
 */
- (BOOL)filterAuthorizationHeaderFieldValue:(NSMutableDictionary <NSString *,NSString *> *)authorizationHeaderFieldValue withRequest:(MLSBaseRequest *)request;
@end

/**
 对外暴露日志接口
 针对不同级别的日志进行控制输出
 */
typedef NS_ENUM(NSInteger, MLSNetworkLogLevel)
{
    MLSNetworkLogLevelAll,
    MLSNetworkLogLevelVerbose,
    MLSNetworkLogLevelDebug,
    MLSNetworkLogLevelInfo,
    MLSNetworkLogLevelWarning,
    MLSNetworkLogLevelError,
};

@protocol MLSNetworkLogProtocol <NSObject>

/**
 输出日志

 @param level 日志级别
 @param fmt fmt string
 */
+ (void)log:(MLSNetworkLogLevel)level msg:(NSString *)fmt,...;
@end

/**
 网络库缓存协议
 对外暴露缓存接口，对每个网络请求数据进行缓存，外部控制每个缓存的过期时间。
 */
@protocol MLSNetworkCacheProtocol <NSObject>

/**
 缓存对象
 
 @param obj 需要缓存的对象
 @param key  key
 */
+ (void)setObj:(nullable NSObject <NSCoding>*)obj forKey:(NSString *)key;

/**
 获取对象
 
 @param key  key
 @return nil or object
 */
+ (nullable NSObject <NSCoding>*)cachedObjectForKey:(NSString *)key;

@end

/**
 对外暴露接口，字典转模型
 */
@protocol MLSNetworkModelProtocol <NSObject>

/**
 字典转模型

 @param modelClass 模型 Class
 @param json `NSDictionary`, `NSString` or `NSData`.
 @return nil 或者 ModelClass 对应的 Model
 */
+ (id)modelWithClass:(Class)modelClass isArray:(BOOL)isArray withJSON:(id)json;
@end

/**
 加密解密协议，只针对网络数据，全部加解密处理，如果需要对返回的某个字段进行加解密，请在外部处理
 */
@protocol  MLSEncryptProtocol <NSObject>

/**
 加密参数
 
 @param param 参数
 @return 加密后的参数
 */
+ (NSDictionary *)encryptSubmitParam:(NSDictionary *)param;

/**
 解密服务器返回的数据
 
 @param data 服务器返回的加密数据
 @return 解密后的数据 (NSData)
 */
+ (NSData *)decryptServerData:(NSData *)data;

/**
 加密数据数据
 
 @param data 加密前s的数据
 @return 加密后的数据 (NSData)
 */
+ (NSData *)encryptSubmitData:(NSData *)data;
@end

/**
 MARK: - 全局网络配置
 */
@interface MLSNetworkConfig : NSObject

/**
 单利

 @return 配置中心
 */
+ (MLSNetworkConfig *)sharedConfig;

/**
 模块配置
 通过配置 request 的 moduleIdentifier, request 会根据 此id查找相应配置
 
 @param moudleIdentifier 模块标识
 @return 配置中心
 */
+ (MLSNetworkConfig *)sharedConfigWithMoudleIdentifier:(NSString *)moudleIdentifier;

/**
 https 配置
 */
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

/**
 是否开启 log 日志
 */
@property (nonatomic) BOOL debugLogEnabled;

/**
 网络 Session 配置
 */
@property (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;

/**
 域名
 MLSBaseRequest 可重写
 */
@property (nonatomic, strong) NSString *baseUrl;

/**
 CDN 地址
 MLSBaseRequest 可重写
 */
@property (nonatomic, strong) NSString *cdnUrl;

/**
 网络请求过滤器
 MLSBaseRequest 可重写
 */
@property (nonatomic, strong, readonly) NSArray<id<MLSUrlFilterProtocol>> *urlFilters;

/**
 日志工具
 默认使用 NSLog
 MLSNetworkRequest 可重写
 */
@property (nonatomic, strong) id <MLSNetworkLogProtocol> logger;

/**
 缓存管理
 MLSNetworkRequest 可重写
 */
@property (nonatomic, strong) id <MLSNetworkCacheProtocol> cacheManager;

/**
 字典转模型工具
 MLSNetworkRequest 可重写
 */
@property (nonatomic, strong) id <MLSNetworkModelProtocol> modelManager;

/**
 加解密工具
 MLSNetworkRequest 可重写
 */
@property (nonatomic, strong) id <MLSEncryptProtocol> enctyptManager;

/**
 服务器返回的根数据结构
 MLSNetworkRequest 可重写
 */
@property (nonatomic, strong) Class <MLSNetworkRootDataProtocol> serverRootDataClass;

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

/**
 删除全部 url 过滤器
 */
- (void)clearUrlFilter;
@end

NS_ASSUME_NONNULL_END
