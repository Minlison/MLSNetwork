//
//  MLSNetworkLogger.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//

#import "MLSNetworkLogger.h"
#import "MLSNetworkConfig.h"
#define MLSNetworkLoggerMarco \
va_list args;\
va_start(args, fmt);\
NSLogv(fmt, args);\
va_end(args);

@implementation MLSNetworkLogger
+ (void)log:(MLSNetworkLogLevel)level msg:(NSString *)fmt, ... {
    if (MLSNetworkConfig.sharedConfig.debugLogEnabled) {
        MLSNetworkLoggerMarco        
    }
}


@end
