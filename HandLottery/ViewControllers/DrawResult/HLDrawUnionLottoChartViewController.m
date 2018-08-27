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
    
    self.redChartView.frame = CGRectMake(10, 94, Screen_Width - 20, (Screen_Height-64)/2 - 60);
    [self.view addSubview:self.redChartView];
    self.redChartView.maxX = 33;
    self.redChartView.maxY = 200;
    self.redChartView.dataSourceArray = self.redInfoArray;
    [self.redChartView drawChartLine];
    
    self.blueChartView.frame = CGRectMake(10, CGRectGetMaxY(self.redChartView.frame)+50, Screen_Width - 20, (Screen_Height-64)/2 - 60);
    [self.view addSubview:self.blueChartView];
    self.blueChartView.maxX = 16;
    self.blueChartView.maxY = 80;
    self.blueChartView.dataSourceArray = self.blueInfoArray;
    [self.blueChartView drawChartLine];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.redChartView drawChartLine];
    [self.blueChartView drawChartLine];
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
