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
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setBackgroundImage:[self drawImageWithColor:HLRedColor size:CGSizeMake(Screen_Width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[self drawImageWithColor:RGBColor(150, 150, 150, 1) size:CGSizeMake(Screen_Width, 0.5)]];
}

- (UIImage *)drawImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context , CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
