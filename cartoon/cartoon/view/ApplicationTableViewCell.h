//
//  ApplicationTableViewCell.h
//  cartoon
//
//  Created by qianfeng on 15/9/3.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *comicImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end
