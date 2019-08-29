//
//  MLSNetworkRequest.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkRequest.h"
#import "MLSNetworkPrivate.h"
#import "MLSNetworkManager.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif
const NSTimeInterval MLSRequestRetryDelay = -1;
NSString *const MLSRequestRetryErrorDomain = @"com.minlison.retry.error";
NSString *const MLSRequestRetryOriginErrorKey = @"MLSRequestRetryOriginErrorKey";
NSString *const MLSRequestRetryRetryErrorKey = @"MLSRequestRetryRetryErrorKey";
@interface MLSNetworkRequest ()
@property (nonatomic, copy, readwrite) NSString *tipString;
@property (nonatomic, strong) NSMutableDictionary *insertParams;
@property (nonatomic, strong) id requestParams;
@property (nonatomic, strong, readwrite) id <MLSNetworkRootDataProtocol> serverRootData;
@property (nonatomic, assign, readwrite) NSUInteger retryCount;
@property (nonatomic, assign) NSUInteger innerRetryCount;
@property (nonatomic, strong, readwrite) id responseModelData;
@property (nonatomic, assign, getter=isRetrying) BOOL retrying;
@property (nonatomic, copy) MLSRequestCompletionBlock retryCompletionBlock;
@property (nonatomic, copy) MLSRequestCompletionBlock retryFailedBlock;
@property (nonatomic, copy) MLSNetworkRequestCompletionBlock modelSuccessBlock;
@property (nonatomic, copy) MLSNetworkRequestCompletionBlock modelFailedBlock;
@property (nonatomic, assign) NSTimeInterval startTime;
@end
@implementation MLSNetworkRequest
@synthesize requestHeaderFieldValueDictionary = _requestHeaderFieldValueDictionary;
+ (instancetype)requestWithParam:(id)param {
    MLSNetworkRequest *req = [[self alloc] init];
    if (param && [param isKindOfClass:[NSDictionary class]]) {
        [req.insertParams setDictionary:param];
    } else {
        req.requestParams = param;
    }
    return req;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _InitRequestValues];
    }
    return self;
}

- (void)_InitRequestValues {
    self.insertParams = [[NSMutableDictionary alloc] init];
    self.retryDelay = MLSRequestRetryDelay;
    self.maxRetryCount = 1;
    self.cacheable = NO;
    self.ignoreCache = YES;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)start
{
    [super start];
    self.startTime = [[NSDate date] timeIntervalSince1970];
}

- (void)startWithModelCompletionBlockWithSuccess:(MLSNetworkRequestCompletionBlock)success failure:(MLSNetworkRequestCompletionBlock)failure
{
    [self startWithCache:YES modelCompletionBlockWithSuccess:success failure:failure];
}

- (void)startWithCache:(BOOL)cacheable modelCompletionBlockWithSuccess:(MLSNetworkRequestCompletionBlock)success failure:(MLSNetworkRequestCompletionBlock)failure
{
    self.modelSuccessBlock = success;
    self.modelFailedBlock = failure;
    __weak __typeof(self)weakSelf = self;
    [self startWithCompletionBlockWithSuccess:^(__kindof MLSBaseRequest *request) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.modelSuccessBlock) {
            strongSelf.modelSuccessBlock(request, strongSelf.responseModelData);
        }
    } failure:^(__kindof MLSBaseRequest *request) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.modelFailedBlock) {
            strongSelf.modelFailedBlock(request, nil);
        }
    }];
}

// MARK: - Retry request protocol
- (void)startWithSuccess:(MLSRetryPreRequestCompletionBlock)success failure:(MLSRetryPreRequestCompletionBlock)failure {
    self.retryCompletionBlock = self.successCompletionBlock;
    self.retryFailedBlock = self.failureCompletionBlock;
    __weak __typeof(self)weakSelf = self;
    [self startWithCompletionBlockWithSuccess:^(__kindof MLSBaseRequest *request) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (success) {
            success(request,request.responseObject, request.error);
        }
        if (strongSelf.retryCompletionBlock) {
            strongSelf.retryCompletionBlock(request);
        }
    } failure:^(__kindof MLSBaseRequest *request) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (failure) {
            failure(request,request.responseObject, request.error);
        }
        if (strongSelf.retryFailedBlock) {
            strongSelf.retryFailedBlock(request);
        }
    }];
}

