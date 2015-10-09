//
//  AppDelegate.m
//  cartoon
//
//  Created by qianfeng on 15/9/2.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "LeftStoreViewController.h"
#import "ApplicationViewController.h"

#import "BeginOpenViewController.h"

#import "CoreData+MagicalRecord.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initUM];
    [self initCoreData];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:kIsOpen];
    if (!isOpen) {
        self.window.rootViewController = [[BeginOpenViewController alloc] init];
    } else {
        NSArray *vcNames = @[@"ApplicationViewController",@"AuthorListViewController",@"CollectViewController",@"ShareViewController",@"MyViewController",@"BeginViewController"];
        
        for (NSInteger i = 0; i<vcNames.count; i++) {
            Class vcClass = NSClassFromString(vcNames[i]);
            BaseViewController *vc= [[vcClass alloc] init];
            
            self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.mainNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"HPBannerBottomMask"] forBarMetrics:UIBarMetricsDefault];
            LeftStoreViewController *leftVC = [[LeftStoreViewController alloc] init];
            self.leftSliderVC = [[LeftViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
            self.window.rootViewController = self.leftSliderVC;
            NSLog(@"main:%@",self.mainNavigationController);
            [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        }
       
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsOpen];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)initUM {
    [UMSocialData setAppKey:@"56020e9c67e58e13e70003e5"];
    [UMSocialWechatHandler setWXAppId:@"wx8ee72c2f7528dbbe" appSecret:@"   6b73603057ca4ff1c6a4b43e012ad430" url:@" https://github.com/linLinLi456/LZWM.git"];
    
}
#pragma mark - 其他app访问当前app 回调的方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

-(void)initCoreData {
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"CollectCartoonData.sqlite"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
