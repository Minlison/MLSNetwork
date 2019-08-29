//
//  MLSRequest.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//
#import "MLSBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const MLSRequestCacheErrorDomain;

typedef NS_ENUM(NSInteger, MLSRequestCacheError) {
    MLSRequestCacheErrorExpired = -1,
    MLSRequestCacheErrorVersionMismatch = -2,
    MLSRequestCacheErrorSensitiveDataMismatch = -3,
    MLSRequestCacheErrorAppVersionMismatch = -4,
    MLSRequestCacheErrorInvalidCacheTime = -5,
    MLSRequestCacheErrorInvalidMetadata = -6,
    MLSRequestCacheErrorInvalidCacheData = -7,
};

/**
 带有缓存功能的 Request
 */
@interface MLSRequest : MLSBaseRequest

/**
 是否忽略本地缓存
 */
@property (nonatomic, assign) BOOL ignoreCache;

/**
 是否允许缓存
 */
@property (nonatomic, assign) BOOL cacheable;


/**
 内容是否是从缓存中获取

 @return 是否从缓存中获取
 */
- (BOOL)isDataFromCache;


/**
 获取缓存
 @param error 错误信息
 @return 是否获取成功
 */
- (BOOL)loadCacheWithError:(NSError * __autoreleasing *)error;


/**
 请求，不使用缓存
 */
- (void)startWithoutCache;

/**
 缓存内容

 @param data 网络内容
 */
- (void)saveResponseDataToCacheFile:(NSData *)data;

#pragma mark - Subclass Override


/**
 缓存时间
 如果自定义缓存功能，则该方法失效
 @return 缓存时间，单位 s
 */
- (NSInteger)cacheTimeInSeconds;


/**
 缓存版本号

 @return 版本号
 */
- (long long)cacheVersion;

/**
 版本号字符串

 @return 版本号字符串
 */
- (NSString *)cacheVersionString;

/**
 缓存 key 的增加标识，用于标识哪些内容需要过期处理

 @return `NSArray` or `NSDictionary`， 或者是字符串，或者是自定义类的 `description` 字段
 */
- (nullable id)cacheSensitiveData;

/**
 是否异步写入缓存

 @return  默认 YES 异步
 */
- (BOOL)writeCacheAsynchronously;

/**
 开始网络请求
 
 @param cacheable 是否缓存
 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithCache:(BOOL)cacheable
    withCompletionBlockWithSuccess:(MLSRequestCompletionBlock)success
                           failure:(MLSRequestCompletionBlock)failure;


/**
 清除缓存
 */
- (void)clearCache;
@end

NS_ASSUME_NONNULL_END
