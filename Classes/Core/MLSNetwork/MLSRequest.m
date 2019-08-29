//
//  MLSRequest.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkConfig.h"
#import "MLSRequest.h"
#import "MLSNetworkPrivate.h"
#import "MLSNetworkRequest.h"
#import "MLSNetworkManager.h"
#ifndef NSFoundationVersionNumber_iOS_8_0
#define NSFoundationVersionNumber_With_QoS_Available 1140.11
#else
#define NSFoundationVersionNumber_With_QoS_Available NSFoundationVersionNumber_iOS_8_0
#endif

NSString *const MLSRequestCacheErrorDomain = @"com.minlison.request.caching";

static dispatch_queue_t ytkrequest_cache_writing_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_attr_t attr = DISPATCH_QUEUE_SERIAL;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_With_QoS_Available) {
            attr = dispatch_queue_attr_make_with_qos_class(attr, QOS_CLASS_BACKGROUND, 0);
        }
        queue = dispatch_queue_create("com.minlison.ytkrequest.caching", attr);
    });

    return queue;
}

@interface MLSCacheMetadata : NSObject<NSSecureCoding>

@property (nonatomic, assign) long long version;
@property (nonatomic, strong) NSString *sensitiveDataString;
@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString *appVersionString;

@end

@implementation MLSCacheMetadata

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.version) forKey:NSStringFromSelector(@selector(version))];
    [aCoder encodeObject:self.sensitiveDataString forKey:NSStringFromSelector(@selector(sensitiveDataString))];
    [aCoder encodeObject:@(self.stringEncoding) forKey:NSStringFromSelector(@selector(stringEncoding))];
    [aCoder encodeObject:self.creationDate forKey:NSStringFromSelector(@selector(creationDate))];
    [aCoder encodeObject:self.appVersionString forKey:NSStringFromSelector(@selector(appVersionString))];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (!self) {
        return nil;
    }

    self.version = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(version))] integerValue];
    self.sensitiveDataString = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(sensitiveDataString))];
    self.stringEncoding = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(stringEncoding))] integerValue];
    self.creationDate = [aDecoder decodeObjectOfClass:[NSDate class] forKey:NSStringFromSelector(@selector(creationDate))];
    self.appVersionString = [aDecoder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(appVersionString))];

    return self;
}

@end

@interface MLSRequest()

@property (nonatomic, strong) NSData *cacheData;
@property (nonatomic, strong) NSString *cacheString;
@property (nonatomic, strong) id cacheJSON;
@property (nonatomic, strong) NSXMLParser *cacheXML;

@property (nonatomic, strong) MLSCacheMetadata *cacheMetadata;
@property (nonatomic, assign) BOOL dataFromCache;

@end

@implementation MLSRequest

- (void)start {
    if (self.ignoreCache || !self.cacheable) {
        [self startWithoutCache];
        return;
    }

    // Do not cache download request.
    if (self.resumableDownloadPath) {
        [self startWithoutCache];
        return;
    }

    if (![self loadCacheWithError:nil]) {
        [self startWithoutCache];
        return;
    }

    _dataFromCache = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self requestCompletePreprocessor]) {
            [self requestCompleteFilter];
            [self.delegate requestFinished:self];
            if (self.successCompletionBlock) {
                self.successCompletionBlock(self);
            }
            [self clearCompletionBlock];
        }
    });
}

- (void)startWithoutCache {
    [self clearCacheVariables];
    [super start];
}
- (void)startWithCache:(BOOL)cacheable
withCompletionBlockWithSuccess:(MLSRequestCompletionBlock)success
               failure:(MLSRequestCompletionBlock)failure {
    self.cacheable = cacheable;
    [self startWithCompletionBlockWithSuccess:success failure:failure];
    
}
#pragma mark - Network Request Delegate

- (BOOL)requestCompletePreprocessor {
    BOOL superRes = [super requestCompletePreprocessor];

    NSData *cacheData = [super responseData];
    id<MLSEncryptProtocol>enctyptManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].enctyptManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        MLSNetworkRequest *tmp = (MLSNetworkRequest *)self;
        enctyptManager = [tmp enctyptManager];
    }
    
    if (cacheData && enctyptManager) {
        cacheData = [enctyptManager encryptSubmitData:cacheData];
    }
    
    if (self.writeCacheAsynchronously) {
        dispatch_async(ytkrequest_cache_writing_queue(), ^{
            [self saveResponseDataToCacheFile:cacheData];
        });
    } else {
        [self saveResponseDataToCacheFile:cacheData];
    }
    return superRes;
}


- (void)clearCache {
    id <MLSNetworkCacheProtocol> cacheManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cacheManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        cacheManager = [(MLSNetworkRequest *)self cacheManager];
    }
    /// 如果有 cacheManager 则更换协议方法
    if (cacheManager) {
        NSString *key = [MLSNetworkUtils md5StringFromString:[self cacheFilePath]];
        [cacheManager setObj:nil forKey:key];
    }
    else if ([self cacheTimeInSeconds] > 0 && ![self isDataFromCache]) {
        [[NSFileManager defaultManager] removeItemAtPath:[self cacheMetadataFilePath] error:nil];
    }
}
#pragma mark - Subclass Override

