//
//  HLDrawResultViewController.m
//  HandLottery
//
//  Created by jrzl on 2018/8/20.
//  Copyright © 2018年 jrzl. All rights reserved.
//

#import "HLDrawResultViewController.h"
#import "HLDrawResultTableCell.h"

@interface HLDrawResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) NSInteger      currentPage;

@end

@implementation HLDrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"开奖";
    self.currentPage = 1;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLDrawResultTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HLDrawResultTableCell class])];
    cell.resultModel = self.dataSourceArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
#pragma mark- Network
- (void)requestUnionLottHistoryMore:(BOOL)more
{
    if (!more) {
        self.currentPage = 1;
    }
    [HLRequestManager query_unionLottoResultWithLotteryWithPage:self.currentPage
                                                        success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                                            NSArray *list = [responseObject objectForKey:@"result"];
                                                            if (!more) {
                                                                [self.dataSourceArray removeAllObjects];
                                                            } else {
                                                                self.currentPage ++;
                                                            }
                                                            for (NSInteger i=0; i<list.count; i++) {
                                                                HLUnionLottoResultModel *model = [HLUnionLottoResultModel yy_modelWithJSON:list[i]];
                                                                [self.dataSourceArray addObject:model];
                                                            }
                                                            [self.tableView.mj_header endRefreshing];
                                                            [self.tableView.mj_footer endRefreshing];
                                                            self.tableView.mj_footer.hidden = list.count<20?YES:NO;
                                                            [self.tableView reloadData];
                                                        } failure:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                                            [self.tableView.mj_header endRefreshing];
                                                            [self.tableView.mj_footer endRefreshing];
                                                        }];
}

#pragma mark- Setter/Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestUnionLottHistoryMore:NO];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestUnionLottHistoryMore:YES];
        }];
        _tableView.mj_footer.hidden = YES;
        [_tableView registerClass:[HLDrawResultTableCell class]
           forCellReuseIdentifier:NSStringFromClass([HLDrawResultTableCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSourceArray
{
    if(!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}
@end
