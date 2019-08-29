//
//  MLSRequestSubclassHolderProtocol.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//
#ifndef MLSRequestSubclassHolderProtocol_h
#define MLSRequestSubclassHolderProtocol_h
#import <Foundation/Foundation.h>


FOUNDATION_EXPORT NSString *const MLSRequestAuthorizationHeaderUserNameKey;
FOUNDATION_EXPORT NSString *const MLSRequestAuthorizationHeaderPasswordKey;
FOUNDATION_EXPORT NSString *const MLSRequestValidationErrorDomain;

typedef NS_ENUM(NSInteger, MLSRequestValidationErrorInvalid) {
    MLSRequestValidationErrorInvalidStatusCode = -8,
    MLSRequestValidationErrorInvalidJSONFormat = -9,
};
    

/**
 网络请求方法
 */
typedef NS_ENUM(NSInteger, MLSRequestMethod) {
    MLSRequestMethodGET = 0,
    MLSRequestMethodPOST,
    MLSRequestMethodHEAD,
    MLSRequestMethodPUT,
    MLSRequestMethodDELETE,
    MLSRequestMethodPATCH,
};


/**
 请求数据解析类型
 */
typedef NS_ENUM(NSInteger, MLSRequestSerializerType) {
    MLSRequestSerializerTypeJSON,  // Default
    MLSRequestSerializerTypeHTTP,
};

/**
 返回数据解析类型
 */
typedef NS_ENUM(NSInteger, MLSResponseSerializerType) {
    /// JSON object type
    MLSResponseSerializerTypeJSON, // Default
    /// NSData type
    MLSResponseSerializerTypeHTTP,
    /// NSXMLParser type
    MLSResponseSerializerTypeXMLParser,
};


/**
 网络请求优先级别
 */
typedef NS_ENUM(NSInteger, MLSRequestPriority) {
    MLSRequestPriorityLow = -4L,
    MLSRequestPriorityDefault = 0, // Default
    MLSRequestPriorityHigh = 4,
};

@protocol AFMultipartFormData;

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
typedef void (^AFURLSessionTaskProgressBlock)(NSProgress *);

@class MLSBaseRequest;

typedef void(^MLSRequestCompletionBlock)(__kindof MLSBaseRequest *request);


/**
 网络请求代理
 */
@protocol MLSRequestDelegate <NSObject>

@optional

/**
 请求完成（成功回调）
 
 @param request 网络请求
 */
- (void)requestFinished:(__kindof MLSBaseRequest *)request;


/**
 失败回调
 查看错误信息 request.error
 @param request 网络请求
 */
- (void)requestFailed:(__kindof MLSBaseRequest *)request;

@end


/**
 网络请求状态监听
 */
@protocol MLSRequestAccessory <NSObject>

@optional


/**
 将要发起请求
 
 @param request 网路请求
 */
- (void)requestWillStart:(id)request;


/**
 网路请求即将停止
 
 @param request 网络请求
 */
- (void)requestWillStop:(id)request;

/**
 网络请求停止
 
 @param request 网络请求
 */
- (void)requestDidStop:(id)request;

@end


/**
 子类继承可实现的方法
 */
@protocol MLSRequestSubclassHolderProtocol <NSObject>

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
@property (nonatomic, strong) NSDictionary *requestAuthorizationHeaderFieldDictionary;

/**
 请求头
 
 请求头参数字典
 */
@property (nonatomic, strong) NSDictionary *requestHeaderFieldValueDictionary;

/**
 可接收 Content-Type
 
 Content-Types
 */
@property (nonatomic, strong) NSSet <NSString *>*acceptableContentTypes;

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

/**
 在网络请求完成，没有回调到主线程之前，会调用该方法
 如果是从缓存中获取的内容，则会在主线程中调用该方法，相当于 `requestCompleteFilter`
 如果返回 NO， 则不会调用 requestCompleteFilter 方法，该网络请求不会结束
 */
- (BOOL)requestCompletePreprocessor;

