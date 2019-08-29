//
//  ViewController.m
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import "ViewController.h"
#import "MLSTestApi.h"
#import <MLSLogger/MLSLogger.h>
#import "MLSDemoApiReq.h"
#import "MLSWordReviewRequest.h"
#import "MLSWordReviewModel.h"
#import <MLSNetwork/MLSNetwork.h>
@interface ViewController ()
@property (nonatomic, strong) MLSTestApi *api;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.api = [[MLSTestApi alloc] init];
}
- (IBAction)testRetry:(id)sender {
    MLSWordReviewRequest *req = [MLSWordReviewRequest requestWithParam:nil];
    req.requestUrl = @"/userMeasure/0/measureInfo";
    req.modelClass = MLSWordReviewModel.class;
    [req startWithModelCompletionBlockWithSuccess:^(__kindof MLSNetworkRequest *request, MLSWordReviewModel *model) {
        NSLog(@"%@",model);
    } failure:^(__kindof MLSNetworkRequest *request, MLSWordReviewModel *model) {
        NSLog(@"%@",model);
    }];
}
- (void)testRAC {
//    MLSWordReviewRequest *req = [MLSWordReviewRequest requestWithParam:nil];
//    req.requestUrl = @"/userMeasure/0/measureInfo";
//    req.modelClass = MLSWordReviewModel.class;
//    [req.rac_signal subscribeNext:^(MLSWordReviewModel *  _Nullable model) {
//
//    } error:^(NSError * _Nullable error) {
//
//    }];
}
- (void)testcoobjc {
    //    co_launch(^{
    //        MLSWordReviewRequest *req = [MLSWordReviewRequest requestWithParam:nil];
    //        req.requestUrl = @"/userMeasure/0/measureInfo";
    //        req.modelClass = MLSWordReviewModel.class;
    //        id model = nil;
    //        NSError *error = nil;
    //        co_unpack(nil, &model, &error) = co_await(req.async_request);
    //        if (co_getError()) {
    //            NSLog(@"%@",co_getError());
    //        }
    //        if (error != nil) {
    //            NSLog(@"%@",error);
    //        } else {
    //            NSLog(@"%@",model);
    //        }
    //    });
}
- (IBAction)testNormal:(id)sender {
    [[self.api pullUp] startWithModelCompletionBlockWithSuccess:^(__kindof MLSNetworkRequest *request, id model) {
        MLSLogger.verbose(@"----网络数据Success --%@",request);
    } failure:^(__kindof MLSNetworkRequest *request, id model) {
        MLSLogger.verbose(@"----网络数据Failed -- %@",request.error);
    }];
}
- (IBAction)testDemoReq:(id)sender {
    [[MLSDemoApiReq requestWithParam:@{
                                      @"type" : @"1",
                                      @"page" : @"1"
                                      }] startWithModelCompletionBlockWithSuccess:^(__kindof MLSNetworkRequest *request, NSArray<MLSTestModel *> *model) {
        MLSLogger.verbose(@"----网络数据Success --%@",request);
    } failure:^(__kindof MLSNetworkRequest *request, NSArray<MLSTestModel *> *model) {
        MLSLogger.verbose(@"----网络数据Failed --%@",request);
    }];
    
    
    
    MLSDemoBaseRequest < NSArray <MLSTestModel *>* >*req = [MLSDemoBaseRequest requestWithParam:@{
                                          @"type" : @"1",
                                          @"page" : @"1"
                                          }];
    req.modelClass = MLSTestModel.class;
    req.requestUrl = @"/satinApi";
    
    [req startWithModelCompletionBlockWithSuccess:^(__kindof MLSNetworkRequest *request, NSArray<MLSTestModel *> *model) {
        
    } failure:^(__kindof MLSNetworkRequest *request, NSArray<MLSTestModel *> *model) {
        
    }];
    
    
    
    [req startWithCompletionBlockWithSuccess:^(__kindof MLSBaseRequest *request) {
        MLSLogger.verbose(@"----网络数据Success --%@",request);
    } failure:^(__kindof MLSBaseRequest *request) {
        MLSLogger.verbose(@"----网络数据Failed --%@",request);
    }];
}

@end
