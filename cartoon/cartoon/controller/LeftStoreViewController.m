//
//  LeftStoreViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "LeftStoreViewController.h"
#import "AppDelegate.h"
#import "ShareViewController.h"
#import "AuthorListViewController.h"
#import "ApplicationViewController.h"
#import "CollectViewController.h"
#import "MyViewController.h"

#import "UMSocial.h"

@interface LeftStoreViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@end

@implementation LeftStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"menu_bg"]];
    [self createTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)createView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-130)/2, 50, 80, 80)];
    [imageView setImage:[UIImage imageNamed: @"icon-160"]];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.origin.x+5, 130, imageView.width, 44)];
    label.text = @"琳之微漫";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
}
-(void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.size.width, self.view.size.height-200) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.font =[ UIFont systemFontOfSize:18.f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首页";
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.image = [UIImage imageNamed: @"menufragment_homepage"];
        [cell.contentView addSubview:imageView];
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"作者列表";
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.image = [UIImage imageNamed: @"menufragment_share_author"];
        [cell.contentView addSubview:imageView];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"我的收藏";
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.image = [UIImage imageNamed: @"menufragment_highopinion"];
        [cell.contentView addSubview:imageView];
    } else if (indexPath.row == 3){
        cell.textLabel.text = @"分享好友";
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.image = [UIImage imageNamed: @"menufragment_share"];
        [cell.contentView addSubview:imageView];
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"关于我们";
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.image = [UIImage imageNamed: @"menufragment_concerning"];
        [cell.contentView addSubview:imageView];
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"清除缓存";
        cell.textLabel.textColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        imageView.image = [UIImage imageNamed: @"search_fenxiang"];
        [cell.contentView addSubview:imageView];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPath.row == 0) {
        ApplicationViewController *avc = [[ApplicationViewController alloc] init];
        [delegate.leftSliderVC closeLeftView];
        [delegate.mainNavigationController pushViewController:avc animated:NO];
    } else if (indexPath.row == 1) {
        AuthorListViewController *author = [[AuthorListViewController alloc] init];
        [delegate.leftSliderVC closeLeftView];
        [delegate.mainNavigationController pushViewController:author animated:NO];
    } else if (indexPath.row == 2) {
        CollectViewController *collection = [[CollectViewController alloc] init];
        [delegate.leftSliderVC closeLeftView];
        [delegate.mainNavigationController pushViewController:collection animated:NO];
    } else if (indexPath.row == 3) {
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56020e9c67e58e13e70003e5" shareText:nil shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,nil] delegate:self];
    } else if (indexPath.row == 4) {
        MyViewController *MyView = [[MyViewController alloc] init];
        [delegate.leftSliderVC closeLeftView];
        [delegate.mainNavigationController pushViewController:MyView animated:NO];
    } else if (indexPath.row == 5) {
        //缓存 一般 都是一些 缓存图片 或者 是自己缓存的一些数据
        //SDWebImage  下载图片 会做缓存--->()
        //NSLog(@"%@",NSHomeDirectory());
        //
        NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
        //换算成 M
        CGFloat size = fileSize/1024.0/1024.0;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否要删除缓存" message:[NSString stringWithFormat:@"缓存大小 %.6fM",size] preferredStyle:UIAlertControllerStyleActionSheet];
        [ alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            //删除的时候回调这个block
            //删除 sd 的缓存
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDisk];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
