//
//  HLBuyViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBuyViewController.h"

#import "HLBuySuperLottoViewController.h"
#import "HLBuyUnionLottoViewController.h"

@interface HLBuyViewController ()



@end

@implementation HLBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"购买";
}

- (IBAction)buySuperLottoHandler:(id)sender
{
    [HLRequestManager query_superLottoResultWithLastTerm:@"18080" pageCount:20];
//    HLBuySuperLottoViewController *vc = [[HLBuySuperLottoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)buyUnionLottoHandler:(id)sender
{
    [HLRequestManager query_unionLottoResultWithLotteryWithPage:1];
//    HLBuyUnionLottoViewController *vc = [[HLBuyUnionLottoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
