//
//  DetailTableViewCell.m
//  cartoon
//
//  Created by qianfeng on 15/9/15.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [self createView];
}

//-(void)createView {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 300)];
//    [self.contentView addSubview:view];
//}

-(void)initWithModel:(Comic_DetailModel *)model {
    self.Width.constant = [model.width doubleValue];
    self.Height.constant = [model.height doubleValue];
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed: @"collect_search_zkt"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
