//
//  MLSDemoBaseRequest.m
//  MLSNetwork
//
//  Created by minlison on 2019/2/22.
//  Copyright © 2019 minlison. All rights reserved.
//

#import "MLSDemoBaseRequest.h"
#import "MLSServerRootModel.h"
#import "MLSNetworkModelManager.h"
#import "MLSNetworkLogManager.h"
#import "MLSNetworkCacheManager.h"
@implementation MLSDemoBaseRequest
- (NSString *)baseUrl
{
    return @"https://www.apiopen.top";
}

- (Class<MLSNetworkRootDataProtocol>)serverRootDataClass {
    return MLSServerRootModel.class;
}
- (id<MLSNetworkModelProtocol>)modelManager {
    return (id<MLSNetworkModelProtocol>)MLSNetworkModelManager.class;
}
- (id<MLSNetworkLogProtocol>)logger {
    return (id<MLSNetworkLogProtocol>)MLSNetworkLogManager.class;
}
- (id<MLSNetworkCacheProtocol>)cacheManager {
    return (id<MLSNetworkCacheProtocol>)MLSNetworkCacheManager.class;
}
@end
