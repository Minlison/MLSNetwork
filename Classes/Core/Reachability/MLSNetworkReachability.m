//
//  MLSNetworkReachability.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>
#import <netinet/in.h>

#import "MLSNetworkReachability.h"


NSString *kMLSNetWorkReachabilityChangedNotification = @"kMLSNetWorkReachabilityChangedNotification";
NSString *kMLSNetWorkReachabilityStatusKey = @"kMLSNetWorkReachabilityStatusKey";

static void Reachabilitycallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info);

typedef void(^MLSNetworkReachabilityBlock)(MLSNetWorkStatus status);

@interface MLSNetworkReachability()
@property(nonatomic, copy) MLSNetworkReachabilityBlock reachabilityBlock;
@end

@implementation MLSNetworkReachability
{
    SCNetworkReachabilityRef _reachabilityRef;
}
+ (instancetype)shareManager
{
	static MLSNetworkReachability *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [self reachabilityForInternetConnection];
	});
	return instance;
}
+ (instancetype)reachabilityWithHostName:(NSString *)hostName
{
    MLSNetworkReachability *returnValue = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if (reachability != NULL) {
        returnValue = [[self alloc] init];
        if (returnValue != NULL) {
            returnValue->_reachabilityRef = reachability;
        } else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);
    
    MLSNetworkReachability* returnValue = NULL;
    
    if (reachability != NULL)
    {
        returnValue = [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
        }
        else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}

+ (instancetype)reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    return [self reachabilityWithAddress: (const struct sockaddr *) &zeroAddress];
}

- (BOOL)startNotifier
{
    BOOL returnValue = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, Reachabilitycallback, &context)) {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode)) {
            returnValue = YES;
        }
    }
    return returnValue;
}
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(MLSNetWorkStatus status))block
{
	self.reachabilityBlock = block;
}
- (MLSNetWorkStatus)currentReachabilityStatus
{
    MLSNetWorkStatus returnValue = MLSNetWorkStatusNotReachable;
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        returnValue = [self networkStatusForFlags:flags];
    }
    
    return returnValue;
}
- (void)callbackForCurrentStatus
{
	MLSNetWorkStatus status = self.currentReachabilityStatus;
	[[NSNotificationCenter defaultCenter] postNotificationName:kMLSNetWorkReachabilityChangedNotification object:self userInfo:@{kMLSNetWorkReachabilityStatusKey : @(status)}];
	if (self.reachabilityBlock)
	{
		self.reachabilityBlock(status);
	}
}
- (MLSNetWorkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        // The target host is not reachable.
        return MLSNetWorkStatusNotReachable;
    }
    
    MLSNetWorkStatus returnValue = MLSNetWorkStatusNotReachable;
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        /*
         If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
         */
        returnValue = MLSNetWorkStatusWiFi;
    }
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        /*
         ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
         */
        
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            /*
             ... and no [user] intervention is needed...
             */
            returnValue = MLSNetWorkStatusWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        /*
         ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
         */
        NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                           CTRadioAccessTechnologyGPRS,
                           CTRadioAccessTechnologyCDMA1x];
        
        NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                           CTRadioAccessTechnologyWCDMA,
                           CTRadioAccessTechnologyHSUPA,
                           CTRadioAccessTechnologyCDMAEVDORev0,
                           CTRadioAccessTechnologyCDMAEVDORevA,
                           CTRadioAccessTechnologyCDMAEVDORevB,
                           CTRadioAccessTechnologyeHRPD];
        
        NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
            NSString *accessString = teleInfo.currentRadioAccessTechnology;
            if ([typeStrings4G containsObject:accessString]) {
                return MLSNetWorkStatusWWAN4G;
            } else if ([typeStrings3G containsObject:accessString]) {
                return MLSNetWorkStatusWWAN3G;
            } else if ([typeStrings2G containsObject:accessString]) {
                return MLSNetWorkStatusWWAN2G;
            } else {
                return MLSNetWorkStatusUnknown;
            }
        } else {
            return MLSNetWorkStatusUnknown;
        }
    }

    return returnValue;
}

- (void)stopNotifier
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}
- (BOOL)isWifi
{
        return [self currentReachabilityStatus] == MLSNetWorkStatusWiFi;
}
- (BOOL)isWLAN
{
        return ![self isWifi] && [self isReachabile];
}
- (BOOL)isReachabile
{
        return [self currentReachabilityStatus] != MLSNetWorkStatusNotReachable;
}
- (void)dealloc
{
    [self stopNotifier];
    if (_reachabilityRef != NULL)
    {
        CFRelease(_reachabilityRef);
    }
}


@end
static void Reachabilitycallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
	MLSNetworkReachability *networkObject = (__bridge MLSNetworkReachability *)info;
	[networkObject callbackForCurrentStatus];
}
