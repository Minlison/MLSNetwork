//
//  MLSNetworkCacheManager.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/8.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkCacheManager.h"
#import <MLSCache/MLSCache.h>
@implementation MLSNetworkCacheManager

+ (nullable NSObject<NSCoding> *)cachedObjectForKey:(nonnull NSString *)key {
    return (id)[MLSCacheAutoManager objectForKey:key];
}

+ (void)setObj:(nullable NSObject<NSCoding> *)obj forKey:(nonnull NSString *)key {
    [MLSCacheAutoManager setObject:obj forKey:key];
}

@end
