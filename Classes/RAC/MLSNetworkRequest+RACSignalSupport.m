//
//  MLSNetwork+RAC.m
//  MLSNetwork
//
//  Created by Minlison on 2018/5/7.
//  Copyright © 2018年 Minlison. All rights reserved.
//

#import "MLSNetworkRequest+RACSignalSupport.h"

@implementation MLSNetworkRequest (RACSignalSupport)
- (RACChannel *)rac_channelForKey:(NSString *)key nilValue:(id)nilValue {
#if DEBUG
    NSAssert(!self.isExecuting, @"正在处理请求中....");
#endif
    // 如果正在运行中
    if (self.isExecuting) {
        return nil;
    }
    RACChannel *channel = [[RACChannel alloc] init];
    
    [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
        [channel.followingTerminal sendCompleted];
    }]];
    
    RACSignal *eventSignal = [[self rac_signal]
                              takeUntil:[[channel.followingTerminal
                                          ignoreValues]
                                         catchTo:RACSignal.empty]];
    [[self
      rac_liftSelector:@selector(valueForKey:) withSignals:eventSignal, nil]
     subscribe:channel.followingTerminal];
    
    RACSignal *valuesSignal = [channel.followingTerminal
                               map:^(id value) {
                                   return value ?: nilValue;
                               }];
    [self rac_liftSelector:@selector(setValue:forKey:) withSignals:valuesSignal, [RACSignal return:key], nil];
    
    return channel.leadingTerminal;
}
- (RACSignal *)rac_signal {
    @weakify(self);
    return [[RACSignal
             createSignal:^(id<RACSubscriber> subscriber) {
                 @strongify(self);
                 if (self.serverRootDataClass && self.modelClass) {
                     [self startWithModelCompletionBlockWithSuccess:^(__kindof MLSNetworkRequest *request, id model) {
                         [subscriber sendNext:model];
                         [subscriber sendCompleted];
                     } failure:^(__kindof MLSNetworkRequest *request, id model) {
                         [subscriber sendError:request.error];
                         [subscriber sendCompleted];
                     }];
                 } else {
                     [self startWithCompletionBlockWithSuccess:^(__kindof MLSBaseRequest *request) {
                         [subscriber sendNext:request.responseObject];
                         [subscriber sendCompleted];
                     } failure:^(__kindof MLSBaseRequest *request) {
                         [subscriber sendError:request.error];
                         [subscriber sendCompleted];
                     }];
                 }
                 return [RACDisposable rac_deallocDisposable];
             }]
            setNameWithFormat:@"%@ -rac_signalForRequest", self];
}
@end
