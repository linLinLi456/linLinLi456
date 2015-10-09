//
//  DetailViewController.h
//  cartoon
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationModel.h"
#import "ManhuaListModel.h"
//#import "Entity.h"
#import "DetailModel.h"

@interface DetailViewController : UIViewController

@property (nonatomic,copy) NSString *id;

@property (nonatomic,strong) ApplicationModel *homeModel;

@property (nonatomic,strong) DetailModel *DetailModel;

//@property (nonatomic,strong) Entity *model;

-(DetailViewController *)initWithModel:(ApplicationModel *)model;


//
//-(void)initWithModle:(ManhuaListModel *)model;
//

@end
