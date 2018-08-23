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
        
        NSSet *contentTypesSet = [NSSet setWithObjects:@"application/json", @"text/javascript",@"text/json",nil];
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

+ (void)setCookie
{
    
}

+ (nullable NSURLSessionDataTask *)HLPOSTRequestWithURL:(NSString *)url
                               parameters:(nullable id)parameters
                                  success:(void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    [[[self defaultManager] sessionManager].requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    return [[[self defaultManager] sessionManager] POST:url
                                             parameters:parameters
                                               progress:nil
                                                success:success
                                                failure:failure];
}

+ (nullable NSURLSessionDataTask *)HLGETRequestWithURL:(NSString *)url
                                            parameters:(nullable id)parameters
                                               success:(void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                               failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    [[[self defaultManager] sessionManager].requestSerializer setValue:@"059b495d75e92a3223fec2bb2ffd671d" forHTTPHeaderField:@"accept-charset"];
    return [[[self defaultManager] sessionManager] GET:url
                                            parameters:parameters
                                              progress:nil
                                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                   id jsonObject;
                                                   if ([responseObject isKindOfClass:[NSData class]]) {
                                                       NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                       jsonString = [jsonString substringWithRange:NSMakeRange(5, jsonString.length - 6)];
                                                       jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
                                                   }
                                                   
                                                   NSLog(@"请求结果：\n%@\n%@",task.currentRequest.URL.absoluteString,jsonObject);
                                                   success(task, jsonObject);
                                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                   NSLog(@"失败结果：\n%@\n%@",task.currentRequest.URL.absoluteString,error);
                                                   failure(task, error);
                                               }];
}

+ (void)query_unionLottoResultWithLotteryWithPage:(NSInteger)page
                                          success:(HLRequestSuccessBlock)success
                                          failure:(HLRequestSuccessBlock)failure
{
    [self HLGETRequestWithURL:@"http://c.cwl.gov.cn/zcms/mob/getOldLotterys"
                   parameters:@{@"callback":@"1023",@"game":@"ssq",@"limit":@"20",@"page":@(page)}
                      success:success
                      failure:failure];
}

+ (void)query_superLottoResultWithLastTerm:(NSString *)lastTerm
                                 pageCount:(NSInteger)pageCount
                                   success:(HLRequestSuccessBlock)success
                                   failure:(HLRequestSuccessBlock)failure
{
    [self HLPOSTRequestWithURL:@"http://m.lottery.gov.cn/api/mlottery_kj_detail.jspx"
                   parameters:@{@"_ltype":@"4",@"_term":@"ssq",@"_num":@(pageCount)}
                      success:success
                       failure:failure];
}

@end
