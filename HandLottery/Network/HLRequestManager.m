//
//  HLRequestManager.m
//  HandLottery
//
//  Created by jrzl on 2018/8/22.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLRequestManager.h"
#import "AFHTTPSessionManager.h"

@interface HLRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end



@implementation HLRequestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSSet *contentTypesSet = [NSSet setWithObjects:@"application/json",
                                   @"text/json",
                                   @"text/javascripte",
                                   @"text/css",
                                   @"text/plain",
                                   @"charset/UTF-8",
                                   nil];
        self.sessionManager.responseSerializer.acceptableContentTypes = contentTypesSet;
        self.sessionManager.requestSerializer.timeoutInterval = 30;
    
    }
    return self;
}

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    static HLRequestManager *_manager;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

+ (nullable NSURLSessionDataTask *)HLPOSTRequestWithURL:(NSString *)url
                               parameters:(nullable id)parameters
                                  success:(void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    return [[[self defaultManager] sessionManager] POST:url
                                     parameters:parameters
                                       progress:^(NSProgress * _Nonnull uploadProgress) {
                                           
                                       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           
                                       }];
}

+ (nullable NSURLSessionDataTask *)HLGETRequestWithURL:(NSString *)url
                                            parameters:(nullable id)parameters
                                               success:(void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                               failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    return [[[self defaultManager] sessionManager] GET:url
                                    parameters:parameters
                                      progress:^(NSProgress * _Nonnull downloadProgress) {
                                          
                                      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          
                                      }];
}

+ (void)query_drawResultWithLotteryKindID:(NSString *)kindID
                              issueNumber:(NSString *)issueNumber
{

}

@end
