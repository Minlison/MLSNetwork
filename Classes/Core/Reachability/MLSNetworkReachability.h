//
//  MLSNetworkReachability.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 网络状态
 */
typedef NS_ENUM(NSUInteger, MLSNetWorkStatus) {
    MLSNetWorkStatusNotReachable = 0,
    MLSNetWorkStatusUnknown = 1,
    MLSNetWorkStatusWWAN2G = 2,
    MLSNetWorkStatusWWAN3G = 3,
    MLSNetWorkStatusWWAN4G = 4,
    MLSNetWorkStatusWiFi = 9,
};

FOUNDATION_EXTERN NSString *kMLSNetWorkReachabilityChangedNotification;
FOUNDATION_EXTERN NSString *kMLSNetWorkReachabilityStatusKey;

@interface MLSNetworkReachability : NSObject

/**
 单例，以当前网络连接来判断网络状态

 @return 单例
 */
+ (instancetype)shareManager;

/**
 根据指定域名，来判断网络状态

 @param hostName 域名
 @return MLSNetworkReachability Obj 不是单例
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/**
 根据指定 IP 判断网络状态

 @param hostAddress  IP 地址
 @return MLSNetworkReachability Obj 不是单例
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;


/**
 检查默认路由是否可用。 不能连接到特定主机。

 @return MLSNetworkReachability Obj 不是单例
 */
+ (instancetype)reachabilityForInternetConnection;

/**
 开启网络监测

 @return 是否开启成功
 */
- (BOOL)startNotifier;

/**
 停止网络监测
 */
- (void)stopNotifier;

/**
 是否是 WIFI
 */
- (BOOL)isWifi;

/**
 是否是蜂窝网络
 */
- (BOOL)isWLAN;

/**
 是否有网络连接
 */
- (BOOL)isReachabile;

/**
 设置网络状态监听回调， 只会回调最后一个设置的 block

 @param block 回调 block
 */
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(MLSNetWorkStatus status))block;

/**
  当前网络状态

 @return 网络状态
 */
- (MLSNetWorkStatus)currentReachabilityStatus;


@end

NS_ASSUME_NONNULL_END
