//
//  MLSChainRequestAgent.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSChainRequestAgent.h"
#import "MLSChainRequest.h"

@interface MLSChainRequestAgent()

@property (strong, nonatomic) NSMutableArray<MLSChainRequest *> *requestArray;

@end

@implementation MLSChainRequestAgent

+ (MLSChainRequestAgent *)sharedAgent {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
+ (MLSChainRequestAgent *)shareAgentWithMoudleIdentifer:(NSString *)moudleIdentifier {
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

- (void)addChainRequest:(MLSChainRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeChainRequest:(MLSChainRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
