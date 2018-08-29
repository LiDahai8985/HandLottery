//
//  HLUtil.m
//  HandLottery
//
//  Created by jrzl on 2018/8/29.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLUtil.h"

@implementation HLUtil


/**
 组合排列计算
 C(get,from) = from! / (get!*(from-get)!) ;
 
 @param get 要取出的个数
 @param from 总共的个数
 @return 所有排列方式的总数
 */
+ (long)countOfGet:(NSUInteger)get from:(NSUInteger)from
{
    if (get<1 || get>from) return 0;
    
    NSUInteger factorialFrom = [self factorialCountOfGet:from from:from];
    NSUInteger factorialGet = [self factorialCountOfGet:get from:get];
    NSUInteger factorialOther = [self factorialCountOfGet:from-get from:from-get];

    return factorialFrom/(factorialGet*factorialOther);
}


/**
 阶乘计算
 P(get,from) = from*(from-1)*(from-2)...(from-(get-1));
 
 @param get 阶乘等级
 @param from 总共的个数
 @return 阶乘结果
 */
+ (long)factorialCountOfGet:(NSUInteger)get from:(NSUInteger)from
{
    if (get>from) {
        NSLog(@"Error：阶乘计算不合法");
        return 0;
    }
    
    NSUInteger total=1;
    for (NSUInteger i=from; i>from-get; i--) {
        total *= i;
    }
    return total;
}

+ (NSArray *)subArrayFromArray:(NSArray *)originArray length:(NSUInteger)length
{
//    NSUInteger startIndex = 0;
//    NSUInteger endIndex = length-1;
//    for (NSInteger i=endIndex; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
    
    return @[];
}

@end
