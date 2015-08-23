//
//  SMTopic.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/14.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "board_id" = 61;
//    "board_name" = "\U4e8c\U624b\U4e13\U533a";
//    essence = 0;
//    gender = 0;
//    hits = 24;
//    hot = 0;
//    imageList =             (
//    );
//    isHasRecommendAdd = 0;
//    "last_reply_date" = 1439514942000;
//    "pic_path" = "";
//    ratio = 1;
//    recommendAdd = 0;
//    replies = 2;
//    sourceWebUrl = "http://bbs.uestc.edu.cn/forum.php?mod=viewthread&tid=1548760";
//    status = 0;
//    subject = "\U957f\U79df\U77ed\U79df\U5747\U53ef\Uff0c\U957f\U79df\U80fd\U523012\U6708  tel\Uff1a17090096680 \U6b22\U8fce\U9a9a\U6270";
//    title = "[\U6e05\U6c34-\U5361\U5238\U865a\U62df]\U6c42\U79dfcmccedu";
//    top = 0;
//    "topic_id" = 1548760;
//    type = normal;
//    userAvatar = "http://bbs.uestc.edu.cn/uc_server/avatar.php?uid=164722&size=middle";
//    "user_id" = 164722;
//    "user_nick_name" = "\U968f\U5fc3\U800c\U52a8AS11S";
//    vote = 0;
//}


@interface SMTopic : NSObject
@property (nonatomic, strong, readwrite) NSString *boardName, *sourceWebUrl, *subject, *title, *userNickName, *topicId;
@property (nonatomic, strong, readwrite) NSURL *userAvatar;
@property (nonatomic, strong, readwrite) NSString *boardId, *gender, *replies, *userId;
@property (nonatomic, strong, readwrite) NSDate *lastReplyDate;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
