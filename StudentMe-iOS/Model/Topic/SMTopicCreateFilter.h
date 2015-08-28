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

- (instancetype)initWithFilterStyle:(SMTopicCreateFilterStyle)style
                                fid:(NSString *)fid
                                tid:(NSString *)tid
                            replyId:(NSString *)replyId
                            content:(NSString *)content;
- (NSDictionary *)dict;
@end
