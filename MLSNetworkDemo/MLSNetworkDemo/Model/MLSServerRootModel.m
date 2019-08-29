//
//  MLSServerRootModel.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/8.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSServerRootModel.h"
#import "MLSTestApi.h"
@implementation MLSServerRootModel
@synthesize responseHeaderStatusCode;
- (BOOL)isValid {
    return self.code == 200;
}
- (BOOL)responseHeaderStatusCodeIsValid
{
    return (self.responseHeaderStatusCode >= 200 && self.responseHeaderStatusCode <= 299);
}

- (BOOL)needRetry {
    return self.code != 200;
}

- (BOOL)needRetryPreRequest {
    return YES;
}

- (MLSNetworkRequest *)retryPreRequest {
    return nil;
}

- (nullable NSError *)validError {
    return nil;
}

- (nullable NSDictionary<NSString *,id> *)nonnullDefaultValueProperties {
    return nil;
}



@end
