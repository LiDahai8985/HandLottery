//
//  HLLottreyBallCollectionCell.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLLottreyBallCollectionCell.h"

@interface HLLottreyBallCollectionCell ()

@property (nonatomic, strong) UIButton *ballButton;

@end


@implementation HLLottreyBallCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedTextColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    self.ballButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ballButton.titleLabel.font = PingFengMedium(17);
    self.ballButton.layer.borderColor = RGBColor(180, 180, 180, 1).CGColor;
    [self.ballButton setTitleColor:self.selectedTextColor forState:UIControlStateNormal];
    [self.ballButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.ballButton.layer.borderWidth = 0.5;
    self.ballButton.layer.cornerRadius = 20;
    [self addSubview:self.ballButton];
    [self.ballButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}


- (void)setNumberText:(NSString *)numberText
{
    _numberText = numberText;
    [self.ballButton setTitle:numberText forState:UIControlStateNormal];
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
    [self.ballButton setTitleColor:_selectedTextColor
                          forState:UIControlStateNormal];
}

- (void)setDidSelect:(BOOL)didSelect
{
    _didSelect = didSelect;
    self.ballButton.selected = didSelect;
    self.ballButton.backgroundColor = didSelect?self.selectedTextColor:[UIColor whiteColor];
}
@end