/**
 网络请求成功后，会调用该方法（主线程）
 */
- (void)requestCompleteFilter;

/**
 网络请求失败调用
 类似 `requestCompletePreprocessor`.
 */
- (BOOL)requestFailedPreprocessor;

/**
 网络请求失败调用
 类似 `requestCompleteFilter`.
 */
- (void)requestFailedFilter;

/**
 参数
 
 @return 参数 NSDictionary
 */
- (nullable id)requestArgument;

/**
 拼接到url中的参数，主要针对 非GET请求，url拼接参数使用

 @return 参数 NSDictionary
 */
- (nullable NSDictionary *)requestQueryArgument;


/**
 缓存的文件名，或者 key
 
 @param argument  请求参数
 @return 缓存的文件名或者 key
 */
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

/**
 对一个请求进行参数排列
 
 @param request 网络请求
 @param param 参数
 @param error 错误
 @return 排列后的参数
 */
- (nullable NSString *)queryStringSerializationRequest:(NSURLRequest *)request param:(NSDictionary *)param error:(NSError **)error;

/**
 自定义构建一个 URLRequest
 如果该方法返回不为空 `requestUrl`, `requestTimeoutInterval`, `requestArgument`, `allowsCellularAccess`, `requestMethod` and `requestSerializerType` 方法都不会调用
 
 @return 自定义 URLRequest
 */
- (nullable NSURLRequest *)buildCustomUrlRequest;


/**
 JSON 校验
 用来校验，JSON 格式是否正确
 return @{
 @"userId": [NSNumber class],
 @"nick": [NSString class],
 @"level": [NSNumber class]
 };
 
 @return 校验 JSON
 */
- (nullable id)jsonValidator;

/**
 响应代码校验
 
 @return StatusCode 是否正确，如果返回 NO ，则进行错误回调
 */
- (BOOL)statusCodeValidator:(NSError **)error;
@end

/**
 网络返回数据根数据结构（常规）
 */
@protocol MLSRetryPreRequestProtocol;
@class MLSNetworkRequest;
@protocol MLSNetworkRootDataProtocol <NSObject>

/**
 错误码 （服务器返回）
 */
@property (nonatomic, assign) NSInteger code;

/**
 HTTP 错误码 （request 内部会对其赋值）
 */
@property (nonatomic, assign) NSInteger responseHeaderStatusCode;

/**
 提示信息
 */
@property (nonatomic, copy) NSString *message;

/**
 日志信息
 */
@property (nonatomic, copy) NSString *remark;

/**
 数据内容
 */
@property (nonatomic, strong) id data;

/**
 是否有效
 如果返回 NO ，则会重新请求该网络，并且不会缓存该网络内容
 @return 是否有效
 */
- (BOOL)isValid;

/**
 HTTP 响应码是否有效

 @return 是否有效
 */
- (BOOL)responseHeaderStatusCodeIsValid;

/**
 错误信息
 */
- (nullable NSError *)validError;

/**
 是否需要在重试请求前，去请求对应 Request 的 preRequest

 @return 是否在重试前请求 preRequest
 */
- (BOOL)needRetryPreRequest;


/**
 是否需要重新请求

 @return 是否重新请求
 */
- (BOOL)needRetry;
/**
 `needRetryPreRequest` 返回 YES 后， 并且对应的 Request `retryPreRequest` 字段为 nil, 则使用该网络请求

 @return 预处理请求
 */
- (nullable id <MLSRetryPreRequestProtocol> )retryPreRequest;


@end


/// 完成回调
typedef void (^MLSRetryPreRequestCompletionBlock)(id <MLSRetryPreRequestProtocol> req, id data, NSError *error);

@protocol MLSRetryPreRequestProtocol <NSObject>

/**
 请求网络

 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithSuccess:(MLSRetryPreRequestCompletionBlock)success
                 failure:(MLSRetryPreRequestCompletionBlock)failure;
@end
#endif /* MLSRequestSubclassHolderProtocol_h */
