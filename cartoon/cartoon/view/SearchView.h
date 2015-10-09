//
//  SearchView.h
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSInteger tag);

@interface SearchView : UIView

@property (nonatomic,copy) MyBlock searchBlock;

@property (nonatomic) UIButton *button;

-(id)initWithFrame:(CGRect)frame Array:(NSArray *)ary;

@end
