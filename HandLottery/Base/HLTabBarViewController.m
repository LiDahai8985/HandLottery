//
//  HLTabBarViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLTabBarViewController.h"

@interface HLTabBarViewController ()

@end

@implementation HLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *itemsTitlesArray = @[@"购买",@"开奖",@"我的"];
    for (NSInteger i=0; i<itemsTitlesArray.count; i++) {
        NSString *normalImgName = [NSString stringWithFormat:@"tabbar%ld_normal",i+1];
        NSString *selectedImgName = [NSString stringWithFormat:@"tabbar%ld_selected",i+1];
        UIViewController *viewController = self.viewControllers[i];
        viewController.tabBarItem.image = [[UIImage imageNamed:normalImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
//    self.selectedIndex = 1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


#pragma mark- UIInterfaceOrientation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
