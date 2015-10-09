//
//  AppDelegate.h
//  cartoon
//
//  Created by qianfeng on 15/9/2.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeftViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)  LeftViewController *leftSliderVC;

@property (strong,nonatomic) UINavigationController *mainNavigationController;



@end

