//
//  MLSDemoApiReq.m
//  MLSNetwork
//
//  Created by minlison on 2019/2/22.
//  Copyright © 2019 minlison. All rights reserved.
//

#import "MLSDemoApiReq.h"
#import "MLSTestModel.h"
@implementation MLSDemoApiReq
- (NSString *)requestUrl
{
    return @"/satinApi";
}
- (Class)modelClass
{
    return [MLSTestModel class];
}
- (MLSRequestMethod)requestMethod
{
    return MLSRequestMethodGET;
}

@end
