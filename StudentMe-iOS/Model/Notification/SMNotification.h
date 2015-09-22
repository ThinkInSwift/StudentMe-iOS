//
//  SMNotification.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

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
typedef NS_ENUM(NSInteger, SMNotificationType) {
    /**
     *  回复
     */
    SMNotifyTypePost,
    /**
     *  @ 消息
     */
    SMNotifyTypeAt,
    SMNotifyTypeFriend
};
@interface SMNotification : NSObject
@property (nonatomic, copy) NSString *boardName;
@property (nonatomic, copy) NSString *replyContent;
@property (nonatomic, copy) NSString *replyNickName;
@property (nonatomic, strong) NSDate *replyDate;
@property (nonatomic, strong) NSURL *replyAvatar;
@property (nonatomic, copy) NSString *topicId;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@class SMNotificationFilter;
@interface SMNotificationFilter : NSObject
@property (nonatomic, strong) NSString *page, *pageSize, *type;
- (instancetype)initWithType:(SMNotificationType)type;
- (NSDictionary *)dict;
@end