//
//  MiddleTableViewCell.m
//  cartoon
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "MiddleTableViewCell.h"
#import "DetailViewController.h"
#import "ManhuaListViewController.h"

@implementation MiddleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(DetailModel *)model
{
    self.DetailModel = model;
    self.textField.userInteractionEnabled = YES;
    self.textField.text = model.author_name;
    self.textField.enabled = NO;
    self.lastpage = model.prevpage;
    self.nextpage = model.nextpage;
    self.author_name = model.author_name;
    self.author_jianjie = model.author_jianjie;
    self.image_url = model.author_figureimg;
}

- (IBAction)findAll:(UIButton *)sender {
   
    self.block(self.author_name,self.author_jianjie,self.image_url);
}

- (IBAction)manHuaAll:(UITextField *)sender {
    self.block(self.author_name,self.author_jianjie,self.image_url);
}

- (IBAction)lastBtnClick:(UIButton *)sender {
    NSLog(@"abvc");
    if (self.delegate && [self.delegate respondsToSelector:@selector(showViewWithId:)]) {
        NSLog(@"fsgtr");
        [self.delegate showViewWithId:self.lastpage];
    }
}

- (IBAction)nextBtnClick:(UIButton *)sender {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showViewWithId:)]) {
            [self.delegate showViewWithId:self.nextpage];
        }
}


@end


















