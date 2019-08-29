//
//  MLSBaseRequest.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSBaseRequest.h"
#import "MLSNetworkAgent.h"
#import "MLSNetworkPrivate.h"
#import "MLSNetworkQueuePool.h"
#import "MLSNetworkManager.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@interface MLSBaseRequest ()
@property (nonatomic, strong, readwrite) NSMutableArray < id <MLSUrlFilterProtocol> > *urlFilters;
@property (nonatomic, strong, readwrite) NSURLSessionTask *requestTask;
@property (nonatomic, strong, readwrite) NSData *responseData;
@property (nonatomic, strong, readwrite) id responseJSONObject;
@property (nonatomic, strong, readwrite) id responseObject;
@property (nonatomic, strong, readwrite) NSString *responseString;
@property (nonatomic, strong, readwrite) NSError *error;
@property (nonatomic, copy, readwrite) NSString *uuid;
@property (nonatomic, copy, readwrite) NSString *paramUniqueString;
@property (nonatomic, assign, readwrite) dispatch_queue_t callbackQueue;
@end

@implementation MLSBaseRequest
- (instancetype)init {
    self = [super init];
    if (self) {
        [self _InitDefaultValues];
    }
    return self;
}
- (void)_InitDefaultValues {
    _callbackQueue = dispatch_get_main_queue();
    _useCDN = NO;
    _allowsCellularAccess = YES;
    _requestTimeoutInterval = 6;
    _requestMethod = MLSRequestMethodGET;
    _requestSerializerType = MLSRequestSerializerTypeJSON;
    _responseSerializerType = MLSResponseSerializerTypeJSON;
}
- (void)setcallbackOnAsyncQueue:(BOOL)callbackOnAsyncQueue {
    if (callbackOnAsyncQueue) {
        self.callbackQueue = MLSNetworkQueueGetForQOS(NSQualityOfServiceDefault);
    }
}
#pragma mark - Request and Response Information

- (NSHTTPURLResponse *)response {
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSInteger)responseHeaderStatusCode {
    return self.response.statusCode;
}

- (NSDictionary *)responseHeaders {
    return self.response.allHeaderFields;
}

- (NSURLRequest *)currentRequest {
    return self.requestTask.currentRequest;
}

- (NSURLRequest *)originalRequest {
    return self.requestTask.originalRequest;
}

- (BOOL)isCancelled {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateCanceling;
}

- (BOOL)isExecuting {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateRunning;
}

- (NSString *)moudleIdentifier {
    return nil;
}

- (NSArray<id<MLSUrlFilterProtocol>> *)urlFilters {
    return nil;
}

- (NSString *)uuid {
    if (!_uuid) {
        NSDate *date = [NSDate date];
        NSString *baseUrl = nil;
        if ([self useCDN]) {
            baseUrl = [self cdnUrl] ?:[MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cdnUrl;
        } else {
            baseUrl = [self baseUrl] ?:[MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].baseUrl;
        }
        NSString *Url = [NSString stringWithFormat:@"%@%@",baseUrl,self.requestUrl];
        NSString *paramString = nil;
        id requestArgument = self.requestFullParams;
        if ([requestArgument isKindOfClass:[NSString class]]) {
            paramString = requestArgument;
        } else if ([requestArgument isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictParam = (NSDictionary *)requestArgument;
            paramString = [NSString stringWithFormat:@"%@",dictParam];
        }
        NSString *str = [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { method: %@ } { arguments: %@ } {time : %@} {timeInterval : %f}", NSStringFromClass([self class]), self, Url, self.currentRequest.HTTPMethod, self.paramUniqueString,date,[date timeIntervalSince1970]];
        _uuid = [MLSNetworkUtils md5StringFromString:str];
    }
    return _uuid;
}
- (NSString *)paramUniqueString {
    if (!_paramUniqueString) {
        NSMutableString *tmp = [[NSMutableString alloc] init];
        _paramUniqueString = [self getParamUniqueStringRecursive:self.requestFullParams startString:tmp];
    }
    return _paramUniqueString;
}
- (NSString *)getParamUniqueStringRecursive:(id)param startString:(NSMutableString *)startString {
    if (!param) {
        return startString;
    }
    if ([param isKindOfClass:[NSString class]]) {
        [startString appendString:param];
    } else if ([param isKindOfClass:[NSArray class]]) {
        [startString appendFormat:@"%@",param];
    } else if ([param isKindOfClass:[NSDictionary class]]) {
        NSDictionary *paramDict = (NSDictionary *)param;
        NSArray *keysSort = [paramDict keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [[obj1 description] compare:[obj2 description]];
        }];
        [keysSort enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            [startString appendFormat:@"key-%@,value-",key];
            [self getParamUniqueStringRecursive:[paramDict objectForKey:key] startString:startString];
            [startString appendString:@","];
        }];
        
    } else if ([param respondsToSelector:@selector(description)]) {
        [startString appendFormat:@"%@",[param description]];
    }
    return startString.copy;
}
#pragma mark - Request Configuration

- (void)setCompletionBlockWithSuccess:(MLSRequestCompletionBlock)success
                              failure:(MLSRequestCompletionBlock)failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)addAccessory:(id<MLSRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    if (accessory == nil) {
        return;
    }
    [self.requestAccessories addObject:accessory];
}