/// MARK: - Retry 机制
- (BOOL)_TryToRetryRequest
{
    @synchronized(self) {
        self.retrying = NO;
        self.innerRetryCount = self.retryCount;
        if (self.error != nil && ++self.retryCount <= self.maxRetryCount) {
            if ( [AFNetworkReachabilityManager sharedManager].isReachable) {
                /// 网络错误
                if ([self.error.domain isEqualToString:NSURLErrorDomain]) {
                    self.retrying = YES;
                    self.innerRetryCount = self.retryCount;
                    [self _StartWithRetry];
                }
                else if (self.error.code == MLSRequestValidationErrorInvalidStatusCode) {
                    self.retrying = YES;
                    self.innerRetryCount = self.retryCount;
                    [self _StartWithRetry];
                    
                } else if (([self.serverRootData respondsToSelector:@selector(needRetry)] && [self.serverRootData needRetry])
                           || self.needRetry) {
                    self.retrying = YES;
                    self.innerRetryCount = self.retryCount;
                    /// 服务器返回状态码过滤
                    if (([self.serverRootData needRetryPreRequest]
                         || self.needRetryPreRequest
                         || [self.retryPreRequestCodes containsObject:@(self.error.code)])
                        && self.retryPreRequest) {
                        __weak __typeof(self)weakSelf = self;
                        [self.retryPreRequest startWithSuccess:^(id<MLSRetryPreRequestProtocol> req, id data, NSError *error) {
                            __strong __typeof(weakSelf)strongSelf = weakSelf;
                            [strongSelf _StartWithRetry];
                        } failure:^(id<MLSRetryPreRequestProtocol> req, id data, NSError *error) {
                            __strong __typeof(weakSelf)strongSelf = weakSelf;
                            NSError *innerError = [NSError errorWithDomain:MLSRequestRetryErrorDomain
                                                                 code:0
                                                             userInfo:@{
                                                                        MLSRequestRetryOriginErrorKey : strongSelf.error?:[NSNull null],
                                                                        MLSRequestRetryRetryErrorKey : error?:[NSNull null]
                                                                        }];
                            [[MLSNetworkManager agentWithMoudleIdentifier:self.moudleIdentifier] requestDidFailWithRequest:strongSelf error:innerError];
                        }];
                    } else {
                        [self _StartWithRetry];
                    }
                }
            } else {
                self.innerRetryCount = self.retryCount;
            }
        } else {
            [self clearRetryVariables];
        }
        return self.isRetrying;
    }
}

- (void)_StartWithRetry
{
    if (self.retryDelay != MLSRequestRetryDelay) {
        [self performSelector:@selector(startWithoutCache) withObject:nil afterDelay:self.retryDelay];
    } else {
        [self startWithoutCache];
    }
}

- (BOOL)shouldRemoveFromAgent
{
    return !self.isRetrying;
}

/// MARK: - Tip
- (NSString *)tipString {
    @synchronized(self) {
        if (!_tipString) {
            _tipString = self.serverRootData.message;
            if (!_tipString) {
                NSDictionary *values = self.responseJSONObject;
                if ([self.responseJSONObject isKindOfClass:[NSArray class]]) {
                    NSArray *tmp = (NSArray *)self.responseJSONObject;
                    values = tmp.firstObject;
                }
                if ([values isKindOfClass:[NSDictionary class]]) {
                    _tipString = [values objectForKey:@"message"]?:[values objectForKey:@"Message"];
                }
            }
            if (!_tipString) {
                _tipString = self.error.localizedDescription.copy;
            }
        }
        return _tipString;
    }
}

/// MARK: - 拦截父类方法
- (BOOL)requestCompletePreprocessor {
    return [super requestCompletePreprocessor] && ![self _TryToRetryRequest];
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
}

- (BOOL)requestFailedPreprocessor {
    return [super requestFailedPreprocessor] && ![self _TryToRetryRequest];
}

- (void)requestFailedFilter {
    [super requestFailedFilter];
}

- (void)clearCacheVariables {
    @synchronized(self) {
        if ([_retryPreRequest isKindOfClass:MLSNetworkRequest.class]) {
            [(MLSNetworkRequest *)_retryPreRequest clearCacheVariables];
        }
        _serverRootData = nil;
        _responseModelData = nil;
        [super clearCacheVariables];
    }
}

- (id <MLSRetryPreRequestProtocol>)retryPreRequest {
    @synchronized(self) {
        if (!_retryPreRequest) {
            if ([self.serverRootData respondsToSelector:@selector(retryPreRequest)]) {
                _retryPreRequest = self.serverRootData.retryPreRequest;
            }
            /// 防止死循环，因为 retryPreRequest 本身具有重试机制，其本身的 preRequest 不能是其本身
            if (_retryPreRequest == self || [_retryPreRequest isMemberOfClass:self.class]) {
                _retryPreRequest = nil;
            }
        }
        return (id <MLSRetryPreRequestProtocol>)_retryPreRequest;
    }
}

