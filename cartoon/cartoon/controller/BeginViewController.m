//
//  BeginViewController.m
//  cartoon
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "BeginViewController.h"
#import "ApplicationViewController.h"
#import "AppDelegate.h"

@interface BeginViewController ()

@end

@implementation BeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"splash13"]];
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

- (IBAction)btnClick:(UIButton *)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    ApplicationViewController *avc = [[ApplicationViewController alloc] init];
    [delegate.leftSliderVC closeLeftView];
    [delegate.mainNavigationController pushViewController:avc animated:NO];

}
@end
