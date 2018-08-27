//
//  HLChartView.h
//  HandLottery
//
//  Created by jrzl on 2018/8/27.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLChartView : UIView

@property (nonatomic, assign) NSInteger maxX;
@property (nonatomic, assign) NSInteger maxY;

// @[@{@"01":@"189"},...]
@property (nonatomic, strong) NSMutableArray<NSDictionary<NSNumber *,NSNumber *> *> *dataSourceArray;

// 绘制图表数据
- (void)drawChartLine;
@end