- (void)clearCompletionBlock {
    @synchronized(self) {
        if (!self.isRetrying) {
            if ([_retryPreRequest isKindOfClass:MLSNetworkRequest.class]) {
                [(MLSNetworkRequest *)_retryPreRequest clearCompletionBlock];
            }
            self.modelFailedBlock = nil;
            self.modelSuccessBlock = nil;
            [self clearRetryVariables];
            [super clearCompletionBlock];
        }
    }
}

- (void)clearRetryVariables {
    @synchronized(self) {
        _retryCount = 0;
        _retrying = NO;
        _retryCompletionBlock = nil;
        _retryFailedBlock = nil;
        if ([_retryPreRequest isKindOfClass:MLSNetworkRequest.class]) {
            [(MLSNetworkRequest *)_retryPreRequest clearRetryVariables];
        }
        _retryPreRequest = nil;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startWithoutCache) object:nil];
    }
}

- (NSMutableDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    if (!_requestHeaderFieldValueDictionary) {
        _requestHeaderFieldValueDictionary = @{
                                               @"Content-Type" : @"application/json"
                                               }.mutableCopy;
    }
    return _requestHeaderFieldValueDictionary;
}

- (BOOL)statusCodeValidator:(NSError *__autoreleasing *)error {
    @synchronized(self) {
        if (self.serverRootData == nil) {
            return [super statusCodeValidator:error];
        }
        NSInteger statusCode = [self responseHeaderStatusCode];
        self.serverRootData.responseHeaderStatusCode = statusCode;
        
        BOOL res = self.serverRootData.isValid && self.serverRootData.responseHeaderStatusCodeIsValid;
        if ( !self.serverRootData.message ) {
            if ( !res ) {
                NSString *obj = [[self responseObject] objectForKey:@"message"];
                if (obj) {
                    self.serverRootData.message = obj;
                } else {
                    self.serverRootData.message = [self responseString];
                }
            } else {
                self.serverRootData.message = @"成功";
            }
        }
        if (!res && error) {
            *error = [NSError errorWithDomain:MLSRequestValidationErrorDomain code:self.serverRootData.code userInfo:@{
                                                                                                                      NSLocalizedDescriptionKey : self.serverRootData.message?:@"未知错误"
                                                                                                                      }];
        }
        return res;
    }
}


/// MARK: - Getter
- (NSError *)error {
    @synchronized(self) {
        NSError *tmpError = [super error];
        if (tmpError == nil && !self.serverRootData.isValid && self.serverRootData.validError) {
            return self.serverRootData.validError;
        }
        
        NSDictionary *userInfo = tmpError.userInfo;
        
        /// 重试错误
        if ([tmpError.domain isEqualToString:MLSRequestRetryErrorDomain]) {
            tmpError = [tmpError.userInfo objectForKey:MLSRequestRetryOriginErrorKey];
            return tmpError;
        }
        /// 网络请求校验错误
        if ([tmpError.domain isEqualToString:MLSRequestValidationErrorDomain]) {
            if (tmpError.code == MLSRequestValidationErrorInvalidStatusCode) {
                userInfo = @{ NSLocalizedDescriptionKey : @"服务错误" };
            }
            if (tmpError.code == MLSRequestValidationErrorInvalidJSONFormat) {
                userInfo = @{ NSLocalizedDescriptionKey : @"数据格式错误" };
            }
            tmpError = [NSError errorWithDomain:tmpError.domain code:tmpError.code userInfo:userInfo];
            return tmpError;
        }
        
        /// 响应解析错误
        if ([tmpError.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            userInfo = @{ NSLocalizedDescriptionKey : @"数据解析失败" };
            tmpError = [NSError errorWithDomain:tmpError.domain code:tmpError.code userInfo:userInfo];
            return tmpError;
        }
        
        if ([tmpError.domain isEqualToString:NSURLErrorDomain]) {
            userInfo = @{ NSLocalizedDescriptionKey : [self errorDesFromErrorCode:tmpError.code] };
            tmpError = [NSError errorWithDomain:tmpError.domain code:tmpError.code userInfo:userInfo];
            return tmpError;
        }
        
        if ([tmpError.domain isEqualToString:NSCocoaErrorDomain]) {
            userInfo = @{ NSLocalizedDescriptionKey : @"数据解析失败" };
            tmpError = [NSError errorWithDomain:tmpError.domain code:tmpError.code userInfo:userInfo];
            return tmpError;
        }
        return tmpError;
    }
}
- (id<MLSNetworkModelProtocol>)modelManager {
    @synchronized(self) {
        if( !_modelManager) {
            _modelManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].modelManager;
        }
        return _modelManager;
    }
}
- (id<MLSNetworkCacheProtocol>)cacheManager {
    @synchronized(self) {
        if (!_cacheManager) {
            _cacheManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cacheManager;
        }
        return _cacheManager;
    }
}
- (id<MLSEncryptProtocol>)enctyptManager {
    @synchronized(self) {
        if (!_enctyptManager) {
            _enctyptManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].enctyptManager;
        }
        return _enctyptManager;
    }
}
- (Class<MLSNetworkRootDataProtocol>)serverRootDataClass {
    @synchronized(self) {
        if (!_serverRootDataClass) {
            _serverRootDataClass = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].serverRootDataClass;
        }
        return _serverRootDataClass;
    }
}
- (id<MLSNetworkLogProtocol>)logger {
    @synchronized(self) {
        if (!_logger) {
            _logger = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].logger;
        }
        return _logger;
    }
}

