//
//  MLSBatchRequestAgent.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSBatchRequestAgent.h"
#import "MLSBatchRequest.h"

@interface MLSBatchRequestAgent()

@property (strong, nonatomic) NSMutableArray<MLSBatchRequest *> *requestArray;

@end

@implementation MLSBatchRequestAgent

+ (MLSBatchRequestAgent *)sharedAgent {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
+ (MLSBatchRequestAgent *)shareAgentWithMoudleIdentifer:(NSString *)moudleIdentifier {
    if (moudleIdentifier.length <= 0) {
        return [self sharedAgent];
    }
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(MLSBatchRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(MLSBatchRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
