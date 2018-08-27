//
//  HLChartView.m
//  HandLottery
//
//  Created by jrzl on 2018/8/27.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLChartView.h"

#define lineColor  RGBColor(0,0,0,1)


@implementation HLChartView

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray
{
    _dataSourceArray = dataSourceArray;
}

- (void)drawChartLine
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    // y轴
    CAShapeLayer *yLine = [CAShapeLayer layer];
    UIBezierPath *yLinePath = [UIBezierPath bezierPath];
    [yLinePath moveToPoint:CGPointMake(30, 0)];
    [yLinePath addLineToPoint:CGPointMake(30, self.frame.size.height - 30)];
    yLine.path = yLinePath.CGPath;
    yLine.lineWidth = 1;
    yLine.strokeColor = lineColor.CGColor;
    yLine.lineCap = kCALineCapRound;
    [self.layer addSublayer:yLine];
    
    // y轴箭头
    CAShapeLayer *yArrow = [CAShapeLayer layer];
    UIBezierPath *yArrowPath = [UIBezierPath bezierPath];
    [yArrowPath moveToPoint:CGPointMake(30, 0)];
    [yArrowPath addLineToPoint:CGPointMake(27, 10)];
    [yArrowPath addLineToPoint:CGPointMake(30, 8)];
    [yArrowPath addLineToPoint:CGPointMake(33, 10)];
    [yArrowPath closePath];
    yArrow.path = yArrowPath.CGPath;
    yArrow.lineWidth = 1;
    yArrow.fillColor = lineColor.CGColor;
    yArrow.lineCap = kCALineCapRound;
    [self.layer addSublayer:yArrow];
    
    // x轴
    CAShapeLayer *xLine = [CAShapeLayer layer];
    UIBezierPath *xLinePath = [UIBezierPath bezierPath];
    [xLinePath moveToPoint:CGPointMake(30, self.frame.size.height - 30)];
    [xLinePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-30)];
    xLine.path = xLinePath.CGPath;
    xLine.lineWidth = 1;
    xLine.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:xLine];
    
    // x轴箭头
    CAShapeLayer *xArrow = [CAShapeLayer layer];
    UIBezierPath *xArrowPath = [UIBezierPath bezierPath];
    [xArrowPath moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - 30)];
    [xArrowPath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height - 30 - 3)];
    [xArrowPath addLineToPoint:CGPointMake(self.frame.size.width-8, self.frame.size.height - 30)];
    [xArrowPath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height - 30 + 3)];
    [xArrowPath closePath];
    xArrow.path = xArrowPath.CGPath;
    xArrow.lineWidth = 1;
    xArrow.fillColor = lineColor.CGColor;
    xArrow.lineCap = kCALineCapRound;
    [self.layer addSublayer:xArrow];
    
    CGFloat xSpace = (self.frame.size.width-40)/(self.dataSourceArray.count+1);
    CGFloat ySpace = self.frame.size.height - 40;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    
    // 添加柱状图
    for (NSInteger i=0; i<self.dataSourceArray.count; i++) {
        NSDictionary *dataInfoDic = self.dataSourceArray[i];
        //NSString *xValue = dataInfoDic.allKeys.firstObject;
        NSString *yValue = dataInfoDic.allValues.firstObject;
        
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(30 + xSpace*(i+1), self.frame.size.height-30)];
        [linePath addLineToPoint:CGPointMake(30 + xSpace*(i+1), self.frame.size.height-30-(yValue.floatValue/self.maxY)*ySpace)];
        line.path = linePath.CGPath;
        line.strokeStart = 0;
        line.strokeEnd = 1;
        line.strokeColor = RGBColor(110, 120, 220, 0.4).CGColor;
        line.lineWidth = xSpace/2;
        [self.layer addSublayer:line];
        
        [line addAnimation:animation forKey:@"lineAnimation"];
    }
    
}

@end
