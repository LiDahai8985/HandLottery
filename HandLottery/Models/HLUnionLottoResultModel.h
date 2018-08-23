//
//  HLUnionLottoResultModel.h
//  HandLottery
//
//  Created by jrzl on 2018/8/23.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLLottoBonusDetailModel.h"

@interface HLUnionLottoResultModel : NSObject

@property (nonatomic, copy) NSString *lottoId;
@property (nonatomic, copy) NSString *gameId;       // ssq
@property (nonatomic, copy) NSString *lottoName;    // 中文名称
@property (nonatomic, copy) NSString *lottoCode;    // 期数
@property (nonatomic, copy) NSString *lottoDate;    // 开奖日期
@property (nonatomic, copy) NSString *redNum;       // 红球数字
@property (nonatomic, copy) NSString *blueNum;      // 蓝球数字
@property (nonatomic, copy) NSString *salesCount;   // 销售数量
@property (nonatomic, copy) NSString *poolMoney;    // 奖池金额
@property (nonatomic, copy) NSString *content;      // 开奖情况描述
@property (nonatomic, copy) NSString *drawVideoUrl; // 开奖视频地址
@property (nonatomic, copy) NSString *drawLiveUrl;  // 直播开奖地址
@property (nonatomic, strong) NSArray *redBallNums; // 红球号码
@property (nonatomic, strong) NSArray *blueBallNums;// 蓝球号码
@property (nonatomic, strong) NSArray<HLLottoBonusDetailModel *> *bonusDetailList; // 具体中奖明细

@end
