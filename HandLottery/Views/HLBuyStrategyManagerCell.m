//
//  HLBuyStrategyManagerCell.m
//  HandLottery
//
//  Created by jrzl on 2018/8/31.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBuyStrategyManagerCell.h"

@interface HLBuyStrategyManagerCell ()

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel  *numTxtLabel;

@end



@implementation HLBuyStrategyManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self
                           action:@selector(deleteBtnClickHandler:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(60);
        }];
        
        self.numTxtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Screen_Width - 60, 30)];
        self.numTxtLabel.font = PingFengMedium(16);
        self.numTxtLabel.numberOfLines = 0;
        [self addSubview:self.numTxtLabel];
        [self.numTxtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.deleteBtn.mas_right);
            make.right.equalTo(self).offset(-20);
            make.top.mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return self;
}


- (void)deleteBtnClickHandler:(id)sender
{
    if (self.deleteBtnClickHandlerCallBack) {
        self.deleteBtnClickHandlerCallBack(self.colorBallModel);
    }
}

- (void)setColorBallModel:(HLSelectedColorBallModel *)colorBallModel
{
    _colorBallModel = colorBallModel;
    
    NSString *redNumString = [colorBallModel.redNumsArray componentsJoinedByString:@"  "];
    NSString *blueNumsString = [colorBallModel.blueNumsArray componentsJoinedByString:@"  "];
    NSString *allNumsString = [NSString stringWithFormat:@"%@  %@",redNumString,blueNumsString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:allNumsString
                                                                                         attributes:@{
                                                                                                      NSFontAttributeName:PingFengMedium(20),
                                                                                                      NSForegroundColorAttributeName:HLRedColor
                                                                                                      }];
    [attributedString setAttributes:@{
                                      NSFontAttributeName:PingFengMedium(20),
                                      NSForegroundColorAttributeName:HLBlueColor
                                      }
                              range:NSMakeRange(redNumString.length+2, blueNumsString.length)];
    
    self.numTxtLabel.attributedText = attributedString;
}
@end
