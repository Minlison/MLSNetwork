//
//  MLSBatchRequestAgent.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLSBatchRequest;

/**
 网络请求代理
用来管理项目中所有的并发网络请求
 */
@interface MLSBatchRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 单利

 @return 单利代理
 */
+ (MLSBatchRequestAgent *)sharedAgent;


/**
 模块化代理
 会获取request的
 @return agent
 */
+ (MLSBatchRequestAgent *)shareAgentWithMoudleIdentifer:(NSString *)moudleIdentifier;

/**
 添加一个并发网络请求

 @param request 网络请求
 */
- (void)addBatchRequest:(MLSBatchRequest *)request;


/**
 移除一个并发网络请求

 @param request 网络请求
 */
- (void)removeBatchRequest:(MLSBatchRequest *)request;

@end

NS_ASSUME_NONNULL_END