- (NSInteger)cacheTimeInSeconds {
    return -1;
}

- (long long)cacheVersion {
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] longLongValue];
}
- (NSString *)cacheVersionString {
    return [NSString stringWithFormat:@"%lld", [self cacheVersion]];
}

- (id)cacheSensitiveData {
    return nil;
}

- (BOOL)writeCacheAsynchronously {
    return YES;
}

#pragma mark -

- (BOOL)isDataFromCache {
    return _dataFromCache;
}

- (NSData *)responseData {
    if (_cacheData) {
        return _cacheData;
    }
    return [super responseData];
}

- (NSString *)responseString {
    if (_cacheString) {
        return _cacheString;
    }
    return [super responseString];
}

- (id)responseJSONObject {
    if (_cacheJSON) {
        return _cacheJSON;
    }
    return [super responseJSONObject];
}

- (id)responseObject {
    if (_cacheJSON) {
        return _cacheJSON;
    }
    if (_cacheXML) {
        return _cacheXML;
    }
    if (_cacheData) {
        return _cacheData;
    }
    return [super responseObject];
}

#pragma mark -

- (BOOL)loadCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    
    id <MLSNetworkCacheProtocol> cacheManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cacheManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        cacheManager = [(MLSNetworkRequest *)self cacheManager];
    }
    /// 如果没有自定义缓存模块，则使用原有缓存模块
    if ( !cacheManager )
    {
        // Make sure cache time in valid.
        if ([self cacheTimeInSeconds] < 0) {
            if (error) {
                *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorInvalidCacheTime userInfo:@{ NSLocalizedDescriptionKey:@"Invalid cache time"}];
            }
            return NO;
        }
        
        // Try load metadata.
        if (![self loadCacheMetadata]) {
            if (error) {
                *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorInvalidMetadata userInfo:@{ NSLocalizedDescriptionKey:@"Invalid metadata. Cache may not exist"}];
            }
            return NO;
        }
        
        // Check if cache is still valid.
        if (![self validateCacheWithError:error]) {
            return NO;
        }
    }
    // Try load cache.
    if (![self loadCacheData]) {
        if (error) {
            *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorInvalidCacheData userInfo:@{ NSLocalizedDescriptionKey:@"Invalid cache data"}];
        }
        return NO;
    }

    return YES;
}

- (BOOL)validateCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    // Date
    NSDate *creationDate = self.cacheMetadata.creationDate;
    NSTimeInterval duration = -[creationDate timeIntervalSinceNow];
    if (duration < 0 || duration > [self cacheTimeInSeconds]) {
        if (error) {
            *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorExpired userInfo:@{ NSLocalizedDescriptionKey:@"Cache expired"}];
        }
        return NO;
    }
    // Version
    long long cacheVersionFileContent = self.cacheMetadata.version;
    if (cacheVersionFileContent != [self cacheVersion]) {
        if (error) {
            *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorVersionMismatch userInfo:@{ NSLocalizedDescriptionKey:@"Cache version mismatch"}];
        }
        return NO;
    }
    // Sensitive data
    NSString *sensitiveDataString = self.cacheMetadata.sensitiveDataString;
    NSString *currentSensitiveDataString = ((NSObject *)[self cacheSensitiveData]).description;
    if (sensitiveDataString || currentSensitiveDataString) {
        // If one of the strings is nil, short-circuit evaluation will trigger
        if (sensitiveDataString.length != currentSensitiveDataString.length || ![sensitiveDataString isEqualToString:currentSensitiveDataString]) {
            if (error) {
                *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorSensitiveDataMismatch userInfo:@{ NSLocalizedDescriptionKey:@"Cache sensitive data mismatch"}];
            }
            return NO;
        }
    }
    // App version
    NSString *appVersionString = self.cacheMetadata.appVersionString;
    NSString *currentAppVersionString = [MLSNetworkUtils appVersionString];
    if (appVersionString || currentAppVersionString) {
        if (appVersionString.length != currentAppVersionString.length || ![appVersionString isEqualToString:currentAppVersionString]) {
            if (error) {
                *error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorAppVersionMismatch userInfo:@{ NSLocalizedDescriptionKey:@"App version mismatch"}];
            }
            return NO;
        }
    }
    return YES;
}

- (BOOL)loadCacheMetadata {
    NSString *path = [self cacheMetadataFilePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        @try {
            _cacheMetadata = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            return YES;
        } @catch (NSException *exception) {
            [[MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].logger log:MLSNetworkLogLevelError msg:@"Load cache metadata failed, reason = %@", exception.reason];
            return NO;
        }
    }
    return NO;
}

