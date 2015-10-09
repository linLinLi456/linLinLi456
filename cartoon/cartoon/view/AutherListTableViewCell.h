//
//  AutherListTableViewCell.h
//  cartoon
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutherListModel.h"

@interface AutherListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

-(void)showDataWithModel:(AutherListModel *)model;

@end
