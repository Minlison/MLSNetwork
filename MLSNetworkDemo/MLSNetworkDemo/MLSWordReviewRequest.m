//
//  MLSWordReviewRequest.m
//  AFNetworking
//
//  Created by minlison on 2019/2/22.
//

#import "MLSWordReviewRequest.h"

#import "MLSNetworkModelManager.h"
#import "MLSWordReviewModel.h"

@implementation MLSWordReviewRequest

- (NSString *)baseUrl
{
    return @"http://192.168.1.181:55244";
}

- (NSMutableDictionary *)requestHeaderFieldValueDictionary {
    NSDictionary *headers = @{
                              @"apiVersion" : @"2",
                              @"Content-Type" : @"application/json",
                              @"appversion" : @"10100000",
                              @"accesstoken" : @"4c199e5d-9ae1-4cbf-b18e-25e2255a5775",
                              @"appkey" : @"Toefl_65499613A4F3"
                              };
    
    return [headers mutableCopy];
}

- (id<MLSNetworkModelProtocol>)modelManager {
    return (id<MLSNetworkModelProtocol>)MLSNetworkModelManager.class;
}
- (void)dealloc {
    NSLog(@"---dealloc");
}
@end