- (BOOL)loadCacheData {
    NSString *path = [self cacheFilePath];
    NSData *data = nil;
    NSError *error = nil;
    id <MLSNetworkCacheProtocol> cacheManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cacheManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        cacheManager = [(MLSNetworkRequest *)self cacheManager];
    }
    /// 如果有 cacheManager 则更换协议方法
    if (cacheManager)
    {
        NSString *key = [MLSNetworkUtils md5StringFromString:path];
        data = (NSData *)[cacheManager cachedObjectForKey:key];
        if (!data)
        {
            error = [NSError errorWithDomain:MLSRequestCacheErrorDomain code:MLSRequestCacheErrorInvalidCacheData userInfo:nil];
            return NO;
        }
    }
    else
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
            data = [NSData dataWithContentsOfFile:path];
            if (!data) {
                return NO;
            }
        }
    }
    
    id <MLSEncryptProtocol> enctyptManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].enctyptManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        enctyptManager = [(MLSNetworkRequest *)self enctyptManager];
    }
    
    if (enctyptManager) {
        data = [enctyptManager decryptServerData:data];
    }
    _cacheData = data;
    _cacheString = [[NSString alloc] initWithData:_cacheData encoding:self.cacheMetadata.stringEncoding];
    switch (self.responseSerializerType)
    {
        case MLSResponseSerializerTypeHTTP:
            // Do nothing.
            return YES;
        case MLSResponseSerializerTypeJSON:
            _cacheJSON = [NSJSONSerialization JSONObjectWithData:_cacheData options:(NSJSONReadingOptions)0 error:&error];
            return error == nil;
        case MLSResponseSerializerTypeXMLParser:
            _cacheXML = [[NSXMLParser alloc] initWithData:_cacheData];
            return YES;
    }
    
    return NO;
}

- (void)saveResponseDataToCacheFile:(NSData *)data {
    if (!self.cacheable) {
        return;
    }
    id <MLSNetworkCacheProtocol> cacheManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cacheManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        cacheManager = [(MLSNetworkRequest *)self cacheManager];
    }
    /// 如果有 cacheManager 则更换协议方法
    if (cacheManager)
    {
        NSString *key = [MLSNetworkUtils md5StringFromString:[self cacheFilePath]];
        [cacheManager setObj:data forKey:key];
    }
    else if ([self cacheTimeInSeconds] > 0 && ![self isDataFromCache])
    {
        if (data != nil) {
            @try {
                // New data will always overwrite old data.
                [data writeToFile:[self cacheFilePath] atomically:YES];

                MLSCacheMetadata *metadata = [[MLSCacheMetadata alloc] init];
                metadata.version = [self cacheVersion];
                metadata.sensitiveDataString = ((NSObject *)[self cacheSensitiveData]).description;
                metadata.stringEncoding = [MLSNetworkUtils stringEncodingWithRequest:self];
                metadata.creationDate = [NSDate date];
                metadata.appVersionString = [MLSNetworkUtils appVersionString];
                [NSKeyedArchiver archiveRootObject:metadata toFile:[self cacheMetadataFilePath]];
            } @catch (NSException *exception) {
                [[MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].logger log:MLSNetworkLogLevelError msg:@"Save cache failed, reason = %@", exception.reason];

            }
        }
    }
}

- (void)clearCacheVariables {
    _cacheData = nil;
    _cacheXML = nil;
    _cacheJSON = nil;
    _cacheString = nil;
    _cacheMetadata = nil;
    _dataFromCache = NO;
    id <MLSNetworkCacheProtocol> cacheManager = [MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].cacheManager;
    if ([self isKindOfClass:[MLSNetworkRequest class]]) {
        cacheManager = [(MLSNetworkRequest *)self cacheManager];
    }
    if (cacheManager) {
        if (cacheManager)
        {
            NSString *key = [MLSNetworkUtils md5StringFromString:[self cacheFilePath]];
            [cacheManager setObj:nil forKey:key];
        }
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:[self cacheFilePath] error:NULL];
    }
}

#pragma mark -

- (void)createDirectoryIfNeeded:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

- (void)createBaseDirectoryAtPath:(NSString *)path {
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        [[MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].logger log:MLSNetworkLogLevelError msg:@"create cache directory failed, error = %@", error];
    } else {
        [MLSNetworkUtils addDoNotBackupAttribute:path];
    }
}

- (NSString *)cacheBasePath {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"LazyRequestCache"];
    path = [path stringByAppendingFormat:@"/%@",[self cacheVersionString]];

    [self createDirectoryIfNeeded:path];
    return path;
}

- (NSString *)cacheFileName {
    NSString *requestUrl = [self requestUrl];
    NSString *baseUrl = self.baseUrl ?:[MLSNetworkManager configWithMoudleIdentifier:self.moudleIdentifier].baseUrl;
//    id argument = [self cacheFileNameFilterForRequestArgument:[self requestFullParams]];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@",
                             (long)[self requestMethod], baseUrl, requestUrl, self.paramUniqueString];
    NSString *cacheFileName = [MLSNetworkUtils md5StringFromString:requestInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath {
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheMetadataFilePath {
    NSString *cacheMetadataFileName = [NSString stringWithFormat:@"%@.metadata", [self cacheFileName]];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheMetadataFileName];
    return path;
}

@end
