//
//  CommentTableViewCell.m
//  cartoon
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

-(void)setDataToCellWithModel:(CommentModel *)model
{
    [self.figureimg sd_setImageWithURL:[NSURL URLWithString:model.figureimg]];
    self.username.text = model.username;
    self.comment_content.text = model.comment_content;
    self.comment_time.text = model.comment_time;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
