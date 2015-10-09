//
//  CollectViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "CollectViewController.h"

#import "CoreData+MagicalRecord.h"
#import "DetailViewController.h"
#import "Entity.h"
#import "SearchResultTableViewCell.h"


@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.dataArr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"空空如也~~" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }
}
-(void)createView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    NSArray *ary = [Entity MR_findAll];
    [self.dataArr addObjectsFromArray:ary];
    [self.tableView reloadData];
}
-(void)initData {
    self.navigationItem.title = @"我的收藏";
    self.dataArr = [[NSMutableArray alloc] init];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)editClick:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
    } else {
        item.title = @"编辑";
    }
    BOOL isEdit = self.tableView.editing;
    [self.tableView setEditing:!isEdit animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SearchResultCell";
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultTableViewCell" owner:nil options:nil] lastObject];
    }
    Entity *model = self.dataArr[indexPath.row];
    [cell showDataWithModle:(SearchResultModel *)model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Entity *model = self.dataArr[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.id = model.comic_id;
//    detail.homeModel = (ApplicationModel *)model;
    [self.navigationController pushViewController:detail animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Entity *model = self.dataArr[indexPath.row];
    NSArray *arr = [Entity MR_findByAttribute:@"comic_id" withValue:model.comic_id];
    [[NSManagedObjectContext MR_defaultContext] MR_deleteObjects:arr];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
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
