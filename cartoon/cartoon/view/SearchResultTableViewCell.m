//
//  SearchResultTableViewCell.m
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    self.isZan = 0;
}

-(void)showDataWithModle:(SearchResultModel *)model {
    [self.Image sd_setImageWithURL:[NSURL URLWithString:model.comic_thumb] placeholderImage:[UIImage imageNamed: @"login_touxiang60x60"]];
    self.name.text = model.comic_title;
    self.nameLabel.text = model.author_name;
    [self.ZanBtn setImage:[UIImage imageNamed: @"search_zan"] forState:UIControlStateNormal];
    if ([model.frequency_zan isEqualToString:@"null"]) {
        [self.ZanBtn setTitle:@"" forState:UIControlStateNormal];
    }
    [self.ZanBtn setTitle:model.frequency_zan forState:UIControlStateNormal];
    [self.ZanBtn setImage:[UIImage imageNamed: @"activity_paise"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ZanBtn:(UIButton *)sender {
    if (self.isZan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你已经点过赞了" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
        [self.ZanBtn setImage:[[UIImage imageNamed: @"activity_paise"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.ZanBtn setTitle:[NSString stringWithFormat:@"%ld",self.ZanBtn.titleLabel.text.integerValue+1] forState:UIControlStateNormal];
        self.isZan = YES;
    }
    
}
@end















