//
//  SearchResultModel.h
//  cartoon
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

@property (nonatomic,copy) NSString *comic_id;

@property (nonatomic,copy) NSString *comic_title;

@property (nonatomic,copy) NSString *comic_thumb;

@property (nonatomic,copy) NSString *author_name;

@property (nonatomic,copy) NSString *frequency_zan;

@property (nonatomic,copy) NSString *frequency_fenxiang;

@property (nonatomic,copy) NSString *comic_hadsee;

@property (nonatomic,copy) NSString *create_time;

@property (nonatomic,copy) NSString *frequency_pinglun;

@end
/*
 [
 {
 "comic_id": "83",
 "comic_title": "富二代写情书",
 "comic_thumb": "http://i4.tietuku.com/3ad932264d6d836f.jpg",
 "author_name": "围棋",
 "frequency_pinglun": "32",
 "frequency_fenxiang": "111",
 "frequency_zan": "93",
 "comic_hadsee": "false",
 "create_time": "2015-06-19 "
 }
 ]
 */