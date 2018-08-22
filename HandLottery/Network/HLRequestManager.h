//
//  HLRequestManager.h
//  HandLottery
//
//  Created by jrzl on 2018/8/22.
//  Copyright © 2018年 jrzl. All rights reserved.
//


typedef void(^HLRequestSuccessBlock)(NSURLSessionDataTask *task, id _Nullable responseObject);
typedef void(^HLRequestFailureBlock)(NSURLSessionDataTask * _Nullable task, NSError *error);


@interface HLRequestManager : NSObject


+ (instancetype)defaultManager;

/**
 获取某一期彩票开奖结果

 @param kindID 彩票种类ID
 @param issueNumber 当前查询的彩票期数
 */
+ (void)query_drawResultWithLotteryKindID:(NSString *)kindID
                              issueNumber:(NSString *)issueNumber;
//
//+ (void)query_historyResultWithLotterryKindID:(NSString *)kindID;

@end
