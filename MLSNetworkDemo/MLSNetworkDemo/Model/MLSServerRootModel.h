//
//  MLSServerRootModel.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/8.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <MLSModel/MLSModel.h>
#import <MLSNetwork/MLSNetwork.h>
@interface MLSServerRootModel : MLSBaseModel <MLSNetworkRootDataProtocol>
/// Protocol
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) id data;
@end
