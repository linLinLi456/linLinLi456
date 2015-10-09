//
//  ManhuaListViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "ManhuaListViewController.h"
#import "ManhuaListModel.h"
#import "DetailViewController.h"

@interface ManhuaListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UILabel *contentLabel;
}
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic) NSInteger page;

@end

@implementation ManhuaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.AuthorModel) {
        self.author = self.AuthorModel.author_name;
        NSLog(@"%@",self.author);
        self.jianjie = self.AuthorModel.author_jianjie;
        self.image = self.AuthorModel.author_figureimg;
    }
    self.dataArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"背景图.png"]];
    [self createImageView];
    [self createAFHttpRequest];
    [self firstDownload];
    [self createTableView];
    [self createRefreshView];
}
-(void)createView {
    
}
-(void)createTableView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, contentLabel.bottom, self.view.width, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    label.text = @"作品列表";
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图.png"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [self.view addSubview:view];
    [view addSubview:label];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,view.bottom , self.view.width, self.view.height-view.bottom) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图"]];
    [self.view addSubview:self.tableView];
}
-(void)createImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 120)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:[UIImage imageNamed: @"opuslisting_activity_zk"]];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, imageView.bottom, 150, 44)];
    label.text = [NSString stringWithFormat:@"作者:%@",self.author];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:label];
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, label.bottom, self.view.width-20, 0)];
    contentLabel.text = [NSString stringWithFormat:@"简介:%@",self.jianjie];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = [UIFont systemFontOfSize:14.f];
    [contentLabel sizeToFit];
    [self.view addSubview:contentLabel];
}
-(void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh {
    __weak typeof(self) weakSelf = self;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"小猪帮您努力加载中\n耐心等待~" status:@"💗loading💗" image:[UIImage imageNamed: @"fragemt_loading2.png"]];
    NSDictionary *dict = @{@"name":self.author};
    [self.manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
                NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"ary:%@",ary);
                for (NSDictionary *dict in ary) {
                    ManhuaListModel *model = [[ManhuaListModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    if ([model.comic_title isEqualToString:@"null"]) {
                        
                        [weakSelf endRefreshView];
                        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
                        continue;
                    }
                    [weakSelf.dataArr addObject:model];
                }
                [weakSelf.tableView reloadData];
            } else {
                NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"ary:%@",ary);
                for (NSDictionary *dict in ary) {
                    ManhuaListModel *model = [[ManhuaListModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    if ([model.comic_title isEqualToString:@"null"]) {
                        [weakSelf endRefreshView];
                        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
                        continue;
                    }
                    [weakSelf.dataArr addObject:model];
                }
                [weakSelf.tableView reloadData];
                [weakSelf endRefreshView];
            }
        }
        
        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:@"error" title:@"下载失败"];
    }];
}
-(void)firstDownload {
    self.isRefreshing = NO;
    self.isLoadingMore = NO;
    self.page = 1;
    NSString *url = [NSString stringWithFormat:kManhualist,self.page];
    [self addTaskWithUrl:url isRefresh:NO];
}
-(void)createRefreshView {
    __weak typeof(self) weakSelf = self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefreshing = YES;
        [weakSelf resetParame];
        NSString *url = [NSString stringWithFormat:kManhualist,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadingMore) {
            return;
        }
        weakSelf.isLoadingMore = YES;
        weakSelf.page ++;
        NSString *url = [NSString stringWithFormat:kManhualist,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
}
-(void)resetParame
{
    self.page = 1;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ManhuaListModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.comic_title;
    cell.textLabel.textColor = [UIColor grayColor];
   
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ManhuaListModel *model = self.dataArr[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.id = model.comic_id;
//    detail.homeModel = (ApplicationModel *)model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
