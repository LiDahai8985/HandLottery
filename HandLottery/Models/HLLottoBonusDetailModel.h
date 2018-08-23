//
//  HLLottoBonusDetailModel.h
//  HandLottery
//
//  Created by jrzl on 2018/8/23.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLottoBonusDetailModel : NSObject

@property (nonatomic, copy) NSString *bonusType;   // 奖金类型
@property (nonatomic, copy) NSString *bonusCount;  // 中奖注数
@property (nonatomic, copy) NSString *bonusMoney;  // 单注奖金额

@end
