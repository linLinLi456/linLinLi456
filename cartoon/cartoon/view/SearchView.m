//
//  SearchView.m
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "SearchView.h"
#import "SearchModel.h"

@implementation SearchView

-(id)initWithFrame:(CGRect)frame Array:(NSArray *)ary {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width, 44)];
        label.text = @"漫画推荐:";
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        
        CGFloat spaceH = 20;
        CGFloat spaceV = 10;//纵向间隔
        CGFloat width = (kScreenSize.width-8*2-4*spaceH)/3;
        CGFloat height = 25;
        
        for (NSInteger i = 0 ; i<ary.count; i++) {
            NSInteger col = i%3;
            NSInteger row = i/3;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(spaceH+(spaceH+width)*col, spaceV+(spaceV+height)*row, width, height)];
            SearchModel *model = ary[i];
            button.titleLabel.text = model.search;
            button.tag = 201+i;
            [self addSubview:button];
        }
    }
    return self;
}
-(void)btnClick:(UIButton *)button {
    if (self.searchBlock) {
        self.searchBlock(button.tag);
    }
}

@end
