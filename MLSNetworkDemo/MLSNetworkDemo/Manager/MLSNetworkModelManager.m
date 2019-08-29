//
//  MLSModelManager.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/8.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "MLSNetworkModelManager.h"
#import <MLSModel/MLSModel.h>
@implementation MLSNetworkModelManager
+ (id)modelWithClass:(Class)modelClass isArray:(BOOL)isArray withJSON:(nonnull id)json
{
    if (isArray) {
        return [NSArray mls_modelArrayWithClass:modelClass json:json];
    }
    return [modelClass mls_modelWithJSON:json];
}
@end
