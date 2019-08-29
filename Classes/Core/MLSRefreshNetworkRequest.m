//
//  MLSRefreshNetworkRequest.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/9.
//  Copyright © 2018年 minlison. All rights reserved.

//

#import "MLSRefreshNetworkRequest.h"
@interface MLSRefreshNetworkRequest ()
@property (nonatomic, assign, readwrite) NSUInteger currentPage;
@end
@implementation MLSRefreshNetworkRequest
- (MLSRefreshNetworkRequest *)pullDown {
    self.currentPage = self.pageStartNum;
    [self _InsertParam];
    return self;
}
- (MLSRefreshNetworkRequest *)pullUp {
    if (self.currentPage <= self.pageStartNum) {
        self.currentPage = self.pageStartNum;
    }
    [self _InsertParam];
    return self;
}
- (void)_InsertParam {
    if (self.pageKey) {
        [self paramInsert:@(self.currentPage++) forKey:self.pageKey];
    }
    if (self.pageLimitKey) {
        [self paramInsert:@(self.pageLimitValue) forKey:self.pageLimitKey];
    }
}
@end
