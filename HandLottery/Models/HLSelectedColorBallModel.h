//
//  HLSelectedColorBallModel.h
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLSelectedColorBallModel : NSObject

@property (nonatomic, strong) NSMutableArray *redNumsArray;    // 已选的红球号码
@property (nonatomic, strong) NSMutableArray *blueNumsArray;   // 已选的蓝球号码

@end
