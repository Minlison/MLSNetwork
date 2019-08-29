//
//  MLSBatchRequest.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLSRequest;
@class MLSBatchRequest;
@protocol MLSRequestAccessory;

/**
 批量请求
 */
@protocol MLSBatchRequestDelegate <NSObject>

@optional

/**
 批量请求成功

 @param batchRequest 批量请求
 */
- (void)batchRequestFinished:(MLSBatchRequest *)batchRequest;

/**
 批量请求失败

 @param batchRequest 批量请求
 */
- (void)batchRequestFailed:(MLSBatchRequest *)batchRequest;

@end

/**
 批量请求处理
 内部的每个网络请求还走其原有的代理和回调方法
 */
@interface MLSBatchRequest : NSObject

/**
 批量请求数组
 */
@property (nonatomic, strong, readonly) NSArray<MLSRequest *> *requestArray;

/**
 代理
 */
@property (nonatomic, weak, nullable) id<MLSBatchRequestDelegate> delegate;

/**
 成功回调
 */
@property (nonatomic, copy, nullable) void (^successCompletionBlock)(MLSBatchRequest *);

/**
 失败回调
 */
@property (nonatomic, copy, nullable) void (^failureCompletionBlock)(MLSBatchRequest *);

/**
 网络 tag
 */
@property (nonatomic) NSInteger tag;

/**
 网络监听
 */
@property (nonatomic, strong, nullable) NSMutableArray<id<MLSRequestAccessory>> *requestAccessories;

/**
 失败的 request
 */
@property (nonatomic, strong, readonly, nullable) MLSRequest *failedRequest;

/**
 初试化方法

 @param requestArray 网络请求数组
 @return MLSBatchRequest
 */
- (instancetype)initWithRequestArray:(NSArray<MLSRequest *> *)requestArray;

/**
 设置回调 block

 @param success  成功
 @param failure 失败
 */
- (void)setCompletionBlockWithSuccess:(nullable void (^)(MLSBatchRequest *batchRequest))success
                              failure:(nullable void (^)(MLSBatchRequest *batchRequest))failure;


/**
 清除 block
 */
- (void)clearCompletionBlock;

/**
 添加网络请求状态监听

 @param accessory 监听
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
 开始

 @param success 成功 block
 @param failure  失败 block
 */
- (void)startWithCompletionBlockWithSuccess:(nullable void (^)(MLSBatchRequest *batchRequest))success
                                    failure:(nullable void (^)(MLSBatchRequest *batchRequest))failure;


/**
 是否是缓存的数据

 @return 是否是缓存的数据
 */
- (BOOL)isDataFromCache;

@end

NS_ASSUME_NONNULL_END
