//
//  BaseViewController.h
//  UIViewController2
//
//  Created by Hailong.wang on 15/7/30.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Addition.h"
#import "Factory.h"
#import "MyHelper.h"

#import "NetInterface.h"

@interface BaseViewController : UIViewController

{
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic,assign) BOOL isLoadingMore;

@property (nonatomic,assign) BOOL isRefreshing;

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;


- (void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh;

-(void)firstDownload;

-(void)createView;

-(void)openOrCloseLeftList;

-(void)createRefreshView;

-(void)resetParame;

-(void)createAFHttpRequest;
- (void)addItemsWithCustomViews:(NSArray *)arr isLeft:(BOOL)isLeft;

//初始化数据源
- (void)initData;
//添加事件
- (void)addTouchAction;
//创建上导航左侧按钮(以view作模板)
- (void)createNavigationLeftButton:(id)view;
//创建上导航的左侧按钮(系统标题)
- (void)createNavigationLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//创建上导航右侧按钮(以view作模板)
- (void)createNavigationRightButton:(id)view;
//创建上导航的右侧按钮(系统标题)
- (void)createNavigationRightButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//使用pop返回
- (void)backAction;

//键盘弹出
- (void)keyboardShow:(NSNotification *)notification;
//键盘隐藏
- (void)keyboardHide:(NSNotification *)notification;

@end










