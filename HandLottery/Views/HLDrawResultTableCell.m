//
//  HLDrawResultTableCell.m
//  HandLottery
//
//  Created by jrzl on 2018/8/23.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLDrawResultTableCell.h"

@interface HLDrawResultTableCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *firstBallLabel;
@property (nonatomic, strong) UILabel *secondBallLabel;
@property (nonatomic, strong) UILabel *thirdBallLabel;
@property (nonatomic, strong) UILabel *fourthBallLabel;
@property (nonatomic, strong) UILabel *fifthBallLabel;
@property (nonatomic, strong) UILabel *sixthBallLabel;
@property (nonatomic, strong) UILabel *seventhBallLabel;

@end



@implementation HLDrawResultTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createSubviews
{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 25)];
    self.nameLabel.font = PingFengMedium(14);
    self.nameLabel.textColor = RGBColor(30, 30, 30, 1);
    [self addSubview:self.nameLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 240, 25)];
    self.dateLabel.font = PingFengRegular(13);
    self.dateLabel.textColor = RGBColor(80, 80, 80, 1);
    [self addSubview:self.dateLabel];
    
    self.firstBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 40)];
    self.firstBallLabel.font = PingFengRegular(15);
    self.firstBallLabel.textAlignment = NSTextAlignmentCenter;
    self.firstBallLabel.backgroundColor = HLRedColor;
    self.firstBallLabel.textColor = [UIColor whiteColor];
    self.firstBallLabel.layer.cornerRadius = 20;
    self.firstBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.firstBallLabel];
    
    self.secondBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.firstBallLabel.frame)+10, 40, 40, 40)];
    self.secondBallLabel.font = PingFengRegular(15);
    self.secondBallLabel.textAlignment = NSTextAlignmentCenter;
    self.secondBallLabel.backgroundColor = HLRedColor;
    self.secondBallLabel.textColor = [UIColor whiteColor];
    self.secondBallLabel.layer.cornerRadius = 20;
    self.secondBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.secondBallLabel];
    
    self.thirdBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.secondBallLabel.frame)+10, 40, 40, 40)];
    self.thirdBallLabel.font = PingFengRegular(15);
    self.thirdBallLabel.textAlignment = NSTextAlignmentCenter;
    self.thirdBallLabel.backgroundColor = HLRedColor;
    self.thirdBallLabel.textColor = [UIColor whiteColor];
    self.thirdBallLabel.layer.cornerRadius = 20;
    self.thirdBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.thirdBallLabel];
    
    self.fourthBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.thirdBallLabel.frame)+10, 40, 40, 40)];
    self.fourthBallLabel.font = PingFengRegular(15);
    self.fourthBallLabel.textAlignment = NSTextAlignmentCenter;
    self.fourthBallLabel.backgroundColor = HLRedColor;
    self.fourthBallLabel.textColor = [UIColor whiteColor];
    self.fourthBallLabel.layer.cornerRadius = 20;
    self.fourthBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.fourthBallLabel];
    
    self.fifthBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fourthBallLabel.frame)+10, 40, 40, 40)];
    self.fifthBallLabel.font = PingFengRegular(15);
    self.fifthBallLabel.textAlignment = NSTextAlignmentCenter;
    self.fifthBallLabel.backgroundColor = HLRedColor;
    self.fifthBallLabel.textColor = [UIColor whiteColor];
    self.fifthBallLabel.layer.cornerRadius = 20;
    self.fifthBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.fifthBallLabel];
    
    self.sixthBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fifthBallLabel.frame)+10, 40, 40, 40)];
    self.sixthBallLabel.font = PingFengRegular(15);
    self.sixthBallLabel.textAlignment = NSTextAlignmentCenter;
    self.sixthBallLabel.backgroundColor = HLRedColor;
    self.sixthBallLabel.textColor = [UIColor whiteColor];
    self.sixthBallLabel.layer.cornerRadius = 20;
    self.sixthBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.sixthBallLabel];
    
    self.seventhBallLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sixthBallLabel.frame)+10, 40, 40, 40)];
    self.seventhBallLabel.font = PingFengRegular(15);
    self.seventhBallLabel.textAlignment = NSTextAlignmentCenter;
    self.seventhBallLabel.backgroundColor = HLBlueColor;
    self.seventhBallLabel.textColor = [UIColor whiteColor];
    self.seventhBallLabel.layer.cornerRadius = 20;
    self.seventhBallLabel.layer.masksToBounds = YES;
    [self addSubview:self.seventhBallLabel];
    
}

- (void)setResultModel:(HLUnionLottoResultModel *)resultModel
{
    _resultModel = resultModel;
    
    self.nameLabel.text = resultModel.lottoName;
    self.dateLabel.text = [NSString stringWithFormat:@"第%@期  开奖日期:%@",resultModel.lottoCode,resultModel.lottoDate];
    
    self.firstBallLabel.text = resultModel.redBallNums[0];
    self.secondBallLabel.text = resultModel.redBallNums[1];
    self.thirdBallLabel.text = resultModel.redBallNums[2];
    self.fourthBallLabel.text = resultModel.redBallNums[3];
    self.fifthBallLabel.text = resultModel.redBallNums[4];
    self.sixthBallLabel.text = resultModel.redBallNums[5];
    self.seventhBallLabel.text = resultModel.blueNum;
}

@end
