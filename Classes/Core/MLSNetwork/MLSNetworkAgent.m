//
//  MLSNetworkAgent.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkAgent.h"
#import "MLSNetworkConfig.h"
#import "MLSNetworkPrivate.h"
#import "MLSNetworkRequest.h"
#import <pthread/pthread.h>
#import <CFNetwork/CFNetwork.h>
#import "MLSNetworkManager.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

#define kMLSNetworkIncompleteDownloadFolderName @"Incomplete"

@implementation MLSNetworkAgent {
    AFHTTPSessionManager *_manager;
    MLSNetworkConfig *_config;
    NSString *_moudleIdentifier;
    AFJSONResponseSerializer *_jsonResponseSerializer;
    AFXMLParserResponseSerializer *_xmlParserResponseSerialzier;
    NSMutableDictionary<NSString *, MLSBaseRequest *> *_requestsRecord;
    NSMutableDictionary<NSString *, NSString *> *_requestsTaskIDRecord;

    dispatch_queue_t _processingQueue;
    pthread_mutex_t _lock;
    NSIndexSet *_allStatusCodes;
}

+ (MLSNetworkAgent *)sharedAgent {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithMoudleIdentifier:nil];
    });
    return sharedInstance;
}

+ (MLSNetworkAgent *)shareAgentWithMoudleIdentifer:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return [self sharedAgent];
    }
    return [[self alloc] initWithMoudleIdentifier:moudleIdentifier];
}

- (instancetype)initWithMoudleIdentifier:(NSString *)moudleIdentifier {
    self = [super init];
    if (self) {
        _config = [MLSNetworkManager configWithMoudleIdentifier:moudleIdentifier];
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_config.sessionConfiguration];
        _requestsRecord = [NSMutableDictionary dictionary];
        _requestsTaskIDRecord = [NSMutableDictionary dictionary];
        _processingQueue = dispatch_queue_create("com.minlison.networkagent.processing", DISPATCH_QUEUE_CONCURRENT);
        _allStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 500)];
        pthread_mutex_init(&_lock, NULL);

        __weak __typeof(self)weakSelf = self;
        [_manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential * _Nullable __autoreleasing * _Nullable credential) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            return [strongSelf _URLSession:session didReceiveChallenge:challenge credential:credential];
        }];
        _manager.securityPolicy = _config.securityPolicy;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // Take over the status code validation
        _manager.responseSerializer.acceptableStatusCodes = _allStatusCodes;
        _manager.completionQueue = _processingQueue;
    }
    return self;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        _jsonResponseSerializer.acceptableStatusCodes = _allStatusCodes;

    }
    return _jsonResponseSerializer;
}

- (AFXMLParserResponseSerializer *)xmlParserResponseSerialzier {
    if (!_xmlParserResponseSerialzier) {
        _xmlParserResponseSerialzier = [AFXMLParserResponseSerializer serializer];
        _xmlParserResponseSerialzier.acceptableStatusCodes = _allStatusCodes;
    }
    return _xmlParserResponseSerialzier;
}

#pragma mark -

