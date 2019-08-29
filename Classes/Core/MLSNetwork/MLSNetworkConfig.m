//
//  MLSNetworkConfig.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import "MLSNetworkConfig.h"
#import "MLSBaseRequest.h"
#import "MLSNetworkLogger.h"
#import "MLSNetworkManager.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
    #import <AFNetworking/AFNetworking.h>
#else
    #import "AFNetworking.h"
#endif

@implementation MLSNetworkConfig {
    NSMutableArray<id<MLSUrlFilterProtocol>> *_urlFilters;
}

+ (MLSNetworkConfig *)sharedConfig {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (MLSNetworkConfig *)sharedConfigWithMoudleIdentifier:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return [self sharedConfig];
    }
    return [MLSNetworkManager configWithMoudleIdentifier:moudleIdentifier];
}

- (void)setBaseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseUrl = @"";
        _cdnUrl = @"";
        _urlFilters = [NSMutableArray array];
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _debugLogEnabled = NO;
        _logger = (id)[MLSNetworkLogger class];
    }
    return self;
}

- (void)addUrlFilter:(id<MLSUrlFilterProtocol>)filter {
    [_urlFilters addObject:filter];
}
- (void)removeUrlFilter:(id<MLSUrlFilterProtocol>)filter {
    if (filter && [_urlFilters containsObject:filter]) {
        [_urlFilters removeObject:filter];
    }
}

- (void)clearUrlFilter {
    [_urlFilters removeAllObjects];
}

- (NSArray<id<MLSUrlFilterProtocol>> *)urlFilters {
    return [_urlFilters copy];
}


#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>{ baseURL: %@ } { cdnURL: %@ }", NSStringFromClass([self class]), self, self.baseUrl, self.cdnUrl];
}

@end
