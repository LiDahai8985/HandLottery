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
 获取双色球开奖结果

 @param page 当前页码
 */
+ (void)query_unionLottoResultWithLotteryWithPage:(NSInteger)page;

/**
 获取大乐透开奖结果
 
 @param lastTerm  上一页最后一条term值
 @param pageCount 每页数量
 */
+ (void)query_superLottoResultWithLastTerm:(NSString *)lastTerm
                                  pageCount:(NSInteger)pageCount;

@end
