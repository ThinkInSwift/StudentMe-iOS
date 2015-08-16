//
//  SMTopicListFilter.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/3.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMTopicListFilter.h"

//boardId 相当于 fid。
//page
//pageSize
//sortby 'publish' == 'new', 'essence' == 'marrow', 'top', 'photo', 'all'（默认）
//filterType 'sortid', 'typeid'
//filterId 分类 ID，只返回指定分类的主题。
//isImageList
//topOrder 0（不返回置顶帖，默认）, 1（返回本版置顶帖）, 2（返回分类置顶帖）, 3（返回全局置顶帖）。置顶帖包含在 topTopicList 字段中。
@implementation SMTopicListFilter
- (instancetype)init {
    self = [super init];
    if (self) {
        //
    }
    
    return self;
}

- (SMTopicListFilter *)initFilterWithOption:(SMTopicListFilterFid)option {
    self = [self init];
    if (self) {
        _boardId      = option;
        _page         = @"1";
        _pageSize     = @"40";
        _sortBy       = @"all";
        _filterType   = @"sortid";
        _filterId     = @"";
        _isImageList  = @"0";
        _topOrder     = @"0";
    }
    
    
    return self;
}

- (NSDictionary *) convertObjectToDict:(SMTopicListFilter *)object {
    NSDictionary *dict = @{@"boardId":[NSString stringWithFormat:@"%ld", (long)object.boardId],
                           @"page":object.page,
                           @"pageSize":object.pageSize,
                           @"sortby":object.sortBy,
                           @"filterType":object.filterType,
                           @"filterId":object.filterId,
                           @"isImageList":object.isImageList,
                           @"topOrder":object.topOrder,
                           };
    
    
    return dict;
}

@end
