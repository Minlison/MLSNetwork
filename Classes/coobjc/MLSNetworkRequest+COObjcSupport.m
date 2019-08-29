//
//  MLSNetwork+RAC.m
//  MLSNetwork
//
//  Created by Minlison on 2018/5/7.
//  Copyright © 2018年 Minlison. All rights reserved.
//

#import "MLSNetworkRequest+COObjcSupport.h"
@implementation MLSNetworkRequest (COObjcSupport)
- (COPromise<COTuple3<MLSNetworkRequest *,id,NSError *> *> *)async_request {
#if DEBUG
    NSAssert(!self.isExecuting, @"正在处理请求中....");
#endif
    // 如果正在运行中
    if (self.isExecuting) {
        return nil;
    }
    __weak __typeof(self)weakSelf = self;
    return [COPromise promise:^(COPromiseFulfill  _Nonnull fullfill, COPromiseReject  _Nonnull reject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.serverRootDataClass && strongSelf.modelClass) {
            [strongSelf startWithModelCompletionBlockWithSuccess:^(__kindof MLSNetworkRequest *request, id model) {
                fullfill(co_tuple(request, model, nil));
            } failure:^(__kindof MLSNetworkRequest *request, id model) {
                fullfill(co_tuple(request, nil, request.error));
            }];
        } else {
            [strongSelf startWithCompletionBlockWithSuccess:^(__kindof MLSBaseRequest *request) {
                fullfill(co_tuple(request, request.responseObject, nil));
            } failure:^(__kindof MLSBaseRequest *request) {
                fullfill(co_tuple(request, nil, request.error));
            }];
        }
    }];
}

@end
