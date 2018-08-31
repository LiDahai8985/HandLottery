//
//  HLBuyStrategyDetailViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/23.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBuyStrategyDetailViewController.h"

#import "HLSelectedColorBallModel.h"

@interface HLBuyStrategyDetailViewController ()

@property (nonatomic, strong) UILabel *textlabel;

@end

@implementation HLBuyStrategyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购买方案";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(close)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.textlabel = [[UILabel alloc] init];
    self.textlabel.font = PingFengMedium(40);
    self.textlabel.numberOfLines = 0;
    self.textlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textlabel];
    [self.textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    NSString *numsString = @"";
    for (NSInteger i=0; i<self.selectedColorBallsArray.count; i++) {
        HLSelectedColorBallModel *model = self.selectedColorBallsArray[i];
        NSString *redNumsString = [model.redNumsArray componentsJoinedByString:@"  "];
        NSString *blueNumsString = [model.blueNumsArray componentsJoinedByString:@"  "];
        numsString = [NSString stringWithFormat:@"%@\n%@  %@",numsString,redNumsString, blueNumsString];
    }
    self.textlabel.text = [numsString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- UIInterfaceOrientation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    return UIInterfaceOrientationMaskAllButUpsideDown;
    return UIInterfaceOrientationMaskLandscape;
}
@end