- (id<MLSNetworkRootDataProtocol>)serverRootData {
    @synchronized(self) {
        if (self.serverRootDataClass == nil) {
            return nil;
        }
        if (!_serverRootData) {
            _serverRootData = [self.modelManager modelWithClass:self.serverRootDataClass isArray:NO withJSON:self.responseObject];
        }
        return _serverRootData;
    }
}

- (id)responseModelData {
    @synchronized(self) {
        if (!_responseModelData) {
            id data = nil;
            if (self.serverRootData == nil) {
                data = self.responseJSONObject;
            } else {
                data = [self.serverRootData data];
            }
            if (self.modelKeyPath && [data isKindOfClass:NSDictionary.class]) {
                data = [data objectForKey:self.modelKeyPath];
            }
            if ([data isKindOfClass:[NSDictionary class]]) {
                _responseModelData = [self.modelManager modelWithClass:self.modelClass isArray:NO withJSON:data];
            } else if ([data isKindOfClass:[NSArray class]]) {
                _responseModelData = [self.modelManager modelWithClass:self.modelClass isArray:YES withJSON:data];
            }
        }
        return _responseModelData;
    }
}

- (id)requestFullParams {
    @synchronized(self) {
        id requestArgument = [self requestArgument];
        
        if ( !requestArgument && !self.requestParams ) {
            return self.insertParams;
        }
        
        if ( requestArgument && ![requestArgument isKindOfClass:[NSDictionary class]] ) {
            return requestArgument;
        }
        
        if ( self.requestParams && ![self.requestParams isKindOfClass:[NSDictionary class]] ) {
            return self.requestParams;
        }
        
        [self.insertParams setValuesForKeysWithDictionary:self.requestParams?:@{}];
        [self.insertParams setValuesForKeysWithDictionary:requestArgument?:@{}];
        return self.insertParams;
    }
}

- (void)paramInsert:(id)obj forKey:(NSString *)key {
    if (obj && key) {
        [self.insertParams setObject:obj forKey:key];
    }
}
- (void)paramInsert:(NSDictionary *)insertParam {
    if (insertParam) {
        [self.insertParams setValuesForKeysWithDictionary:insertParam];
    }
}
- (void)paramDelForKey:(NSString *)key {
    if (key) {
        [self.insertParams removeObjectForKey:key];
    }
}
- (void)paramDel:(NSDictionary *)delParam {
    [self paramDelForKeys:delParam.allKeys];
}
- (void)paramDelForKeys:(NSArray *)delParamKeys {
    
    if (delParamKeys) {
        [self.insertParams removeObjectsForKeys:delParamKeys];
    }
}
- (NSString *)description
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - self.startTime;
    if (time > 10000) {
        return @"该网络请求并未使用";
    }
    return [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { method: %@ } { header: %@} { arguments: %@ } { result: %@ } { resultFormCache: %@ } { uuid: %@} { time: %f }  { retryCount: %d } { error: %@ }", NSStringFromClass([self class]), self, self.originalRequest.URL, self.originalRequest.HTTPMethod, self.originalRequest.allHTTPHeaderFields, self.requestFullParams, [self.responseObject class], self.isDataFromCache ? @"YES" : @"NO", self.uuid, time, (int)self.innerRetryCount, self.error];
}
- (void)dealloc
{
    if (self.logger) {
        [self.logger log:MLSNetworkLogLevelInfo msg:@"----dealloc----%@",self];
    }
}

