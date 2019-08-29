//
//  MLSRefreshNetworkRequest.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/9.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkRequest.h"
NS_ASSUME_NONNULL_BEGIN
/**
 在使用此类的时候，需要进行强持有，才能保证刷新页码递增，如果不强持有，每次都会从0开始
 属性列表中，所有以 Key 结尾的属性，如果为空，那么对应字段不再写入参数中
 */
@interface MLSRefreshNetworkRequest <__covariant ContentType> : MLSNetworkRequest
/// MARK: - 上拉加载，下拉刷新

/**
 刷新页码键值 key
 */
@property (nonatomic, copy, nullable) NSString *pageKey;

/**
 起始页码，也就是第一次网络请求的页码
 */
@property (nonatomic, assign)  NSUInteger pageStartNum;

/**
 当前是第几页
 */
@property (nonatomic, assign, readonly) NSUInteger currentPage;

/**
 每页获取多少 Key
 */
@property (nonatomic, copy, nullable) NSString *pageLimitKey;

/**
 每页获取多少 Value
 */
@property (nonatomic, assign) NSUInteger pageLimitValue;

/**
 下拉刷新

 @return  request 本身，内部只对参数进行处理
 */
- (MLSRefreshNetworkRequest *)pullDown;

/**
 上拉加载

 @return  request 本身，内部只对参数进行处理
 */
- (MLSRefreshNetworkRequest *)pullUp;
@end
NS_ASSUME_NONNULL_END
