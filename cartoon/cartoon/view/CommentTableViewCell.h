//
//  CommentTableViewCell.h
//  cartoon
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *figureimg;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *comment_content;
@property (weak, nonatomic) IBOutlet UILabel *comment_time;


-(void)setDataToCellWithModel:(CommentModel *)model;

@end