- (NSString *)buildRequestUrl:(MLSBaseRequest *)request {
    NSParameterAssert(request != nil);

    NSString *detailUrl = [request requestUrl];
    NSURL *temp = [NSURL URLWithString:detailUrl];
    // If detailUrl is valid URL
    if (temp && temp.host && temp.scheme) {
        return detailUrl;
    }
    
    NSString *baseUrl;
    if ([request useCDN]) {
        if ([request cdnUrl].length > 0) {
            baseUrl = [request cdnUrl];
        } else {
            baseUrl = [_config cdnUrl];
        }
    } else {
        if ([request baseUrl].length > 0) {
            baseUrl = [request baseUrl];
        } else {
            baseUrl = [_config baseUrl];
        }
    }
    // URL slash compability
    NSURL *url = [NSURL URLWithString:baseUrl];

    if (baseUrl.length > 0 && ![baseUrl hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    NSDictionary * params = [request requestQueryArgument];
    if (params != nil && params.count > 0 && request.requestMethod != MLSRequestMethodGET) {
        NSString *queryStr = AFQueryStringFromParameters(params);
        detailUrl = [detailUrl stringByAppendingFormat:@"?%@",queryStr];
    }
    if (url.relativePath.length > 0) {
        detailUrl = [url.relativePath stringByAppendingPathComponent:detailUrl];
    }
    // Filter URL if needed
    NSArray *filters = request.urlFilters;
    if (filters.count <= 0) {
        filters = [_config urlFilters];
    }
    for (id<MLSUrlFilterProtocol> f in filters) {
        if ([f respondsToSelector:@selector(filterUrl:withRequest:)]) {
            detailUrl = [f filterUrl:detailUrl withRequest:request];
        }
    }
    return [NSURL URLWithString:detailUrl relativeToURL:url].absoluteString;
}

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(MLSBaseRequest *)request {
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (request.requestSerializerType == MLSRequestSerializerTypeHTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.requestSerializerType == MLSRequestSerializerTypeJSON) {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }

    requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    requestSerializer.allowsCellularAccess = [request allowsCellularAccess];

    // If api needs server username and password
    NSDictionary<NSString *,NSString *> *authorizationHeaderFieldDict = [request requestAuthorizationHeaderFieldDictionary];
    
    // If api needs to add custom value to HTTPHeaderField
    NSDictionary<NSString *, NSString *> *headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    NSArray *filters = request.urlFilters;
    if (filters.count <= 0) {
        filters = [_config urlFilters];
    }
    for (id<MLSUrlFilterProtocol> f in filters) {
        if ([f respondsToSelector:@selector(filterHeaderFieldValue:withRequest:)]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:(headerFieldValueDictionary?:@{})];
            if ( [f filterHeaderFieldValue:dict withRequest:request] ) {
                headerFieldValueDictionary = dict;
            }
        }
        if ([f respondsToSelector:@selector(filterAuthorizationHeaderFieldValue:withRequest:)]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:(authorizationHeaderFieldDict?:@{})];
            if ( [f filterAuthorizationHeaderFieldValue:dict withRequest:request] ) {
                authorizationHeaderFieldDict = dict;
            }
        }
    }
    
    if (authorizationHeaderFieldDict != nil) {
        [requestSerializer setAuthorizationHeaderFieldWithUsername:[authorizationHeaderFieldDict objectForKey:MLSRequestAuthorizationHeaderUserNameKey]
                                                          password:[authorizationHeaderFieldDict objectForKey:MLSRequestAuthorizationHeaderPasswordKey]];
    }
    
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    return requestSerializer;
}

- (NSURLSessionTask *)sessionTaskForRequest:(MLSBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    MLSRequestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    id param = request.requestFullParams;
    // Get 请求，加入query参数
    if (param != nil && [param isKindOfClass:NSDictionary.class] && method == MLSRequestMethodGET) {
        NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:param];
        [queryParams setValuesForKeysWithDictionary:request.requestQueryArgument?:@{}];
        param = queryParams;
    }
    
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForRequest:request];
    NSString *requestMethodString = @"GET";
    switch (method) {
        case MLSRequestMethodGET:
            if (request.resumableDownloadPath) {
                return [self downloadTaskWithDownloadPath:request.resumableDownloadPath requestSerializer:requestSerializer URLString:url parameters:param progress:request.resumableDownloadProgressBlock error:error];
            } else {
                requestMethodString = @"GET";
                break;
            }
        case MLSRequestMethodPOST: {
            requestMethodString = @"POST";
            break;
        }
        case MLSRequestMethodHEAD:{
            requestMethodString = @"HEAD";
            break;
        }
        case MLSRequestMethodPUT:{
            requestMethodString = @"PUT";
            break;
        }
        case MLSRequestMethodDELETE:{
            requestMethodString = @"DELETE";
            break;
        }
        case MLSRequestMethodPATCH:{
            requestMethodString = @"PATCH";
            break;
        }
    }
    return [self dataTaskWithHTTPMethod:requestMethodString requestSerializer:requestSerializer URLString:url parameters:param uploadProgress:request.uploadProgress downloadProgress:request.downloadProgress constructingBodyWithBlock:request.constructingBodyBlock error:error];
}

