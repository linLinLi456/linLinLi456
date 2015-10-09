//
//  ManhuaListModel.h
//  cartoon
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManhuaListModel : NSObject

@property (nonatomic,copy) NSString *comic_id;

@property (nonatomic,copy) NSString *comic_title;

@property (nonatomic,copy) NSString *comic_createtime;

@property (nonatomic,copy) NSString *comic_hadsee;

@end
/*
 {
 "comic_id": "818",
 "comic_title": "太伤自尊心了",
 "comic_createtime": "2015-09-19 ",
 "comic_hadsee": "false"
 },
 */