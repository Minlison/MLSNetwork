//
//  MLSNetworkAgent.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLSBaseRequest;


/**
 网络请求代理
 用来管理项目中所有的网络请求，在项目中使用 request 的时候，不用强持有，创建后直接运行即可
 */
@interface MLSNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;


/**
 单利

 @return 单利
 */
+ (MLSNetworkAgent *)sharedAgent;

/**
 模块化代理
 会获取request的
 @return agent
 */
+ (MLSNetworkAgent *)shareAgentWithMoudleIdentifer:(NSString *)moudleIdentifier;


/**
 添加一个网络请求

 @param request 网络请求
 */
- (void)addRequest:(MLSBaseRequest *)request;


/**
 取消一个网络请求

 @param request 网络请求
 */
- (void)cancelRequest:(MLSBaseRequest *)request;


/**
 取消所有的网络请求
 */
- (void)cancelAllRequests;


/**
 构建 url

 @param request  网络请求
 @return  url
 */
- (NSString *)buildRequestUrl:(MLSBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
