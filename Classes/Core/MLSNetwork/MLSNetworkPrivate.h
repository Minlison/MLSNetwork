//
//  MLSNetworkPrivate.h
//  MLSNetwork
//
//  Created by minlison on 2018/5/7.
//  Copyright © 2018年 minlison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLSRequest.h"
#import "MLSBaseRequest.h"
#import "MLSBatchRequest.h"
#import "MLSChainRequest.h"
#import "MLSNetworkAgent.h"
#import "MLSNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;

@interface MLSNetworkUtils : NSObject

+ (BOOL)validateJSON:(id)json withValidator:(id)jsonValidator;

+ (void)addDoNotBackupAttribute:(NSString *)path;

+ (NSString *)md5StringFromString:(NSString *)string;

+ (NSString *)appVersionString;

+ (NSStringEncoding)stringEncodingWithRequest:(MLSBaseRequest *)request;

+ (BOOL)validateResumeData:(NSData *)data;

@end

@interface MLSRequest (Getter)

- (NSString *)cacheBasePath;

@end

@interface MLSBaseRequest (Setter)

@property (nonatomic, strong, readwrite) NSURLSessionTask *requestTask;
@property (nonatomic, strong, readwrite, nullable) NSData *responseData;
@property (nonatomic, strong, readwrite, nullable) id responseJSONObject;
@property (nonatomic, strong, readwrite, nullable) id responseObject;
@property (nonatomic, strong, readwrite, nullable) NSString *responseString;
@property (nonatomic, strong, readwrite, nullable) NSError *error;

@end

@interface MLSBaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartcallback;
- (void)toggleAccessoriesWillStopcallback;
- (void)toggleAccessoriesDidStopcallback;
@end

@interface MLSBaseRequest (RequestClear)

- (void)clearCacheVariables;
- (void)clearCompletionBlock;

@end

@interface MLSBaseRequest (MLSParams)

- (id)requestFullParams;

@end

@interface MLSBaseRequest (MLSRetry)

- (BOOL)shouldRemoveFromAgent;

@end

@interface MLSBatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartcallback;
- (void)toggleAccessoriesWillStopcallback;
- (void)toggleAccessoriesDidStopcallback;

@end

@interface MLSChainRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartcallback;
- (void)toggleAccessoriesWillStopcallback;
- (void)toggleAccessoriesDidStopcallback;

@end

@interface MLSNetworkAgent (Private)

- (AFHTTPSessionManager *)manager;
- (void)resetURLSessionManager;
- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)configuration;
- (void)requestDidSucceedWithRequest:(MLSBaseRequest *)request;
- (void)requestDidFailWithRequest:(MLSBaseRequest *)request error:(NSError *)error;
- (NSString *)incompleteDownloadTempCacheFolder;

@end

NS_ASSUME_NONNULL_END