- (void)addRequest:(MLSBaseRequest *)request {
    NSParameterAssert(request != nil);

    NSError * __autoreleasing requestSerializationError = nil;

    NSURLRequest *customUrlRequest= [request buildCustomUrlRequest];
    if (customUrlRequest) {
        __block NSURLSessionDataTask *dataTask = nil;
        dataTask = [_manager dataTaskWithRequest:customUrlRequest uploadProgress:request.uploadProgress downloadProgress:request.downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [self handleRequestResult:dataTask responseObject:responseObject error:error];
        }];
        request.requestTask = dataTask;
    } else {
        request.requestTask = [self sessionTaskForRequest:request error:&requestSerializationError];
    }

    if (requestSerializationError) {
        [self requestDidFailWithRequest:request error:requestSerializationError];
        return;
    }

    NSAssert(request.requestTask != nil, @"requestTask should not be nil");

    // Set request task priority
    // !!Available on iOS 8 +
    if ([request.requestTask respondsToSelector:@selector(priority)]) {
        switch (request.requestPriority) {
            case MLSRequestPriorityHigh:
                request.requestTask.priority = NSURLSessionTaskPriorityHigh;
                break;
            case MLSRequestPriorityLow:
                request.requestTask.priority = NSURLSessionTaskPriorityLow;
                break;
            case MLSRequestPriorityDefault:
                /*!!fall through*/
            default:
                request.requestTask.priority = NSURLSessionTaskPriorityDefault;
                break;
        }
    }

    // Retain request
    [_config.logger log:MLSNetworkLogLevelInfo msg:@"Add request: %@-%p", NSStringFromClass([request class]),request];
    [self addRequestToRecord:request];
    [request.requestTask resume];
}

- (void)cancelRequest:(MLSBaseRequest *)request {
    NSParameterAssert(request != nil);

    if (request.resumableDownloadPath) {
        NSURLSessionDownloadTask *requestTask = (NSURLSessionDownloadTask *)request.requestTask;
        [requestTask cancelByProducingResumeData:^(NSData *resumeData) {
            NSURL *localUrl = [self incompleteDownloadTempPathForDownloadPath:request.resumableDownloadPath];
            [resumeData writeToURL:localUrl atomically:YES];
        }];
    } else {
        [request.requestTask cancel];
    }

    [self removeRequestFromRecord:request];
    [request clearCompletionBlock];
}

- (void)cancelAllRequests {
    Lock();
    NSArray <NSString *>*allKeys = [_requestsRecord allKeys];
    Unlock();
    if (allKeys && allKeys.count > 0) {
        NSArray *copiedKeys = [allKeys copy];
        for (NSString *key in copiedKeys) {
            Lock();
            MLSBaseRequest *request = _requestsRecord[key];
            Unlock();
            // We are using non-recursive lock.
            // Do not lock `stop`, otherwise deadlock may occur.
            [request stop];
        }
    }
}

