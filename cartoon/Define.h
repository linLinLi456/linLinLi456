//
//  Define.h
//  cartoon
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#ifndef cartoon_Define_h
#define cartoon_Define_h

#import "NetInterface.h"
#import "JHRefresh.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "LZXHelper.h"
#import "MMProgressHUD.h"
#import "Factory.h"
#import "LeftViewController.h"

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
#define kIsOpen @"isOpen"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


#endif
