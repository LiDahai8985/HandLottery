//
//  HLDrawUnionLottoChartViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/27.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLDrawUnionLottoChartViewController.h"
#import "HLChartView.h"

@interface HLDrawUnionLottoChartViewController ()

@property (nonatomic, strong) HLChartView *redChartView;
@property (nonatomic, strong) HLChartView *blueChartView;

@end

@implementation HLDrawUnionLottoChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger totalCount = 0;
    for (NSDictionary *infoDic in self.blueInfoArray) {
        NSInteger times = [[infoDic allValues].firstObject integerValue];
        totalCount += times;
    }
    self.title = [NSString stringWithFormat:@"近%ld期数据统计",totalCount];
    
    self.redChartView.frame = CGRectMake(10, 30, Screen_Width - 20, (Screen_Height-64)/2 - 60);
//    self.redChartView.backgroundColor = RGBColor(220, 220, 220, 1);
    [self.view addSubview:self.redChartView];
    self.redChartView.maxX = 33;
    self.redChartView.maxY = 200;
    self.redChartView.title = @"（红球数据统计）";
    self.redChartView.dataSourceArray = self.redInfoArray;
    
    self.blueChartView.frame = CGRectMake(10, CGRectGetMaxY(self.redChartView.frame)+50, Screen_Width - 20, (Screen_Height-64)/2 - 60);
//    self.blueChartView.backgroundColor = RGBColor(220, 220, 220, 1);
    [self.view addSubview:self.blueChartView];
    self.blueChartView.maxX = 16;
    self.blueChartView.maxY = 80;
    self.blueChartView.title = @"（蓝球数据统计）";
    self.blueChartView.dataSourceArray = self.blueInfoArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.redChartView.didDrawChart) {
        [self.redChartView drawChartLine];
    }
    
    if (!self.blueChartView.didDrawChart) {
        [self.blueChartView drawChartLine];
    }
}

- (HLChartView *)redChartView
{
    if (!_redChartView) {
        _redChartView = [[HLChartView alloc] init];
    }
    return _redChartView;
}

- (HLChartView *)blueChartView
{
    if (!_blueChartView) {
        _blueChartView = [[HLChartView alloc] init];
    }
    return _blueChartView;
}
@end
