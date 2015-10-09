//
//  SearchViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import "SearchView.h"
#import "SearchResultModel.h"
#import "SearchResultTableViewCell.h"
#import "SearchResultViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_data;
    AFHTTPRequestOperationManager *_manager;
    UISearchBar *_searchBar;
}
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UISearchController *searchVC;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图"]];
    [self createAFHttpRequest];
    [self getNetData];
    [self createTableView];
}
-(void)createAFHttpRequest {
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

-(void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索作者名、作品名";
    self.tableView.tableHeaderView = _searchBar;
    self.tableView.tableFooterView = [[UIView alloc] init];
}
-(void)getNetData {
    __weak typeof(self) weakSelf = self;
    [weakSelf.manager GET:kSearch parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary *dict in ary) {
                SearchModel *model = [[SearchModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.dataArr addObject:model];
                NSLog(@"model:%@",model);
            }
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark - UISearchBar
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *text = searchBar.text;
    SearchResultViewController *result = [[SearchResultViewController alloc] init];
    result.name = text;
    [self.navigationController pushViewController:result animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView协议

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SearchModel *model = self.dataArr[indexPath.row];
   
    cell.textLabel.text = model.search;
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchModel *model = self.dataArr[indexPath.row];
    SearchResultViewController *result = [[SearchResultViewController alloc] init];
    result.name = model.search;
    _searchBar.text = model.search;
//    [self.view.window.rootViewController presentViewController:result animated:YES completion:nil];
    [self.navigationController pushViewController:result animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.width, 44)];
    label.text = @"推荐漫画";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图"]];
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
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
