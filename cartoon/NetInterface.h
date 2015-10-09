//
//  NetInterface.h
//  cartoon
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李琳琳. All rights reserved.
//

#ifndef cartoon_NetInterface_h
#define cartoon_NetInterface_h

//首页
#define kUrl @"http://api.jidepi.com/Getpacdata/gettup?page=%ld"

//作者列表
#define kAuthorlist @"http://api.jidepi.com/Getpacdata/authorlist?page=%ld"

//作者作品列表
#define kManhualist @"http://api.jidepi.com/Getpacdata/manhuaall?page=%ld&IMEI=864179022347683&IMSI=460017511366587&MODEL=Lenovo+S820&MANUFACTURER=LENOVO&RELEASE=4.2.1&SDK_INT=17&MACADDR=cc07e4139510&WIDTH=720&HEIGHT=1280&DENSITYDPI=320&VERSION=1.3.4&TIME=1442732687&channel=&uid=70000000&sign=null"

//http://api.jidepi.com/Getpacdata/manhuaall?page=1&IMEI=864179022347683&IMSI=460017511366587&MODEL=Lenovo+S820&MANUFACTURER=LENOVO&RELEASE=4.2.1&SDK_INT=17&MACADDR=cc07e4139510&WIDTH=720&HEIGHT=1280&DENSITYDPI=320&VERSION=1.3.4&TIME=1442709857&channel=&uid=70000000&sign=null

//漫画详情
#define kManhuadetail @"http://api.jidepi.com/Getpacdata/getpic?id=%@"
//评论列表
#define kCommentlist @"http://api.jidepi.com/Getpacdata/commentlist?manhua_id=%@"

//评论接口
#define kAddComment @"http://api.jidepi.com/Getpacdata/addcomment?username=52B645B81D40B599AD41E98BB8C8CFBE"

//搜索接口
#define kSearch @"http://api.jidepi.com/Getpacdata/search"

//搜索结果接口
#define kSearchResult @"http://api.jidepi.com/Getpacdata/seek?key=%@&page=%ld"

#endif



