- (BOOL)validateResult:(MLSBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    BOOL result = [request statusCodeValidator:error];
    if (!result) {
        if (error && *error == nil) {
            *error = [NSError errorWithDomain:MLSRequestValidationErrorDomain code:MLSRequestValidationErrorInvalidStatusCode userInfo:@{NSLocalizedDescriptionKey:@"Invalid status code"}];
        }
        return result;
    }
    id json = [request responseJSONObject];
    id validator = [request jsonValidator];
    if (json && validator) {
        result = [MLSNetworkUtils validateJSON:json withValidator:validator];
        if (!result) {
            if (error) {
                *error = [NSError errorWithDomain:MLSRequestValidationErrorDomain code:MLSRequestValidationErrorInvalidJSONFormat userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON format"}];
            }
            return result;
        }
    }
    return YES;
}

- (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    Lock();
    NSString *key = _requestsTaskIDRecord[@(task.taskIdentifier).stringValue];
    MLSBaseRequest *request = _requestsRecord[key];
    Unlock();

    // When the request is cancelled and removed from records, the underlying
    // AFNetworking failure callback will still kicks in, resulting in a nil `request`.
    //
    // Here we choose to completely ignore cancelled tasks. Neither success or failure
    // callback will be called.
    if (!request) {
        [_config.logger log:MLSNetworkLogLevelInfo msg:@" Request: is null"];
        return;
    }
    [_config.logger log:MLSNetworkLogLevelInfo msg:@"Finished Request: %@-%p", NSStringFromClass([request class]),request];

    NSError * __autoreleasing serializationError = nil;
    NSError * __autoreleasing validationError = nil;

    NSError *requestError = nil;
    BOOL succeed = NO;
    
    id<MLSEncryptProtocol>enctyptManager = [MLSNetworkManager configWithMoudleIdentifier:request.moudleIdentifier].enctyptManager;
    if ([request isKindOfClass:[MLSNetworkRequest class]]) {
        MLSNetworkRequest *tmp = (MLSNetworkRequest *)request;
        enctyptManager = [tmp enctyptManager];
    }
    
    request.responseObject = responseObject;
    if ([request.responseObject isKindOfClass:[NSData class]]) {
        if (enctyptManager) {
            responseObject = [enctyptManager encryptSubmitData:(NSData *)responseObject];            
        }
        
        request.responseData = responseObject;
        request.responseString = [[NSString alloc] initWithData:responseObject encoding:[MLSNetworkUtils stringEncodingWithRequest:request]];

        switch (request.responseSerializerType) {
            case MLSResponseSerializerTypeHTTP:
                // Default serializer. Do nothing.
                break;
            case MLSResponseSerializerTypeJSON:
                self.jsonResponseSerializer.acceptableContentTypes = request.acceptableContentTypes;
                request.responseObject = [self.jsonResponseSerializer responseObjectForResponse:task.response data:request.responseData error:&serializationError];
                request.responseJSONObject = request.responseObject;
                break;
            case MLSResponseSerializerTypeXMLParser:
                self.xmlParserResponseSerialzier.acceptableContentTypes = request.acceptableContentTypes;
                request.responseObject = [self.xmlParserResponseSerialzier responseObjectForResponse:task.response data:request.responseData error:&serializationError];
                break;
        }
    }
    if (error) {
        succeed = NO;
        requestError = error;
    } else if (serializationError) {
        succeed = NO;
        requestError = serializationError;
    } else {
        succeed = [self validateResult:request error:&validationError];
        requestError = validationError;
    }

    if (succeed) {
        [self requestDidSucceedWithRequest:request];
    } else {
        [self requestDidFailWithRequest:request error:requestError];
    }

    dispatch_async(request.callbackQueue, ^{
        if ([request shouldRemoveFromAgent]) {
            [self removeRequestFromRecord:request];
            [request clearCompletionBlock];
        }
    });
}

- (void)requestDidSucceedWithRequest:(MLSBaseRequest *)request {
    @autoreleasepool {
        dispatch_async(request.callbackQueue, ^{
            if ([request requestCompletePreprocessor] )
            {
                [request toggleAccessoriesWillStopcallback];
                [request requestCompleteFilter];
                
                if (request.delegate != nil) {
                    [request.delegate requestFinished:request];
                }
                if (request.successCompletionBlock) {
                    request.successCompletionBlock(request);
                }
                [request toggleAccessoriesDidStopcallback];
                
            }
        });
    }
    
}

- (void)requestDidFailWithRequest:(MLSBaseRequest *)request error:(NSError *)error {
    request.error = error;

     [_config.logger log:MLSNetworkLogLevelError msg:@"Request %@ failed, status code = %ld, error = %@", NSStringFromClass([request class]), (long)request.responseHeaderStatusCode, error.localizedDescription];
    // Save incomplete download data.
    NSData *incompleteDownloadData = error.userInfo[NSURLSessionDownloadTaskResumeData];
    if (incompleteDownloadData) {
        [incompleteDownloadData writeToURL:[self incompleteDownloadTempPathForDownloadPath:request.resumableDownloadPath] atomically:YES];
    }

    // Load response from file and clean up if download task failed.
    if ([request.responseObject isKindOfClass:[NSURL class]]) {
        NSURL *url = request.responseObject;
        if (url.isFileURL && [[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
            request.responseData = [NSData dataWithContentsOfURL:url];
            request.responseString = [[NSString alloc] initWithData:request.responseData encoding:[MLSNetworkUtils stringEncodingWithRequest:request]];

            [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
        }
        request.responseObject = nil;
    }

    @autoreleasepool {
        dispatch_async(request.callbackQueue, ^{
            if ([request requestFailedPreprocessor] ) {
                [request toggleAccessoriesWillStopcallback];
                [request requestFailedFilter];
                
                if (request.delegate != nil) {
                    [request.delegate requestFailed:request];
                }
                if (request.failureCompletionBlock) {
                    request.failureCompletionBlock(request);
                }
                [request toggleAccessoriesDidStopcallback];
            }
        });
    }
}

- (void)addRequestToRecord:(MLSBaseRequest *)request {
    Lock();
    if (request.uuid.length > 0) {
        _requestsRecord[request.uuid] = request;
        _requestsTaskIDRecord[@(request.requestTask.taskIdentifier).stringValue] = request.uuid;
    } else {
        _requestsRecord[@(request.requestTask.taskIdentifier).stringValue] = request;
        _requestsTaskIDRecord[@(request.requestTask.taskIdentifier).stringValue] = @(request.requestTask.taskIdentifier).stringValue;
    }
    Unlock();
}

- (void)removeRequestFromRecord:(MLSBaseRequest *)request {
    Lock();
    if (request.uuid.length > 0) {
        [_requestsRecord removeObjectForKey:request.uuid];
        NSMutableArray *keys = [NSMutableArray arrayWithCapacity:_requestsTaskIDRecord.count];
        [_requestsTaskIDRecord enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:request.uuid]) {
                [keys addObject:key];
            }
        }];
        [_requestsTaskIDRecord removeObjectsForKeys:keys];
    } else {
        [_requestsRecord removeObjectForKey:@(request.requestTask.taskIdentifier).stringValue];
        [_requestsTaskIDRecord removeObjectForKey:@(request.requestTask.taskIdentifier).stringValue];
    }
    [_config.logger log:MLSNetworkLogLevelInfo msg:@"Request queue size = %zd", [_requestsRecord count]];
    Unlock();
}

#pragma mark -
- (NSURLSessionAuthChallengeDisposition)_URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 credential:(NSURLCredential **)credential
{
    // 先判断全局配置
    __block NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    if (MLSNetworkConfig.sharedConfig.securityPolicy) {
        disposition = [self judgeUseSecurity:MLSNetworkConfig.sharedConfig.securityPolicy Challenge:challenge credential:credential];
        if (disposition == NSURLSessionAuthChallengeUseCredential) {
            return disposition;
        }
    }
    // 当前正在进行中的 request 校验证书
    [_requestsRecord enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, MLSBaseRequest * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.originalRequest.URL.host isEqualToString:challenge.protectionSpace.host]) {
            disposition = [self judgeUseSecurity:obj.securityPolicy Challenge:challenge credential:credential];
            if (disposition == NSURLSessionAuthChallengeUseCredential) {
                *stop = YES;
            }
        }
    }];
    return disposition;
}

