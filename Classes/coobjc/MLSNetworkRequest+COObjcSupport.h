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
#if __has_include(<coobjc/coobjc.h>)
    #import <coobjc/coobjc.h>
#else
    #import "coobjc.h"
#endif
@interface MLSNetworkRequest (COObjcSupport)

/**
 兼容coobjc处理
 其中返回的参数是一个元组 COTuple3
 第一个是该网络请求，第二个为请求结果，第三个为错误信息
 其中第一个不为空，后两个皆有可能为空
 不可以使用 co_getError() 获取错误信息
 @return COPromise
 */
- (COPromise <COTuple3 <MLSNetworkRequest *, id, NSError *>*>*)async_request;
@end
