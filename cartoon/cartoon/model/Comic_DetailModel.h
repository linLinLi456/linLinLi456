//
//  Comic_DetailModel.h
//  cartoon
//
//  Created by qianfeng on 15/9/15.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "JSONModel.h"

@protocol Comic_DetailModel <NSObject>


@end

@interface Comic_DetailModel : JSONModel

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *width;

@property (nonatomic,copy) NSString *height;

@end