- (NSURLSessionAuthChallengeDisposition)judgeUseSecurity:(AFSecurityPolicy *)securityPolicy Challenge:(NSURLAuthenticationChallenge *)challenge credential:(NSURLCredential **)credential{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
            disposition = NSURLSessionAuthChallengeUseCredential;
            if (credential != NULL) {
                *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            }
        } else {
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    return disposition;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                           error:(NSError * _Nullable __autoreleasing *)error {
    return [self dataTaskWithHTTPMethod:method
                      requestSerializer:requestSerializer
                              URLString:URLString
                             parameters:parameters
                         uploadProgress:nil
                       downloadProgress:nil
              constructingBodyWithBlock:nil error:error];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                           error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableURLRequest *request = nil;
    
    if (block) {
        request = [requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:parameters constructingBodyWithBlock:block error:error];
    } else {
        request = [requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:error];
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [_manager dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable _error) {
        [self handleRequestResult:dataTask responseObject:responseObject error:_error];
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                           error:(NSError * _Nullable __autoreleasing *)error {
    return [self dataTaskWithHTTPMethod:method
                      requestSerializer:requestSerializer
                              URLString:URLString
                             parameters:parameters
                         uploadProgress:nil
                       downloadProgress:nil
              constructingBodyWithBlock:block error:error];
}

- (NSURLSessionDownloadTask *)downloadTaskWithDownloadPath:(NSString *)downloadPath
                                         requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                                 URLString:(NSString *)URLString
                                                parameters:(id)parameters
                                                  progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                                     error:(NSError * _Nullable __autoreleasing *)error {
    // add parameters to URL;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:error];

    NSString *downloadTargetPath;
    BOOL isDirectory;
    if(![[NSFileManager defaultManager] fileExistsAtPath:downloadPath isDirectory:&isDirectory]) {
        isDirectory = NO;
    }
    // If targetPath is a directory, use the file name we got from the urlRequest.
    // Make sure downloadTargetPath is always a file, not directory.
    if (isDirectory) {
        NSString *fileName = [urlRequest.URL lastPathComponent];
        downloadTargetPath = [NSString pathWithComponents:@[downloadPath, fileName]];
    } else {
        downloadTargetPath = downloadPath;
    }

    // AFN use `moveItemAtURL` to move downloaded file to target path,
    // this method aborts the move attempt if a file already exist at the path.
    // So we remove the exist file before we start the download task.
    // https://github.com/AFNetworking/AFNetworking/issues/3775
    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadTargetPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:downloadTargetPath error:nil];
    }

    BOOL resumeDataFileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self incompleteDownloadTempPathForDownloadPath:downloadPath].path];
    NSData *data = [NSData dataWithContentsOfURL:[self incompleteDownloadTempPathForDownloadPath:downloadPath]];
    BOOL resumeDataIsValid = [MLSNetworkUtils validateResumeData:data];

    BOOL canBeResumed = resumeDataFileExists && resumeDataIsValid;
    BOOL resumeSucceeded = NO;
    __block NSURLSessionDownloadTask *downloadTask = nil;
    // Try to resume with resumeData.
    // Even though we try to validate the resumeData, this may still fail and raise excecption.
    if (canBeResumed) {
        @try {
            downloadTask = [_manager downloadTaskWithResumeData:data progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return [NSURL fileURLWithPath:downloadTargetPath isDirectory:NO];
            } completionHandler:
                            ^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                [self handleRequestResult:downloadTask responseObject:filePath error:error];
                            }];
            resumeSucceeded = YES;
        } @catch (NSException *exception) {
            [_config.logger log:MLSNetworkLogLevelError msg:@"Resume download failed, reason = %@", exception.reason];
            resumeSucceeded = NO;
        }
    }
    if (!resumeSucceeded) {
        downloadTask = [_manager downloadTaskWithRequest:urlRequest progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:downloadTargetPath isDirectory:NO];
        } completionHandler:
                        ^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                            [self handleRequestResult:downloadTask responseObject:filePath error:error];
                        }];
    }
    return downloadTask;
}

