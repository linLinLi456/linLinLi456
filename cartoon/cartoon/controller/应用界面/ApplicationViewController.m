//
//  ApplicationViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "ApplicationViewController.h"
#import "ApplicationModel.h"
#import "ApplicationTableViewCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"

@interface ApplicationViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,strong)NSMutableArray *data;


@property (nonatomic,assign) NSInteger page;


@end

@implementation ApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"琳之微漫";
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;

    self.data = [[NSMutableArray alloc] init];
    [self createAFHttpRequest];
    [self firstDownload];
    [self createRefreshView];
}

-(void)createNevagitionItem {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 18);
    [leftBtn setBackgroundImage:[UIImage imageNamed: @"menufragment_"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 18);
    [rightBtn setBackgroundImage:[UIImage imageNamed: @"search_chaozhao"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(void)searchBtnClick {
    SearchViewController *search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)createAFHttpRequest {
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}
-(void)createRefreshView
{
    __weak typeof(self) weakSelf = self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefreshing = YES;
        [weakSelf resetParame];
        NSString *url = [NSString stringWithFormat:kUrl,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadingMore) {
            return;
        }
        weakSelf.isLoadingMore = YES;
        weakSelf.page ++;
        NSString *url = [NSString stringWithFormat:kUrl,weakSelf.page];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
}
-(void)createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
-(void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh
{
    __weak typeof(self) weakSelf = self;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"小猪帮您努力加载中\n耐心等待~" status:@"💗loading💗" image:[UIImage imageNamed: @"fragemt_loading2.png"]];
    BOOL isExit = [[NSFileManager defaultManager] fileExistsAtPath:[LZXHelper getFullPathWithFile:url]];
    BOOL isTimeOut = [LZXHelper isTimeOutWithFile:[LZXHelper getFullPathWithFile:url] timeOut:60*60];
    if ((isExit == YES)&&(isTimeOut == NO)&&(isRefresh == NO)) {
        NSData *data = [NSData dataWithContentsOfFile:[LZXHelper getFullPathWithFile:url]];
        
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in ary) {
            ApplicationModel *model = [[ApplicationModel alloc] init];
            model.comic_title = [dict objectForKey:@"comic_title"];
            model.comic_thumb = [dict objectForKey:@"comic_thumb"];
            model.author_name = [dict objectForKey:@"author_name"];
            model.comic_id = [dict objectForKey:@"comic_id"];
            model.frequency_zan = [dict objectForKey:@"frequency_zan"];
            model.frequency_pinglun = [dict objectForKey:@"frequency_pinglun"];
            model.frequency_fenxiang = [dict objectForKey:@"frequency_fenxiang"];
            model.create_time = [dict objectForKey:@"create_time"];
            [self.data addObject:model];
        }
        [_tableView reloadData];
        [MMProgressHUD dismissWithSuccess:@"ok" title:@"数据下载完"];
        return;
    }
    [weakSelf.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            if (weakSelf.page == 1) {
                [weakSelf.data removeAllObjects];
                [[NSFileManager defaultManager] createFileAtPath:[LZXHelper getFullPathWithFile:url] contents:responseObject attributes:nil];
            }
            NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dict in ary) {
                ApplicationModel *model = [[ApplicationModel alloc] init];
                model.comic_title = [dict objectForKey:@"comic_title"];
                model.comic_thumb = [dict objectForKey:@"comic_thumb"];
                model.author_name = [dict objectForKey:@"author_name"];
                model.comic_id = [dict objectForKey:@"comic_id"];
                model.frequency_zan = [dict objectForKey:@"frequency_zan"];
                model.frequency_pinglun = [dict objectForKey:@"frequency_pinglun"];
                model.frequency_fenxiang = [dict objectForKey:@"frequency_fenxiang"];
                model.create_time = [dict objectForKey:@"create_time"];
                [weakSelf.data addObject:model];
            }
            [_tableView reloadData];
            [weakSelf endRefreshView];
        }
        [MMProgressHUD dismissWithSuccess:@"ok" title:@"网络数据下载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:@"error" title:@"下载失败"];
    }];
}
-(void)firstDownload
{
    self.isRefreshing = NO;
    self.isLoadingMore = NO;
    self.page = 1;
    NSString *url = [NSString stringWithFormat:kUrl,self.page];
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
        [_tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [_tableView footerEndRefreshing];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ApplicationTableViewCell";
    ApplicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplicationTableViewCell" owner:self options:nil] lastObject];
    }
    ApplicationModel *model = self.data[indexPath.row];
    [cell.comicImage sd_setImageWithURL:[NSURL URLWithString:model.comic_thumb] placeholderImage:[UIImage imageNamed: @"img_home_loading0"]];
    cell.name.text = [NSString stringWithFormat:@"作者:%@",model.author_name];
    cell.title.text = model.comic_title;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApplicationModel *model = self.data[indexPath.row];
    DetailViewController *dvc = [[DetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

@end
