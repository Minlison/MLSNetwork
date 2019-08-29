//
//  MLSBatchRequest.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSBatchRequest.h"
#import "MLSNetworkPrivate.h"
#import "MLSBatchRequestAgent.h"
#import "MLSRequest.h"
@interface MLSBatchRequest() <MLSRequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end

@implementation MLSBatchRequest

- (instancetype)initWithRequestArray:(NSArray<MLSRequest *> *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (MLSRequest * req in _requestArray) {
            if (![req isKindOfClass:[MLSRequest class]]) {
                [MLSNetworkConfig.sharedConfig.logger log:MLSNetworkLogLevelError msg:@"Error, request item must be MLSRequest instance."];
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_finishedCount > 0) {
        [MLSNetworkConfig.sharedConfig.logger log:MLSNetworkLogLevelError msg:@"Error! Batch request has already started."];
        return;
    }
    _failedRequest = nil;
    [[MLSBatchRequestAgent sharedAgent] addBatchRequest:self];
    [self toggleAccessoriesWillStartcallback];
    for (MLSRequest * req in _requestArray) {
        req.delegate = self;
        [req clearCompletionBlock];
        [req start];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopcallback];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopcallback];
    [[MLSBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(MLSBatchRequest *batchRequest))success
                                    failure:(void (^)(MLSBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(MLSBatchRequest *batchRequest))success
                              failure:(void (^)(MLSBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (MLSRequest *request in _requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(MLSRequest *)request {
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        [self toggleAccessoriesWillStopcallback];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopcallback];
        [[MLSBatchRequestAgent sharedAgent] removeBatchRequest:self];
    }
}

- (void)requestFailed:(MLSRequest *)request {
    _failedRequest = request;
    [self toggleAccessoriesWillStopcallback];
    // Stop
    for (MLSRequest *req in _requestArray) {
        [req stop];
    }
    // callback
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    // Clear
    [self clearCompletionBlock];

    [self toggleAccessoriesDidStopcallback];
    [[MLSBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)clearRequest {
    for (MLSRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<MLSRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

@end
