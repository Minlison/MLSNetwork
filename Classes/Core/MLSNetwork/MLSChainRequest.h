//
//  MLSChainRequest.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLSChainRequest;
@class MLSBaseRequest;
@protocol MLSRequestAccessory;

/**
 链式请求代理
 */
@protocol MLSChainRequestDelegate <NSObject>

@optional

/**
 请求成功

 @param chainRequest MLSChainRequest
 */
- (void)chainRequestFinished:(MLSChainRequest *)chainRequest;


/**
 请求失败

 @param chainRequest MLSChainRequest
 @param request 失败的 request
 */
- (void)chainRequestFailed:(MLSChainRequest *)chainRequest failedBaseRequest:(MLSBaseRequest*)request;

@end

typedef void (^MLSChaincallback)(MLSChainRequest *chainRequest, MLSBaseRequest *baseRequest);


/**
 链式请求
 按照数组顺序依次请求，只有第一个请求完成并且成功后，才会进行第二个请求
 */
@interface MLSChainRequest : NSObject
/**
 网络请求数组

 @return 网络请求数组
 */
- (NSArray<MLSBaseRequest *> *)requestArray;

/**
 代理
 */
@property (nonatomic, weak, nullable) id<MLSChainRequestDelegate> delegate;

/**
 监听网络请求状态
 */
@property (nonatomic, strong, nullable) NSMutableArray<id<MLSRequestAccessory>> *requestAccessories;


/**
 添加一个监听网络请求状态

 @param accessory 监听者
 */
- (void)addAccessory:(id<MLSRequestAccessory>)accessory;


/**
 开始
 */
- (void)start;


/**
 停止
 */
- (void)stop;


/**
 添加一个网络请求

 @param request 网络请求
 @param callback 回调
 */
- (void)addRequest:(MLSBaseRequest *)request callback:(nullable MLSChaincallback)callback;

@end

NS_ASSUME_NONNULL_END
