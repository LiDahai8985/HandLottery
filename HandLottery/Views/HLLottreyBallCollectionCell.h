//
//  HLLottreyBallCollectionCell.h
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLottreyBallCollectionCell : UICollectionViewCell

@property (nonatomic, copy)   NSString *numberText;
@property (nonatomic, strong) UIColor  *selectedTextColor;
@property (nonatomic, assign) BOOL     didSelect;

@end
