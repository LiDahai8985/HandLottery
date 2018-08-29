//
//  HLUnionLottoResultModel.m
//  HandLottery
//
//  Created by jrzl on 2018/8/23.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLUnionLottoResultModel.h"

@implementation HLUnionLottoResultModel

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist
{
    return @[@"redBallNums",@"blueBallNums"];
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"lottoId":@"id",           // id
             @"gameId":@"gameid",        // ssq
             @"lottoName":@"name",       // 中文名称
             @"lottoCode":@"code",       // 期数
             @"lottoDate":@"date",       // 开奖日期
             @"redNum":@"red",           // 红球数字
             @"blueNum":@"blue",        // 蓝球数字
             @"salesCount":@"sales",     // 销售数量
             @"poolMoney":@"poolmoney",  // 奖池金额
             @"content":@"content",      // 开奖情况描述
             @"drawVideoUrl":@"mp4path", // 开奖视频地址
             @"drawLiveUrl":@"m3u8path", // 直播开奖
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"bonusDetailList":[HLLottoBonusDetailModel class]};
}


- (void)setRedNum:(NSString *)redNum
{
    _redNum = redNum;
    // 升序排列
    NSArray *redNums = [[redNum componentsSeparatedByString:@","] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    self.redBallNums = redNums;
}

- (void)setBlueNum:(NSString *)blueNum
{
    _blueNum = blueNum;
    NSArray *blueNums = [blueNum componentsSeparatedByString:@","];
    self.redBallNums = blueNums;
}

@end
