//
//  DetailModel.h
//  cartoon
//
//  Created by qianfeng on 15/9/15.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import "JSONModel.h"

#import "Comic_DetailModel.h"

@interface DetailModel : JSONModel

@property (nonatomic,copy) NSString *prevpage;

@property (nonatomic,copy) NSString *nextpage;

@property (nonatomic,copy) NSString *author_name;

@property (nonatomic,copy) NSString *share_title;

@property (nonatomic,copy) NSString *author_figureimg;

@property (nonatomic,copy) NSString *author_jianjie;

@property (nonatomic,copy) NSString *frequency_pinglun;

@property (nonatomic,copy) NSString *frequency_fenxiang;

@property (nonatomic,copy) NSString *frequency_zan;

@property (nonatomic,copy) NSString *share_imgurl;

@property (nonatomic,copy) NSString *author_createtime;

@property (nonatomic,strong) NSArray <Comic_DetailModel> *comic_datail;


@end

/*
 @property (nonatomic, retain) NSString * comic_id;
 @property (nonatomic, retain) NSString * comic_title;
 @property (nonatomic, retain) NSString * comic_thumb;
 @property (nonatomic, retain) NSString * author_name;
 @property (nonatomic, retain) NSString * frequency_zan;
 @property (nonatomic, retain) NSString * frequency_fenxiang;
 @property (nonatomic, retain) NSString * create_time;
 @property (nonatomic, retain) NSString * frequency_pinglun;
 */

