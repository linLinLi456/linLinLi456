//
//  AuthorListViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "AuthorListViewController.h"
#import "AutherListModel.h"
#import "AutherListTableViewCell.h"
#import "ManhuaListViewController.h"

@interface AuthorListViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
}

@property (nonatomic) NSInteger page;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation AuthorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    [self createView];
    [self createAFHttpRequest];
    [self firstDownload];
    [self createRefreshView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图.png"]];
}


-(void)createView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 84, self.view.size.width-40, self.view.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
    label.text = @"作者列表";
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图.png"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.tableView.tableHeaderView =label;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView协议

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AutherListIdentifier";
    AutherListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AutherListTableViewCell" owner:nil options:nil] lastObject];
    }
    AutherListModel *model = self.dataArr[indexPath.row];
//    NSLog(@"model：%@",model);
    cell.contentView.layer.masksToBounds = YES;
    cell.contentView.layer.cornerRadius = 10.f;
    [cell showDataWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma  mark - 创建刷新
-(void)createRefreshView
{
    __weak typeof(self) weakSelf = self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefreshing = YES;
        [weakSelf resetParame];
        NSString *url = [NSString stringWithFormat:kAuthorlist,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadingMore) {
            return;
        }
        weakSelf.isLoadingMore = YES;
        weakSelf.page ++;
        NSString *url = [NSString stringWithFormat:kAuthorlist,weakSelf.page];
//        NSLog(@"url:%@",url);
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
}
-(void)firstDownload
{
    self.isRefreshing = NO;
    self.isLoadingMore = NO;
    self.page = 1;
    NSString *url = [NSString stringWithFormat:kAuthorlist,self.page];
    [self addTaskWithUrl:url isRefresh:NO];
}
-(void)resetParame
{
    self.page = 1;
}
-(void)endRefreshView
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [_tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [_tableView footerEndRefreshing];
    }
}

-(void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh {
    __weak typeof(self) weakSelf = self;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"小猪帮您努力加载中\n耐心等待~" status:@"💗loading💗" image:[UIImage imageNamed: @"fragemt_loading2.png"]];
    BOOL isExit = [[NSFileManager defaultManager] fileExistsAtPath:[LZXHelper getFullPathWithFile:url]];
    BOOL isTimeOut = [LZXHelper isTimeOutWithFile:[LZXHelper getFullPathWithFile:url] timeOut:60*60];
    if ((isExit == YES)&&(isTimeOut == NO)&&(isRefresh == NO)) {
        NSData *data = [NSData dataWithContentsOfFile:[LZXHelper getFullPathWithFile:url]];
        
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in ary) {
            AutherListModel *model = [[AutherListModel alloc] init];
            model.author_figureimg = [dict objectForKey:@"author_figureimg"];
            model.author_jietu = [dict objectForKey:@"author_jietu"];
            model.author_name = [dict objectForKey:@"author_name"];
            model.author_jianjie = [dict objectForKey:@"author_jianjie"];
            [weakSelf.dataArr addObject:model];
        }
        [weakSelf.tableView reloadData];
        [MMProgressHUD dismissWithSuccess:@"ok" title:@"数据下载完成"];
        return;
    }
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            if (weakSelf.page == 1) {
                [weakSelf.dataArr removeAllObjects];
                [[NSFileManager defaultManager] createFileAtPath:[LZXHelper getFullPathWithFile:url] contents:responseObject attributes:nil];
            }
            NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dict in ary) {
                AutherListModel *model = [[AutherListModel alloc] init];
                model.author_figureimg = [dict objectForKey:@"author_figureimg"];
                model.author_jietu = [dict objectForKey:@"author_jietu"];
                model.author_name = [dict objectForKey:@"author_name"];
                if ([model.author_jietu isEqualToString:@"null"]) {
                    [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
//                    [self presentViewController:alert animated:YES completion:nil];
                    return;
                }
//                NSLog(@"model:%@",model);
                [weakSelf.dataArr addObject:model];
//                NSLog(@"data:%@",self.dataArr);
            }
            [weakSelf.tableView reloadData];
        }
        [self endRefreshView];
        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:@"error" title:@"下载失败"];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ManhuaListViewController *manhua = [[ManhuaListViewController alloc] init];
    AutherListModel *model = self.dataArr[indexPath.row];
    manhua.AuthorModel = model;
    [self.navigationController pushViewController:manhua animated:YES];
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
