//
//  BaseViewController.m
//  UIViewController2
//
//  Created by Hailong.wang on 15/7/30.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    //添加行为
    [self addTouchAction];
//    self.navigationItem.title = @"使用指导";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"splash13"]];
    [self createView];
    [self createNevagitionItem];
    [self createAFHttpRequest];
}
-(void)createView {
    
}

-(void)createNevagitionItem {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 18);
    [leftBtn setBackgroundImage:[UIImage imageNamed: @"menufragment_"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
-(void)createAFHttpRequest {
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

-(void)openOrCloseLeftList {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (delegate.leftSliderVC.closed) {
        [delegate.leftSliderVC openLeftView];
    } else {
        [delegate.leftSliderVC closeLeftView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.leftSliderVC setPanEnabled:YES];
    /*
     将要做还没有做的时候提醒
     */
    //注册键盘将要弹出的提醒
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘将要消失时的提醒
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.leftSliderVC setPanEnabled:NO];

    //移除注册的键盘将要显示的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    //移除注册的键盘将要隐藏的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)addItemsWithCustomViews:(NSArray *)arr isLeft:(BOOL)isLeft {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (UIView *view in arr) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        [items addObject:item];
    }
    //判断
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    }else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

-(void)firstDownload {
    
}
-(void)resetParame {
    
}
-(void)createRefreshView {
    
}
-(void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toNextView {
    
}

//初始化数据源
- (void)initData {
    //不做实现，只是为了使用方便
}

//添加事件
- (void)addTouchAction {
    //不做实现，只是为了使用方便
}

//键盘弹出
- (void)keyboardShow:(NSNotification *)notification {
    //不做实现，只是为了使用方便
}

//键盘隐藏
- (void)keyboardHide:(NSNotification *)notification {
    //不做实现，只是为了使用方便
}

//创建上导航左侧按钮(以view作模板)
- (void)createNavigationLeftButton:(id)view {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//创建上导航左侧按钮(系统标题)
- (void)createNavigationLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//创建上导航右侧按钮(以view作模板)
- (void)createNavigationRightButton:(id)view {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//创建上导航右侧按钮(系统标题)
- (void)createNavigationRightButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end