- (NSString *)errorDesFromErrorCode:(NSInteger)errorCode {
    switch (errorCode) {
        case NSURLErrorUnknown: { return @"未知错误"; }
        case NSURLErrorInternationalRoamingOff: { return @"未知错误"; }
        case NSURLErrorCallIsActive: { return @"未知错误"; }
        case NSURLErrorBackgroundSessionRequiresSharedContainer: { return @"未知错误"; }
        case NSURLErrorBackgroundSessionInUseByAnotherProcess: { return @"未知错误"; }
        case NSURLErrorBackgroundSessionWasDisconnected: { return @"未知错误"; }
        case NSURLErrorCancelled: { return @"请求取消"; }
        case NSURLErrorBadURL: { return @"网址错误"; }
        case NSURLErrorTimedOut: { return @"请求超时"; }
        case NSURLErrorUnsupportedURL: { return @"不支持该请求"; }
        case NSURLErrorCannotFindHost: { return @"找不到服务器"; }
        case NSURLErrorCannotConnectToHost: { return @"链接不到服务器"; }
        case NSURLErrorNetworkConnectionLost: { return @"网络链接丢失"; }
        case NSURLErrorDNSLookupFailed: { return @"DNS解析失败"; }
        case NSURLErrorHTTPTooManyRedirects: { return @"重定向次数过多"; }
        case NSURLErrorResourceUnavailable: { return @"无效资源"; }
        case NSURLErrorNotConnectedToInternet: { return @"网络断开"; }
        case NSURLErrorRedirectToNonExistentLocation: { return @"重定向地址不存在"; }
        case NSURLErrorBadServerResponse: { return @"服务器未响应"; }
        case NSURLErrorUserCancelledAuthentication: { return @"用户授权失败"; }
        case NSURLErrorUserAuthenticationRequired: { return @"没有权限"; }
        case NSURLErrorZeroByteResource: { return @"资源错误"; }
        case NSURLErrorCannotDecodeRawData: { return @"解码失败"; }
        case NSURLErrorCannotDecodeContentData: { return @"解码失败"; }
        case NSURLErrorCannotParseResponse: { return @"解码失败"; }
        case -1022: { return @"不安全网络"; } // NSURLErrorAppTransportSecurityRequiresSecureConnection
        case NSURLErrorFileDoesNotExist: { return @"资源不存在"; }
        case NSURLErrorFileIsDirectory: { return @"资源不存在"; }
        case NSURLErrorNoPermissionsToReadFile: { return @"没有权限"; }
        case NSURLErrorDataLengthExceedsMaximum: { return @"资源错误"; }
        case -1104: { return @"资源错误"; } // NSURLErrorFileOutsideSafeArea
        case NSURLErrorSecureConnectionFailed: { return @"证书过期"; }
        case NSURLErrorServerCertificateHasBadDate: { return @"证书过期"; }
        case NSURLErrorServerCertificateUntrusted: { return @"证书过期"; }
        case NSURLErrorServerCertificateHasUnknownRoot: { return @"未知证书机构"; }
        case NSURLErrorServerCertificateNotYetValid: { return @"无效证书"; }
        case NSURLErrorClientCertificateRejected: { return @"无效证书"; }
        case NSURLErrorClientCertificateRequired: { return @"无效证书"; }
        case NSURLErrorCannotLoadFromNetwork: { return @"网络错误"; }
        case NSURLErrorCannotCreateFile: { return @"无法创建文件"; }
        case NSURLErrorCannotOpenFile: { return @"文件无法打开"; }
        case NSURLErrorCannotCloseFile: { return @"无法关闭文件"; }
        case NSURLErrorCannotWriteToFile: { return @"无法写入文件"; }
        case NSURLErrorCannotRemoveFile: { return @"无法删除文件"; }
        case NSURLErrorDownloadDecodingFailedMidStream: { return @"解码失败"; }
        case NSURLErrorDownloadDecodingFailedToComplete: { return @"解码未完成"; }
        case NSURLErrorDataNotAllowed: { return @"不支持编码"; }
        case NSURLErrorRequestBodyStreamExhausted: { return @"文件过大"; }
    }
    return @"网络错误";
}
@end
