//
//  MLSChainRequestAgent.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLSChainRequest;


/**
 链式请求代理
用来管理项目中所有的链式网络请求
 */
@interface MLSChainRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;


/**
 单利

 @return 代理单利
 */
+ (MLSChainRequestAgent *)sharedAgent;


/**
 模块化代理
 会获取request的
 @return agent
 */
+ (MLSChainRequestAgent *)shareAgentWithMoudleIdentifer:(NSString *)moudleIdentifier;

/**
 添加一个链式请求

 @param request 链式请求
 */
- (void)addChainRequest:(MLSChainRequest *)request;


/**
 移除一个链式请求

 @param request 链式请求
 */
- (void)removeChainRequest:(MLSChainRequest *)request;

@end

NS_ASSUME_NONNULL_END
