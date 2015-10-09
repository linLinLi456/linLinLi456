//
//  AutherListTableViewCell.m
//  cartoon
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "AutherListTableViewCell.h"

@implementation AutherListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"背景图"]];
}

-(void)showDataWithModel:(AutherListModel *)model {
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.author_jietu] placeholderImage:[UIImage imageNamed: @"author_fragment_zk"]];
    self.ImageView.layer.masksToBounds = YES;
    self.ImageView.layer.cornerRadius = 10.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
