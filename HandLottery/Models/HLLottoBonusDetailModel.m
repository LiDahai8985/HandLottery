//
//  HLLottoBonusDetailModel.m
//  HandLottery
//
//  Created by jrzl on 2018/8/23.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLLottoBonusDetailModel.h"

@implementation HLLottoBonusDetailModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"bonusType":@"type",           // 奖金类型
             @"bonusCount":@"typenum",       // 中奖注数
             @"bonusMoney":@"typemoney",     // 单注奖金额
             };
}

@end
