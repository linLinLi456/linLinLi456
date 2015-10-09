//
//  BeginOpenViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "BeginOpenViewController.h"

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "LeftStoreViewController.h"
#define kCellId @"UICollectionViewCell"

@interface BeginOpenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation BeginOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollectionView];
}
-(void)createCollectionView {
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"splash0",@"splash1",@"splash2",nil];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = kScreenSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    [self.view addSubview:self.collectionView];
    //注册 cell 需要注册
    [self.collectionView registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:kCellId];
    //按页滚动
    self.collectionView.pagingEnabled = YES;
}
#pragma mark - 协议方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    //设置背景
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.dataArr[indexPath.row]]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArr.count-1) {
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSArray *vcNames = @[@"ApplicationViewController",@"AuthorListViewController",@"CollectViewController",@"ShareViewController",@"MyViewController",@"BeginViewController"];
        for (NSInteger i = 0; i<vcNames.count; i++) {
            Class vcClass = NSClassFromString(vcNames[i]);
            BaseViewController *vc= [[vcClass alloc] init];
            delegate.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [delegate.mainNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"HPBannerBottomMask"] forBarMetrics:UIBarMetricsDefault];
            LeftStoreViewController *leftVC = [[LeftStoreViewController alloc] init];
            delegate.leftSliderVC = [[LeftViewController alloc] initWithLeftView:leftVC andMainView:delegate.mainNavigationController];
            delegate.window.rootViewController = delegate.leftSliderVC;
            [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
        }

    }
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
