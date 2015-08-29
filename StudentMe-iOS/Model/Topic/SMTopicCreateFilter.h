//
//  SMTopicCreateFilter.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/28.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, SMTopicCreateFilterStyle) {
    SMTopicCreateFilterStyleNewPost,
    SMTopicCreateFilterStyleReplyPost,
    SMTopicCreateFilterStyleEditPost
};

@interface SMTopicCreateFilter : NSObject

@property (nonatomic, strong) NSString *act, *fid, *tid, *replyId, *content;
/**
 *  封装回复帖子的表单参数
 *
 *  @param style   见 SMTopicCreateFilterStyle
 *  @param fid     板块 id
 *  @param tid     主题 id
 *  @param replyPostId 回复的 id
 *  @param content 内容
 *
 *  @return 实体
 */
- (instancetype)initWithFilterStyle:(SMTopicCreateFilterStyle)style
                                fid:(NSString *)fid
                                tid:(NSString *)tid
                            replyPostId:(NSString *)replyPostId
                            content:(NSString *)content;
- (NSDictionary *)dict;
@end
