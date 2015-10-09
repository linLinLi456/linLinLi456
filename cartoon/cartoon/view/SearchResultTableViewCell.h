//
//  SearchResultTableViewCell.h
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchResultModel.h"

@interface SearchResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Image;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *ZanBtn;

@property (nonatomic) BOOL isZan;

- (IBAction)ZanBtn:(UIButton *)sender;

-(void)showDataWithModle:(SearchResultModel *)model;

@end
