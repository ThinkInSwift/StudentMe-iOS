//
//  SMTopicListFilter.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/3.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SMTopicListFilterFid) {
    SMTopicListFilterWater      = 25,
    SMTopicListFilterEmotion    = 45,
    SMTopicListFilterDeals      = 61,
    SMTopicListFilterJob        = 214,
    SMTopicListFilterPartTimeJob = 183,
    SMTopicListFilterHighTechNews = 211
};


@interface SMTopicListFilter : NSObject

//boardId 相当于 fid。
//page
//pageSize
//sortby 'publish' == 'new', 'essence' == 'marrow', 'top', 'photo', 'all'（默认）
//filterType 'sortid', 'typeid'
//filterId 分类 ID，只返回指定分类的主题。
//isImageList
//topOrder 0（不返回置顶帖，默认）, 1（返回本版置顶帖）, 2（返回分类置顶帖）, 3（返回全局置顶帖）。置顶帖包含在 topTopicList 字段中。
@property (strong, nonatomic) NSString  *page, *pageSize, *sortBy, *filterType, *filterId, *isImageList, *topOrder;
@property (assign, nonatomic) NSInteger boardId;
- (SMTopicListFilter *)initFilterWithOption:(SMTopicListFilterFid)option;

- (NSDictionary *)convertObjectToDict;
@end
