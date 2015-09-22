//
//  SMNotify.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMNotification.h"

#import "NSDate+SMDate.h"
//"board_id" = 70;
//"board_name" = "\U7a0b\U5e8f\U5458";
//icon = "http://bbs.uestc.edu.cn/uc_server/avatar.php?uid=92224&size=middle";
//"is_read" = 1;
//"replied_date" = 1441005184000;
//"reply_content" = "\U9762\U54ea\U513f
//\n";
//"reply_nick_name" = "\U8840\U5fc3";
//"reply_remind_id" = 27548394;
//"reply_url" = "";
//"topic_content" = "\U662f\U7684";
//"topic_id" = 1552980;
//"topic_subject" = "\U7ebf\U7a0b\U64cd\U4f5c\U76f8\U5173";
//"topic_url" = "";
//"user_id" = 92224;
@implementation SMNotification
- (instancetype)init {
    return nil;
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _boardName     = [dict objectForKey:@"board_name"];
        _replyNickName = [dict objectForKey:@"reply_nick_name"];
        _replyContent  = [dict objectForKey:@"reply_content"];
        _replyDate     = [NSDate sm_dateWithServerTimestamp:[dict objectForKey:@"replied_date"]];
        _replyAvatar   = [NSURL URLWithString:[dict objectForKey:@"icon"]];
        _topicId       = [dict objectForKey:@"topic_id"];
    }
    return self;
}
@end


@implementation SMNotificationFilter

- (instancetype)initWithType:(SMNotificationType)type {
    self = [super init];
    if (self) {
        switch (type) {
            case SMNotifyTypePost:
                _type = @"post";
                break;
            case SMNotifyTypeAt:
                _type = @"at";
                break;
            case SMNotifyTypeFriend:
                _type = @"friend";
                break;
            default:
                break;
        }
        _page = @"1";
        _pageSize = @"20";
    }
    
    return self;
}

- (instancetype)init {
    return nil;
}

- (NSDictionary *)dict {
    return @{
             @"page":self.page,
             @"pageSize":self.pageSize,
             @"type":self.type};
}

@end