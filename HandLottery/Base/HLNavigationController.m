//
//  HLNavigationController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLNavigationController.h"
#import "HLBaseViewController.h"

@interface HLNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}


#pragma mark- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count > 1) {
        HLBaseViewController *topViewController = self.viewControllers.lastObject;
        return topViewController.canInteractivePopGesture;
    }
    
    return NO;
}


#pragma mark-
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
