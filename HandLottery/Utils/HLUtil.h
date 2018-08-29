//
//  HLUtil.h
//  HandLottery
//
//  Created by jrzl on 2018/8/29.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
