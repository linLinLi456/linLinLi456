//
//  DetailViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentModel.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import "CommentTableViewCell.h"
#import "MiddleTableViewCell.h"
#import "Comic_DetailModel.h"
#import "ManhuaListViewController.h"
#import "ApplicationViewController.h"
#import "Entity.h"
#import "CoreData+MagicalRecord.h"

#import "UMSocial.h"
#import <MessageUI/MessageUI.h>

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,MiddleTableViewCellDelegate,UMSocialUIDelegate>
{
    UITableView *_tableView;
    UIButton *rightBtn;
}
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,strong) NSMutableArray *dataComment;

@property (nonatomic,strong) NSArray *imagesArr;

@property (nonatomic) NSInteger Height;

@property (nonatomic) NSInteger count;

@property (nonatomic,copy) NSString *navigationTitle;

@property (nonatomic) BOOL isCollected;

@end

@implementation DetailViewController

-(void)showViewWithId:(NSString *)pid {
    self.id = pid;
    if ([self.id isEqualToString:@"null"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"亲，没有更多了哟~" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self getUrlWithId:self.id];
}
-(DetailViewController *)initWithModel:(ApplicationModel *)model {
    if (self = [super init]) {
        self.homeModel = model;
        self.id = self.homeModel.comic_id;
        [self getUrlWithId:self.id];
    }
    return self;
}
-(void)getUrlWithId:(NSString *)pid {
    NSString *url = [NSString stringWithFormat:kManhuadetail,pid];
    [self getNetDataWithUrl:url];
    NSString *commentUrl = [NSString stringWithFormat:kCommentlist,pid];
    [self getCommentDataWithUrl:commentUrl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAFNetWork];
    [self createTableView];
    [self getUrlWithId:self.id];
    [self createNavigationItemTitle];
    self.isCollected = NO;
}
-(void)createNavigationItemTitle {
    self.navigationItem.title = self.navigationTitle;
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    NSArray *titles = @[@"收藏",@"分享"];
    NSMutableArray *buttonArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i < titles.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"详情-%@",titles[i]];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        button.tag = 101+i;
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArr addObject:button];
    }
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (UIView *view in buttonArr) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        [items addObject:item];
    }
     self.navigationItem.rightBarButtonItems = items;
}
-(void)btnClick:(UIButton *)button {
    switch (button.tag) {
        case 101://收藏
        {
            [self collectCartoon];
        }
            break;
         case 102://分享
        {
            [self sharedCartoon];
        }
            break;
        default:
            break;
    }
}
-(void)sharedCartoon {
     [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56020e9c67e58e13e70003e5" shareText:nil shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,nil] delegate:self];
}
-(void)collectCartoon {
    NSArray *ary = [Entity MR_findByAttribute:@"comic_id" withValue:self.id];
    NSLog(@"%@",ary);
    if (ary.count) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"亲，已经收藏过了哟~" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    Entity *model = [Entity MR_createEntity];
    self.DetailModel = self.data[0];
    model.comic_id = self.id;
    model.comic_thumb = self.DetailModel.share_imgurl;
    model.comic_title = self.DetailModel.share_title;
    model.author_name = self.DetailModel.author_name;
    model.frequency_zan = self.DetailModel.frequency_zan;
    model.create_time = self.DetailModel.author_createtime;
    model.frequency_pinglun = self.DetailModel.frequency_pinglun;
    model.frequency_fenxiang = self.DetailModel.frequency_fenxiang;
    model.isCollected = @(1);
    self.isCollected = model.isCollected;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(void)createAFNetWork {
    self.data = [[NSMutableArray alloc] init];
    self.dataComment = [[NSMutableArray alloc] init];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}
-(void)getNetDataWithUrl:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf.data removeAllObjects];
        DetailModel *model = [[DetailModel alloc] initWithData:responseObject error:nil];
        weakSelf.imagesArr = model.comic_datail;
        self.navigationItem.title = model.share_title;
        
        [weakSelf.data addObject:model];
        
        NSLog(@"data:%ld",weakSelf.data.count);
        [_tableView reloadData];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)getCommentDataWithUrl:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf.dataComment removeAllObjects];
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *Dict in ary) {
            CommentModel *model = [[CommentModel alloc] init];
            [model setValuesForKeysWithDictionary:Dict];
            [weakSelf.dataComment addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataComment.count && self.imagesArr.count) {
        return self.dataComment.count+self.imagesArr.count+1;
    }
    return self.dataComment.count+self.imagesArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= self.imagesArr.count-1) {
        static NSString *identifier = @"ImageIdentifier";
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        Comic_DetailModel *model = self.imagesArr[indexPath.row];
        [cell initWithModel:model];
        return cell;
    } else if(indexPath.row == self.imagesArr.count) {
        
        static NSString *detailIdentifier = @"detailIdentifier";
        MiddleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MiddleTableViewCell" owner:nil options:nil] lastObject];
            cell.block = ^(NSString *name,NSString *jianjie,NSString *image_url){
                ManhuaListViewController *manhua = [[ManhuaListViewController alloc] init];
                manhua.author = name;
                manhua.jianjie = jianjie;
                manhua.image = image_url;
                [self.navigationController pushViewController:manhua animated:YES];
            };
        }
        cell.delegate = self;
        DetailModel *model = self.data[indexPath.row-self.imagesArr.count];
        [cell showDataWithModel:model];
        return cell;
        
    } else {
        static NSString *commentIdentifier = @"commentIdentifier";
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:nil options:nil] lastObject];
        }
        CommentModel *model = self.dataComment[indexPath.row-self.imagesArr.count-1];
        [cell setDataToCellWithModel:model];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.count = 0;
    if (indexPath.row  <= self.imagesArr.count-1) {
        Comic_DetailModel *model = self.imagesArr[indexPath.row];
        self.Height = [model.height integerValue];
        self.count++;
        return self.Height;
    } else if (indexPath.row == self.imagesArr.count) {
        return 239;
    } else {
        return 70;
    }
}

@end





















