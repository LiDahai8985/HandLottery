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
    NSUInteger totoalCount = originArray.count;
    
    for (NSInteger i=0; i<totoalCount; i++) {
        
    }
    
    return @[];
}


+ (NSArray *)randomNumWithTotalCount:(NSInteger)total
                            redRange:(NSRange)redRange
                           blueRange:(NSRange)blueRange
                         sourceArray:(NSArray *)sourceArray

{
    NSMutableArray *randomNumsArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=0; i<total; i++) {
        
        HLSelectedColorBallModel *newColorBallModel = [[HLSelectedColorBallModel alloc] init];
        // 选择红球
        for (NSInteger j=0; j<redRange.location; j++) {
            NSInteger randomNum = arc4random()%redRange.length + 1;
            NSString *randomNumStr = [NSString stringWithFormat:@"%02ld",randomNum];
            if (![newColorBallModel.redNumsArray containsObject:randomNumStr]) {
                [newColorBallModel.redNumsArray addObject:randomNumStr];
            } else {
                j --;
            }
        }
        // 红球排序
        [newColorBallModel.redNumsArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        // 选择蓝球
        // 选择蓝球
        for (NSInteger j=0; j<blueRange.location; j++) {
            NSInteger randomNum = arc4random()%blueRange.length + 1;
            NSString *randomNumStr = [NSString stringWithFormat:@"%02ld",randomNum];
            if (![newColorBallModel.blueNumsArray containsObject:randomNumStr]) {
                [newColorBallModel.blueNumsArray addObject:randomNumStr];
            } else {
                j --;
            }
        }
        // 蓝球排序
        [newColorBallModel.blueNumsArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        // 判断是否已存在
        __block BOOL didContaint = NO;
        dispatch_apply(sourceArray.count, dispatch_get_global_queue(0, 0), ^(size_t t) {
            HLSelectedColorBallModel *oldColorBallModel = [sourceArray objectAtIndex:t];
            if ([oldColorBallModel.redNumsArray isEqualToArray:newColorBallModel.redNumsArray] && [oldColorBallModel.blueNumsArray isEqualToArray:newColorBallModel.blueNumsArray]) {
                didContaint = YES;
            }
        });
        
        // 已存在则重新生成
        if (didContaint) {
            i -= 1;
        } else {
            [randomNumsArray addObject:newColorBallModel];
        }
    }
    return randomNumsArray;
}


@end
