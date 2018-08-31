//
//  HLSelectedColorBallModel.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLSelectedColorBallModel.h"

@implementation HLSelectedColorBallModel

- (NSMutableArray *)redNumsArray
{
    if (!_redNumsArray) {
        _redNumsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _redNumsArray;
}

- (NSMutableArray *)blueNumsArray
{
    if (!_blueNumsArray) {
        _blueNumsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _blueNumsArray;
}

@end
