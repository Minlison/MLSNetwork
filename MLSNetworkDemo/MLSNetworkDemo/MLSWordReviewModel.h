//
//  MLSWordReviewModel.h
//  AFNetworking
//
//  Created by minlison on 2019/2/25.
//

#import <Foundation/Foundation.h>

#import <MLSModel/MLSModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLSWordReviewModel : NSObject
<MLSYYModel>

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;

@end

NS_ASSUME_NONNULL_END
