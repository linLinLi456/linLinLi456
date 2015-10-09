//
//  MiddleTableViewCell.h
//  cartoon
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"



@protocol MiddleTableViewCellDelegate <NSObject>

-(void)showViewWithId:(NSString *)pid;

@end

typedef void(^MyBlock)(NSString *name,NSString *author,NSString *image_url);

@interface MiddleTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *author_name;

@property (nonatomic,copy) NSString *author_jianjie;

@property (nonatomic,copy) NSString *image_url;

@property (weak, nonatomic) IBOutlet UIButton *nextPage;
@property (weak, nonatomic) IBOutlet UIButton *lastPage;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;

@property (nonatomic,strong) DetailModel *DetailModel;

@property (assign,nonatomic) id<MiddleTableViewCellDelegate>delegate;

@property (nonatomic,copy) MyBlock block;

@property (nonatomic,copy) NSString *lastpage;

@property (nonatomic,copy) NSString *nextpage;

- (IBAction)findAll:(UIButton *)sender;

- (IBAction)manHuaAll:(UITextField *)sender;

- (IBAction)lastBtnClick:(UIButton *)sender;

- (IBAction)nextBtnClick:(UIButton *)sender;

-(void)showDataWithModel:(DetailModel *)model;



@end
