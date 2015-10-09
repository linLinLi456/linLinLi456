//
//  ManhuaListViewController.h
//  cartoon
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "BaseViewController.h"

#import "AutherListModel.h"

@interface ManhuaListViewController : BaseViewController

@property (nonatomic,strong) AutherListModel *AuthorModel;

@property (nonatomic,copy) NSString *author;

@property (nonatomic,copy) NSString *jianjie;

@property (nonatomic,copy) NSString *image;

@end
