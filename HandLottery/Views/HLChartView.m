//
//  HLChartView.m
//  HandLottery
//
//  Created by jrzl on 2018/8/27.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLChartView.h"

#define lineColor  RGBColor(30,30,30,1)


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
    [yLinePath addLineToPoint:CGPointMake(30, self.frame.size.height-35)];
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
    
    // y轴标题
    CATextLayer *yTxtLayer = [CATextLayer layer];
    yTxtLayer.frame = CGRectMake(-16, self.frame.size.height/2 - 40, 80, 25);
    yTxtLayer.string = @"号码出现次数";
    yTxtLayer.foregroundColor = lineColor.CGColor;
    yTxtLayer.fontSize = 11;
    yTxtLayer.alignmentMode = kCAAlignmentCenter;
    yTxtLayer.contentsScale = [UIScreen mainScreen].scale;
    yTxtLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
    [self.layer addSublayer:yTxtLayer];
    
    // x轴
    CAShapeLayer *xLine = [CAShapeLayer layer];
    UIBezierPath *xLinePath = [UIBezierPath bezierPath];
    [xLinePath moveToPoint:CGPointMake(30, self.frame.size.height-35)];
    [xLinePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-35)];
    xLine.path = xLinePath.CGPath;
    xLine.lineWidth = 1;
    xLine.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:xLine];
    
    // x轴箭头
    CAShapeLayer *xArrow = [CAShapeLayer layer];
    UIBezierPath *xArrowPath = [UIBezierPath bezierPath];
    [xArrowPath moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-35)];
    [xArrowPath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height-35 - 3)];
    [xArrowPath addLineToPoint:CGPointMake(self.frame.size.width-8, self.frame.size.height-35)];
    [xArrowPath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height-35 + 3)];
    [xArrowPath closePath];
    xArrow.path = xArrowPath.CGPath;
    xArrow.lineWidth = 1;
    xArrow.fillColor = lineColor.CGColor;
    xArrow.lineCap = kCALineCapRound;
    [self.layer addSublayer:xArrow];
    
    // 标题
    CATextLayer *titleTxtLayer = [CATextLayer layer];
    titleTxtLayer.frame = CGRectMake(30, self.frame.size.height - 20, self.frame.size.width-30, 20);
    titleTxtLayer.string = [NSString stringWithFormat:@"%@",self.title];
    titleTxtLayer.foregroundColor = lineColor.CGColor;
    titleTxtLayer.fontSize = 11;
    titleTxtLayer.alignmentMode = kCAAlignmentCenter;
    titleTxtLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:titleTxtLayer];
    
    CGFloat xSpace = (self.frame.size.width-40)/(self.dataSourceArray.count+1);
    CGFloat ySpace = self.frame.size.height - 65;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    
    // 添加柱状图
    for (NSInteger i=0; i<self.dataSourceArray.count; i++) {
        NSDictionary *dataInfoDic = self.dataSourceArray[i];
        NSString *xValue = dataInfoDic.allKeys.firstObject;
        NSString *yValue = dataInfoDic.allValues.firstObject;
        
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(30 + xSpace*(i+1), self.frame.size.height-35)];
        [linePath addLineToPoint:CGPointMake(30 + xSpace*(i+1), self.frame.size.height-45-(yValue.floatValue/self.maxY)*ySpace)];
        line.path = linePath.CGPath;
        line.strokeStart = 0;
        line.strokeEnd = 1;
        line.strokeColor = i%2==0?RGBColor(220, 50, 50, 0.5).CGColor:RGBColor(50, 50, 220, 0.5).CGColor;
        line.lineWidth = xSpace/2;
        [self.layer addSublayer:line];
        
        [line addAnimation:animation forKey:@"lineAnimation"];
        
        // 添加文本
        if (i%2==0) {
            CATextLayer *numTxtLayer = [CATextLayer layer];
            numTxtLayer.frame = CGRectMake(30 + xSpace*(i+1) - xSpace*0.75, self.frame.size.height-35, xSpace*1.5, 25);
            numTxtLayer.string = [NSString stringWithFormat:@"%@",xValue];
            numTxtLayer.foregroundColor = lineColor.CGColor;
            numTxtLayer.fontSize = 11;
            numTxtLayer.alignmentMode = kCAAlignmentCenter;
            numTxtLayer.contentsScale = [UIScreen mainScreen].scale;
            [self.layer addSublayer:numTxtLayer];
        }
    }
}


@end
