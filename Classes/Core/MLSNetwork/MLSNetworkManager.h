//
//  MLSNetworkManager.h
//  MLSNetwork
//
//  Created by minlison on 2019/2/27.
//

#import <Foundation/Foundation.h>
@class MLSNetworkConfig;
@class MLSNetworkAgent;
@class MLSBatchRequestAgent;
@class MLSChainRequestAgent;

NS_ASSUME_NONNULL_BEGIN

@interface MLSNetworkManager : NSObject

/**
 根据moudleIdentifier获取配置信息
 如果没有，则会创建
 
 @param moudleIdentifier 模块标识
 @return MLSNetworkConfig
 */
+ (MLSNetworkConfig *)configWithMoudleIdentifier:(NSString *)moudleIdentifier;

/**
 根据moudleIdentifier获取agent信息
 如果没有，则会创建
 
 @param moudleIdentifier 模块标识
 @return MLSNetworkAgent
 */
+ (MLSNetworkAgent *)agentWithMoudleIdentifier:(NSString *)moudleIdentifier;

/**
 根据moudleIdentifier获取batchAgent信息
 如果没有，则会创建
 
 @param moudleIdentifier 模块标识
 @return MLSBatchRequestAgent
 */
+ (MLSBatchRequestAgent *)batchAgentWithMoudleIdentifier:(NSString *)moudleIdentifier;

/**
 根据moudleIdentifier获取chainAgent信息
 如果没有，则会创建
 
 @param moudleIdentifier 模块标识
 @return MLSChainRequestAgent
 */
+ (MLSChainRequestAgent *)chainAgentWithMoudleIdentifier:(NSString *)moudleIdentifier;
@end

NS_ASSUME_NONNULL_END