- (void)removeAccessory:(id<MLSRequestAccessory>)accessory {
    if (accessory == nil) {
        return;
    }
    [self.requestAccessories removeObject:accessory];
}

- (void)addUrlFilter:(id<MLSUrlFilterProtocol>)filter {
    if (!self.urlFilters) {
        self.urlFilters = [NSMutableArray array];
    }
    if (filter == nil) {
        return;
    }
    [self.urlFilters addObject:filter];
}


- (void)removeUrlFilter:(id<MLSUrlFilterProtocol>)filter {
    if (!self.urlFilters) {
        self.urlFilters = [NSMutableArray array];
    }
    if (filter == nil) {
        return;
    }
    [self.urlFilters removeObject:filter];
}
#pragma mark - Request Action

- (void)start {
    [self toggleAccessoriesWillStartcallback];
    [[MLSNetworkManager agentWithMoudleIdentifier:self.moudleIdentifier] addRequest:self];
}

- (void)stop {
    [self toggleAccessoriesWillStopcallback];
    self.delegate = nil;
    [[MLSNetworkManager agentWithMoudleIdentifier:self.moudleIdentifier] cancelRequest:self];
    [self toggleAccessoriesDidStopcallback];
}

- (void)startWithCompletionBlockWithSuccess:(MLSRequestCompletionBlock)success
                                    failure:(MLSRequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}


#pragma mark - Subclass Override

- (BOOL)requestCompletePreprocessor {
    return YES;
}

- (void)requestCompleteFilter {
}

- (BOOL)requestFailedPreprocessor {
    return YES;
}

- (BOOL)shouldRemoveFromAgent {
    return YES;
}

- (void)requestFailedFilter {
}

- (id)requestArgument {
    return @{};
}
- (NSDictionary *)requestQueryArgument {
    return @{};
}

- (id)requestFullParams {
    return @{};
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (nullable NSMutableDictionary<NSString *,NSString *> *)requestAuthorizationHeaderFieldDictionary {
    if (!_requestAuthorizationHeaderFieldDictionary) {
        _requestAuthorizationHeaderFieldDictionary = [NSMutableDictionary dictionary];
    }
    return _requestAuthorizationHeaderFieldDictionary;
}

- (NSMutableDictionary *)requestHeaderFieldValueDictionary {
    if (!_requestHeaderFieldValueDictionary) {
        _requestHeaderFieldValueDictionary = [NSMutableDictionary dictionary];
    }
    return _requestHeaderFieldValueDictionary;
}
- (nullable NSMutableSet<NSString *> *)acceptableContentTypes {
    if (_acceptableContentTypes == nil) {
        _acceptableContentTypes = [NSMutableSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain",@"text/xml",@"image/*", nil];
    }
    return _acceptableContentTypes;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (id)jsonValidator {
    return nil;
}

- (BOOL)statusCodeValidator:(NSError *__autoreleasing *)error {
    NSInteger statusCode = [self responseHeaderStatusCode];
    return (statusCode >= 200 && statusCode <= 299);
}

- (nullable NSString *)queryStringSerializationRequest:(NSURLRequest *)request param:(NSDictionary *)param error:(NSError *__autoreleasing *)error {
    return nil;
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { method: %@ } { arguments: %@ } { uuid: %@ }", NSStringFromClass([self class]), self, self.currentRequest.URL, self.currentRequest.HTTPMethod, self.requestFullParams,self.uuid];
}

@end
