//
//  Entity.h
//  cartoon
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * comic_id;
@property (nonatomic, retain) NSString * comic_title;
@property (nonatomic, retain) NSString * comic_thumb;
@property (nonatomic, retain) NSString * author_name;
@property (nonatomic, retain) NSString * frequency_zan;
@property (nonatomic, retain) NSString * frequency_fenxiang;
@property (nonatomic, retain) NSString * create_time;
@property (nonatomic, retain) NSString * frequency_pinglun;
@property (nonatomic, retain) NSNumber * isCollected;

@end
