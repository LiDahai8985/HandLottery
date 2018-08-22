//
//  HLBallHeaderReusableView.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBallHeaderReusableView.h"

@interface HLBallHeaderReusableView ()

@property (nonatomic, strong) UILabel  *headerTitleLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end


@implementation HLBallHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        self.backgroundColor = RGBColor(238, 238, 245, 1);
    }
    return self;
}

- (void)createSubviews
{
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    self.headerTitleLabel.textColor = RGBColor(90, 90, 90, 1);
    self.headerTitleLabel.font = PingFengMedium(16);
    [self addSubview:self.headerTitleLabel];
    [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 0, 10));
    }];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setTitle:@"机选" forState:UIControlStateNormal];
    [self.rightButton addTarget:self
                         action:@selector(randomButtonClickHandler:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:RGBColor(90, 90, 90, 1) forState:UIControlStateNormal];
    [self.rightButton setTitleColor:RGBColor(50, 50, 50, 1) forState:UIControlStateHighlighted];
    self.rightButton.titleLabel.font = PingFengRegular(13);
    self.rightButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.layer.borderColor = RGBColor(180, 180, 180, 1).CGColor;
    self.rightButton.layer.borderWidth = 0.5;
    self.rightButton.layer.cornerRadius = 11;
    [self addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerTitleLabel.mas_centerY);
        make.right.mas_equalTo(self.headerTitleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
}

// 机选按钮事件
- (void)randomButtonClickHandler:(id)sender
{
    __weak typeof(self) weakSelf = self;
    if (self.randomSelectHandler) {
        self.randomSelectHandler(weakSelf.sectionIndex);
    }
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle = headerTitle;
    self.headerTitleLabel.text = headerTitle;
}

@end
