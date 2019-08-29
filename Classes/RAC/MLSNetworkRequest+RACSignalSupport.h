//
//  MLSNetwork+RAC.h
//  MLSNetwork
//
//  Created by Minlison on 2018/5/7.
//  Copyright © 2018年 Minlison. All rights reserved.
//
#if __has_include(<MLSNetwork/MLSNetwork.h>)
#import <MLSNetwork/MLSNetwork.h>
#else
#import "MLSNetwork.h"
#endif
#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

@interface MLSNetworkRequest (RACSignalSupport)

/**
 RAC 信号

 @return signal
 */
- (RACSignal *)rac_signal;

/**
 RAC 通道

 @return channel
 */
- (RACChannel *)rac_channelForKey:(NSString *)key nilValue:(id)nilValue;
@end
