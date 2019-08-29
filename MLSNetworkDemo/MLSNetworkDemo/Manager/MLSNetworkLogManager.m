//
//  MLSNetworkLogManager.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/8.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkLogManager.h"
#import <MLSLogger/MLSLogger.h>
@implementation MLSNetworkLogManager
+ (void)log:(MLSNetworkLogLevel)level msg:(NSString *)fmt,...
{

    va_list args;
    va_start(args, fmt);
    NSString *logString = [[NSString alloc] initWithFormat:fmt arguments:args];


    switch (level) {
        case MLSNetworkLogLevelAll:
        {
            MLSLogger.verbose(logString);
        }
            break;
        case MLSNetworkLogLevelVerbose:
        {
            MLSLogger.verbose(logString);
        }
            break;
            
        case MLSNetworkLogLevelDebug:
        {
            MLSLogger.debug(logString);
        }
            break;
        case MLSNetworkLogLevelInfo:
        {
            MLSLogger.info(logString);
        }
            break;
        case MLSNetworkLogLevelWarning:
        {
            MLSLogger.warning(logString);
        }
            break;
        case MLSNetworkLogLevelError:
        {
            MLSLogger.error(logString);
        }
            break;
            
        default:
            break;
    }
    
    va_end(args);
}
@end
