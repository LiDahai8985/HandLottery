//
//  HLBuySuperLottoViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBuySuperLottoViewController.h"
#import "HLBuyStrategyManagerViewController.h"

#import "HLLottreyBallCollectionCell.h"
#import "HLBallHeaderReusableView.h"

#import "HLSelectedColorBallModel.h"


@interface HLBuySuperLottoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *redDataSourceArray;
@property (nonatomic, strong) NSMutableArray   *blueDataSourceArray;
@property (nonatomic, strong) UILabel          *selectedContentLabel;

@end

@implementation HLBuySuperLottoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大乐透";
    self.view.backgroundColor = RGBColor(238, 238, 245, 1);
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(commit)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    [self updateSelectedContent];
    [self.view addSubview:self.selectedContentLabel];
    [self.selectedContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.left.mas_equalTo(10);
        make.bottom.equalTo(self.view);
    }];
    
    UIButton *random5Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [random5Button setTitle:@"机选5注" forState:UIControlStateNormal];
    random5Button.titleLabel.font = PingFengRegular(14);
    [random5Button setTitleColor:RGBColor(90, 90, 90, 1) forState:UIControlStateNormal];
    [random5Button setTitleColor:RGBColor(50, 50, 50, 1) forState:UIControlStateHighlighted];
    random5Button.layer.cornerRadius = 14;
    random5Button.layer.borderColor = RGBColor(180, 180, 180, 1).CGColor;
    random5Button.layer.borderWidth = 0.5;
    [random5Button addTarget:self
                      action:@selector(randome5SelectHandler)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:random5Button];
    [random5Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectedContentLabel);
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 28));
    }];
}

#pragma mark-

- (void)randome5SelectHandler
{
    // 机选五注
    NSArray *random5NumsArray = [HLUtil randomNumWithTotalCount:5
                                                       redRange:NSMakeRange(5, 35)
                                                      blueRange:NSMakeRange(2, 12)
                                                    sourceArray:nil];
    
    HLBuyStrategyManagerViewController *vc = [[HLBuyStrategyManagerViewController alloc] init];
    [vc.dataSourceArray addObjectsFromArray:random5NumsArray];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)commit
{
    if (self.redDataSourceArray.count<5) {
        NSLog(@"请至少选择5个红球");
        return;
    }
    
    if (self.blueDataSourceArray.count<2) {
        NSLog(@"请至少选择2个蓝球");
        return;
    }
    
    HLSelectedColorBallModel *ballModel = [[HLSelectedColorBallModel alloc] init];
    [ballModel.redNumsArray addObjectsFromArray:self.redDataSourceArray];
    [ballModel.redNumsArray addObjectsFromArray:self.blueDataSourceArray];
    
    HLBuyStrategyManagerViewController *vc = [[HLBuyStrategyManagerViewController alloc] init];
    [vc.dataSourceArray addObject:ballModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateSelectedContent
{
    NSInteger selectedCount = HLCount(5, self.redDataSourceArray.count)*HLCount(2, self.blueDataSourceArray.count);
    NSString *normalString = [NSString stringWithFormat:@"已选%ld注",selectedCount];
    NSDictionary *normalAttribute = @{NSFontAttributeName:PingFengMedium(14),
                                      NSForegroundColorAttributeName:RGBColor(0, 0, 0, 1)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:normalString
                                                                                    attributes:normalAttribute];
    [attributedString setAttributes:@{NSFontAttributeName:PingFengMedium(17),
                                      NSForegroundColorAttributeName:HLRedColor}
                              range:NSMakeRange(2, normalString.length-3)];
    self.selectedContentLabel.attributedText = attributedString;
}

#pragma mark- UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section==0?35:12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HLLottreyBallCollectionCell *ballCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HLLottreyBallCollectionCell class]) forIndexPath:indexPath];
    
    ballCell.selectedTextColor = indexPath.section==0?HLRedColor:HLBlueColor;
    ballCell.numberText = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (indexPath.section==0) {
        ballCell.didSelect = [self.redDataSourceArray containsObject:@(indexPath.item+1)];
    } else {
        ballCell.didSelect = [self.blueDataSourceArray containsObject:@(indexPath.item+1)];
    }
    
    return ballCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Screen_Width - 6*10 - 2*10)/7, (Screen_Width - 6*10 - 2*10)/7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 20, 10);
}

// 上下行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

// 水平行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HLBallHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                              withReuseIdentifier:NSStringFromClass([HLBallHeaderReusableView class]) forIndexPath:indexPath];
    headerView.headerTitle = indexPath.section==0?@" 至少选择5个红球":@" 至少选择2个篮球";
    headerView.sectionIndex = indexPath.section;
    
    __weak typeof(self) weakSelf = self;
    headerView.randomSelectHandler = ^ (NSInteger sectionIndex) {
        
        // 机选5个红球
        if (sectionIndex == 0) {
            [weakSelf.redDataSourceArray removeAllObjects];
            for (NSInteger i=0; i<5; i++) {
                NSInteger randomNum = arc4random()%35 + 1;
                if (![weakSelf.redDataSourceArray containsObject:@(randomNum)]) {
                    [weakSelf.redDataSourceArray addObject:@(randomNum)];
                } else {
                    i --;
                }
            }
        }
        // 机选2个蓝球
        else {
            [weakSelf.blueDataSourceArray removeAllObjects];
            for (NSInteger i=0; i<2; i++) {
                NSInteger randomNum = arc4random()%12 + 1;
                if (![weakSelf.blueDataSourceArray containsObject:@(randomNum)]) {
                    [weakSelf.blueDataSourceArray addObject:@(randomNum)];
                } else {
                    i --;
                }
            }
        }
        [UIView performWithoutAnimation:^{
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
        }];
        
        [weakSelf updateSelectedContent];
    };
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.redDataSourceArray containsObject:@(indexPath.item+1)]) {
            [self.redDataSourceArray removeObject:@(indexPath.item+1)];
        } else {
            [self.redDataSourceArray addObject:@(indexPath.item+1)];
        }
    } else {
        if ([self.blueDataSourceArray containsObject:@(indexPath.item+1)]) {
            [self.blueDataSourceArray removeObject:@(indexPath.item+1)];
        } else {
            [self.blueDataSourceArray addObject:@(indexPath.item+1)];
        }
    }
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self updateSelectedContent];
}

#pragma mark- Setter / Getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)
                                             collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[HLLottreyBallCollectionCell class]
            forCellWithReuseIdentifier:NSStringFromClass([HLLottreyBallCollectionCell class])];
        [_collectionView registerClass:[HLBallHeaderReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:NSStringFromClass([HLBallHeaderReusableView class])];
    }
    return _collectionView;
}

- (UILabel *)selectedContentLabel
{
    if (!_selectedContentLabel) {
        _selectedContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_Height - 50, 100, 50)];
        _selectedContentLabel.font = PingFengMedium(14);
        _selectedContentLabel.backgroundColor = [UIColor clearColor];
    }
    return _selectedContentLabel;
}

- (NSMutableArray *)redDataSourceArray
{
    if (!_redDataSourceArray) {
        _redDataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _redDataSourceArray;
}

- (NSMutableArray *)blueDataSourceArray
{
    if (!_blueDataSourceArray) {
        _blueDataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _blueDataSourceArray;
}

@end
