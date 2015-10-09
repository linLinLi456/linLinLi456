//
//  SearchResultViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultModel.h"
#import "SearchResultTableViewCell.h"
#import "DetailViewController.h"

@interface SearchResultViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_data;
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) BOOL isLoadingMore;

@property (nonatomic,assign) BOOL isRefreshing;

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic) NSInteger page;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图"]];
    [self createTableView];
    [self createAFHttpRequest];
    [self firstDownload];
    [self createRefreshView];
}
-(void)createAFHttpRequest {
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

-(void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate  =self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
    
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh {
    __weak typeof(self) weakSelf = self;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"小猪帮您努力加载中\n耐心等待~" status:@"💗loading💗" image:[UIImage imageNamed: @"fragemt_loading2.png"]];
    [weakSelf.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            if (weakSelf.page == 1) {
                [weakSelf.data removeAllObjects];
                NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                for (NSDictionary *dict in ary) {
                    SearchResultModel *model = [[SearchResultModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    if ([model.comic_title isEqualToString:@"null"]) {
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
                        label.text = @"没有更多了~~~~(>_<)~~~~ ";
                        label.textAlignment = NSTextAlignmentCenter;
                        [self.tableView.tableFooterView addSubview:label];
                        [weakSelf endRefreshView];
                        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
                        continue;
                    }
                    [weakSelf.data addObject:model];
                }
                [_tableView reloadData];
            } else {
                NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                for (NSDictionary *dict in ary) {
                    SearchResultModel *model = [[SearchResultModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    if ([model.comic_title isEqualToString:@"null"]) {
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
                        label.text = @"没有更多了~~~~(>_<)~~~~ ";
                        label.textAlignment = NSTextAlignmentCenter;
                        [self.tableView.tableFooterView addSubview:label];
                        [weakSelf endRefreshView];
                        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
                        continue;
                    }
                    [weakSelf.data addObject:model];
                }
                [_tableView reloadData];
                [weakSelf endRefreshView];
            }
        }
        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:@"error" title:@"下载失败"];
    }];
}
-(void)createRefreshView
{
    __weak typeof(self) weakSelf = self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefreshing = YES;
        [weakSelf resetParame];
        NSString *str = [weakSelf.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *url = [NSString stringWithFormat:kSearchResult,str,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadingMore) {
            return;
        }
        weakSelf.isLoadingMore = YES;
        weakSelf.page ++;
        NSString *str = [weakSelf.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *url = [NSString stringWithFormat:kSearchResult,str,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
}

-(void)resetParame {
    self.page = 1;
}
-(void)firstDownload {
    self.isRefreshing = NO;
    self.isLoadingMore = NO;
    self.page = 1;
    NSString *str = [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:kSearchResult,str,self.page];
    [self addTaskWithUrl:url isRefresh:NO];
}
-(void)endRefreshView
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [_tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [_tableView footerEndRefreshing];
    }
}

#pragma mark - UITableView协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SearchResultCell";
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultTableViewCell" owner:nil options:nil] lastObject];
    }
    SearchResultModel *model = self.data[indexPath.row];
    [cell showDataWithModle:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    SearchResultModel *model = self.data[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.id = model.comic_id;
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
