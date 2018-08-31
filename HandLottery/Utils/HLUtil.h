//
//  HLUtil.h
//  HandLottery
//
//  Created by jrzl on 2018/8/29.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLSelectedColorBallModel.h"

@interface HLUtil : NSObject

/**
 组合排列计算
 C(get,from) = from! / (get!*(from-get)!) ;
 
 @param get 要取出的个数
 @param from 总共的个数
 @return 所有排列方式的总数
 */
+ (long)countOfGet:(NSUInteger)get from:(NSUInteger)from;


/**
 阶乘计算
 P(get,from) = from*(from-1)*(from-2)...(from-(get-1));
 
 @param get 阶乘等级
 @param from 总共的个数
 @return 阶乘结果
 */
+ (long)factorialCountOfGet:(NSUInteger)get from:(NSUInteger)from;



/**
 获取随机号码

 @param total 要获取的数量
 @param redRange (要取红球个数,取值范围）
 @param blueRange (要取蓝球个数,取值范围）
 @param sourceArray 已有的随机号码组合数据源
 @return 获取到的随机号码
 */
+ (NSArray *)randomNumWithTotalCount:(NSInteger)total
                            redRange:(NSRange)redRange
                           blueRange:(NSRange)blueRange
                         sourceArray:(NSArray<HLSelectedColorBallModel *> *)sourceArray;

@end
