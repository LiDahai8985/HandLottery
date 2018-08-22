//
//  HLBallHeaderReusableView.h
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLBallHeaderReusableView : UICollectionReusableView

@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, copy)   NSString *headerTitle;
@property (nonatomic, copy)   void (^(randomSelectHandler))(NSInteger);

@end
