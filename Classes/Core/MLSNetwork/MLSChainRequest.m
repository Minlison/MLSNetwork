//
//  MLSChainRequest.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//


#import "MLSChainRequest.h"
#import "MLSChainRequestAgent.h"
#import "MLSNetworkPrivate.h"
#import "MLSBaseRequest.h"
#import "MLSNetworkManager.h"

@interface MLSChainRequest()<MLSRequestDelegate>

@property (strong, nonatomic) NSMutableArray<MLSBaseRequest *> *requestArray;
@property (strong, nonatomic) NSMutableArray<MLSChaincallback> *requestcallbackArray;
@property (assign, nonatomic) NSUInteger nextRequestIndex;
@property (strong, nonatomic) MLSChaincallback emptycallback;

@end

@implementation MLSChainRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _nextRequestIndex = 0;
        _requestArray = [NSMutableArray array];
        _requestcallbackArray = [NSMutableArray array];
        _emptycallback = ^(MLSChainRequest *chainRequest, MLSBaseRequest *baseRequest) {
            // do nothing
        };
    }
    return self;
}

- (void)start {
    if (_nextRequestIndex > 0) {
        [MLSNetworkConfig.sharedConfig.logger log:MLSNetworkLogLevelError msg:@"Error! Chain request has already started."];
        return;
    }

    if ([_requestArray count] > 0) {
        [self toggleAccessoriesWillStartcallback];
        [self startNextRequest];
        [[MLSChainRequestAgent sharedAgent] addChainRequest:self];
    } else {
        [MLSNetworkConfig.sharedConfig.logger log:MLSNetworkLogLevelError msg:@"Error! Chain request array is empty."];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopcallback];
    [self clearRequest];
    [[MLSChainRequestAgent sharedAgent] removeChainRequest:self];
    [self toggleAccessoriesDidStopcallback];
}

- (void)addRequest:(MLSBaseRequest *)request callback:(MLSChaincallback)callback {
    [_requestArray addObject:request];
    if (callback != nil) {
        [_requestcallbackArray addObject:callback];
    } else {
        [_requestcallbackArray addObject:_emptycallback];
    }
}

- (NSArray<MLSBaseRequest *> *)requestArray {
    return _requestArray;
}

- (BOOL)startNextRequest {
    if (_nextRequestIndex < [_requestArray count]) {
        MLSBaseRequest *request = _requestArray[_nextRequestIndex];
        _nextRequestIndex++;
        request.delegate = self;
        [request clearCompletionBlock];
        [request start];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(MLSBaseRequest *)request {
    NSUInteger currentRequestIndex = _nextRequestIndex - 1;
    MLSChaincallback callback = _requestcallbackArray[currentRequestIndex];
    callback(self, request);
    if (![self startNextRequest]) {
        [self toggleAccessoriesWillStopcallback];
        if ([_delegate respondsToSelector:@selector(chainRequestFinished:)]) {
            [_delegate chainRequestFinished:self];
            [[MLSChainRequestAgent sharedAgent] removeChainRequest:self];
        }
        [self toggleAccessoriesDidStopcallback];
    }
}

- (void)requestFailed:(MLSBaseRequest *)request {
    [self toggleAccessoriesWillStopcallback];
    if ([_delegate respondsToSelector:@selector(chainRequestFailed:failedBaseRequest:)]) {
        [_delegate chainRequestFailed:self failedBaseRequest:request];
        [[MLSChainRequestAgent sharedAgent] removeChainRequest:self];
    }
    [self toggleAccessoriesDidStopcallback];
}

- (void)clearRequest {
    NSUInteger currentRequestIndex = _nextRequestIndex - 1;
    if (currentRequestIndex < [_requestArray count]) {
        MLSBaseRequest *request = _requestArray[currentRequestIndex];
        [request stop];
    }
    [_requestArray removeAllObjects];
    [_requestcallbackArray removeAllObjects];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<MLSRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

@end
