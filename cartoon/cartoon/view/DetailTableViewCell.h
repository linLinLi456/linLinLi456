//
//  DetailTableViewCell.h
//  cartoon
//
//  Created by qianfeng on 15/9/15.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Comic_DetailModel.h"

@interface DetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Width;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

-(void)initWithModel:(Comic_DetailModel *)model;

@end
