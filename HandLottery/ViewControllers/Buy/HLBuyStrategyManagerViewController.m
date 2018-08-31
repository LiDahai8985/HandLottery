//
//  HLBuyStrategyManagerViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/31.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLBuyStrategyManagerViewController.h"
#import "HLBuyStrategyDetailViewController.h"
#import "HLBuySuperLottoViewController.h"
#import "HLBuyUnionLottoViewController.h"
#import "HLBuyStrategyManagerCell.h"

@interface HLBuyStrategyManagerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *stakesCountLabel;


@end

@implementation HLBuyStrategyManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"已选号码管理";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"预览全部"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(showLargeStrategyNum)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self createSubviews];
}

#pragma mark- UI

- (void)createSubviews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 80, 0));
    }];
    
    UIView *bottomContentView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - 50, Screen_Width - 100, 80)];
    bottomContentView.backgroundColor = RGBColor(240, 240, 240, 1);
    [self.view addSubview:bottomContentView];
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.bottom.equalTo(self.view);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-100);
    }];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_Height-50, 100, 20)];
    self.nameLabel.font = PingFengMedium(14);
    self.nameLabel.textColor = HLBLackColor;
    [bottomContentView addSubview:self.nameLabel];
    self.nameLabel.text = @"当前彩种：大乐透";
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomContentView).offset(8);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(bottomContentView.mas_centerX);
        make.height.mas_equalTo(25);
    }];
    
    self.stakesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_Height-50, 100, 20)];
    self.stakesCountLabel.font = PingFengMedium(14);
    self.stakesCountLabel.textColor = HLBLackColor;
    self.stakesCountLabel.textAlignment = NSTextAlignmentRight;
    [bottomContentView addSubview:self.stakesCountLabel];
    self.stakesCountLabel.text = @"当前已选30注";
    [self.stakesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.right.mas_equalTo(-15);
        make.height.equalTo(self.nameLabel);
    }];
    
    UIButton *random5Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [random5Button setTitle:@"+ 机选5注" forState:UIControlStateNormal];
    random5Button.titleLabel.font = PingFengRegular(14);
    [random5Button setTitleColor:HLDarkGrayColor forState:UIControlStateNormal];
    [random5Button setTitleColor:HLBLackColor forState:UIControlStateHighlighted];
    random5Button.backgroundColor = [UIColor whiteColor];
    random5Button.layer.cornerRadius = 4;
    random5Button.layer.borderColor = HLGrayColor.CGColor;
    random5Button.layer.borderWidth = 0.5;
    [random5Button addTarget:self
                      action:@selector(addRandomSelectHandler:)
            forControlEvents:UIControlEventTouchUpInside];
    [bottomContentView addSubview:random5Button];
    [random5Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.centerX.equalTo(bottomContentView);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    UIButton *random1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [random1Button setTitle:@"+ 机选1注" forState:UIControlStateNormal];
    random1Button.titleLabel.font = PingFengRegular(14);
    [random1Button setTitleColor:HLDarkGrayColor forState:UIControlStateNormal];
    [random1Button setTitleColor:HLBLackColor forState:UIControlStateHighlighted];
    random1Button.backgroundColor = [UIColor whiteColor];
    random1Button.layer.cornerRadius = 4;
    random1Button.layer.borderColor = HLGrayColor.CGColor;
    random1Button.layer.borderWidth = 0.5;
    [random1Button addTarget:self
                      action:@selector(addRandomSelectHandler:)
            forControlEvents:UIControlEventTouchUpInside];
    [bottomContentView addSubview:random1Button];
    [random1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setTitle:@"自选" forState:UIControlStateNormal];
    selectButton.titleLabel.font = PingFengRegular(14);
    [selectButton setTitleColor:HLDarkGrayColor forState:UIControlStateNormal];
    [selectButton setTitleColor:HLBLackColor forState:UIControlStateHighlighted];
    selectButton.backgroundColor = [UIColor whiteColor];
    selectButton.layer.cornerRadius = 4;
    selectButton.layer.borderColor = HLGrayColor.CGColor;
    selectButton.layer.borderWidth = 0.5;
    [selectButton addTarget:self
                      action:@selector(addRandomSelectHandler:)
            forControlEvents:UIControlEventTouchUpInside];
    [bottomContentView addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(random1Button);
        make.right.equalTo(bottomContentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"加入购\n买计划" forState:UIControlStateNormal];
    saveButton.titleLabel.font = PingFengMedium(14);
    saveButton.titleLabel.numberOfLines = 0;
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setTitleColor:HLGrayColor forState:UIControlStateHighlighted];
    saveButton.backgroundColor = HLRedColor;
    [saveButton addTarget:self
                     action:@selector(saveCurrentStrategy)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomContentView);
        make.right.equalTo(self.view);
        make.left.mas_equalTo(bottomContentView.mas_right);
    }];
    
}

- (void)addRandomSelectHandler:(id)sender
{
    
}

- (void)saveCurrentStrategy
{
    
}

- (void)showLargeStrategyNum
{
    HLBuyStrategyDetailViewController *vc = [[HLBuyStrategyDetailViewController alloc] init];
    vc.selectedColorBallsArray = self.dataSourceArray;
    [self.navigationController presentViewController:[[HLNavigationController alloc] initWithRootViewController:vc]
                                            animated:YES
                                          completion:nil];
}


#pragma mark- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLBuyStrategyManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HLBuyStrategyManagerCell class])];
    cell.colorBallModel = self.dataSourceArray[indexPath.row];
    cell.indexPath = indexPath;
    
    __weak typeof(self) weakSelf = self;
    cell.deleteBtnClickHandlerCallBack = ^ (HLSelectedColorBallModel *cellColorModel) {
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:[weakSelf.dataSourceArray indexOfObject:cellColorModel] inSection:0];
        [weakSelf.dataSourceArray removeObject:cellColorModel];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- Setter / Getter

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 60;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HLBuyStrategyManagerCell class]
           forCellReuseIdentifier:NSStringFromClass([HLBuyStrategyManagerCell class])];
    }
    return _tableView;
}


@end