#pragma mark - Resumable Download

- (NSString *)incompleteDownloadTempCacheFolder {
    NSFileManager *fileManager = [NSFileManager new];
    static NSString *cacheFolder;

    if (!cacheFolder) {
        NSString *cacheDir = NSTemporaryDirectory();
        cacheFolder = [cacheDir stringByAppendingPathComponent:kMLSNetworkIncompleteDownloadFolderName];
    }

    NSError *error = nil;
    if(![fileManager createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
        [_config.logger log:MLSNetworkLogLevelError msg:@"Failed to create cache directory at %@", cacheFolder];
        cacheFolder = nil;
    }
    return cacheFolder;
}

- (NSURL *)incompleteDownloadTempPathForDownloadPath:(NSString *)downloadPath {
    NSString *tempPath = nil;
    NSString *md5URLString = [MLSNetworkUtils md5StringFromString:downloadPath];
    tempPath = [[self incompleteDownloadTempCacheFolder] stringByAppendingPathComponent:md5URLString];
    return [NSURL fileURLWithPath:tempPath];
}

#pragma mark - Testing

- (AFHTTPSessionManager *)manager {
    return _manager;
}

- (void)resetURLSessionManager {
    _manager = [AFHTTPSessionManager manager];
}

- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)configuration {
    _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
}

@end
