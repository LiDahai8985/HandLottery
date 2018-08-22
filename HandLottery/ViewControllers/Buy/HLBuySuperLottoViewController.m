//
//  HLBuySuperLottoViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBuySuperLottoViewController.h"
#import "HLLottreyBallCollectionCell.h"
#import "HLBallHeaderReusableView.h"

@interface HLBuySuperLottoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *redDataSourceArray;
@property (nonatomic, strong) NSMutableArray   *blueDataSourceArray;

@end

@implementation HLBuySuperLottoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大乐透";
    self.view.backgroundColor = RGBColor(238, 238, 245, 1);
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
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
