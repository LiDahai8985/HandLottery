//
//  HLBuyStrategyManagerCell.h
//  HandLottery
//
//  Created by jrzl on 2018/8/31.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSelectedColorBallModel.h"

@interface HLBuyStrategyManagerCell : UITableViewCell

@property (nonatomic, strong) HLSelectedColorBallModel *colorBallModel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^(deleteBtnClickHandlerCallBack))(HLSelectedColorBallModel *);

@end
