//
//  MLSTestApi.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/8.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSTestApi.h"


@implementation MLSTestApi
- (NSString *)baseUrl
{
    return @"https://www.apiopen.top";
}
- (NSString *)requestUrl
{
    return @"/satinApi";
}

- (Class)modelClass
{
    return [MLSTestModel class];
}
- (NSString *)pageKey
{
    return @"page";
}
- (NSUInteger)pageStartNum
{
    return 1;
}

- (MLSRequestMethod)requestMethod
{
    return MLSRequestMethodGET;
}
- (id)requestArgument {
    return @{
             @"type" : @"1",
             @"page" : @"1"
             };
}
@end
