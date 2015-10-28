//
//  SMTopicReply.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/23.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    extraPanel =             (
//                              {
//                                  action = "http://bbs.uestc.edu.cn/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.4.0.2&accessToken=129d997d722eda02f18878c329be9&accessSecret=19bede689d8a368350dc2f0c12a09&apphash=&tid=1550796&pid=27517570&type=post";
//                                  extParams =                     {
//                                      beforeAction = "";
//                                      isHasRecommendAdd = 0;
//                                      recommendAdd = 0;
//                                  };
//                                  recommendAdd = "";
//                                  title = "\U652f\U6301";
//                                  type = support;
//                              }
//                              );
//    icon = "http://bbs.uestc.edu.cn/uc_server/avatar.php?uid=125744&size=middle";
//    "is_quote" = 1;
//    level = 0;
//    location = "";
//    managePanel =             (
//    );
//    mobileSign = "";
//    position = 5;
//    "posts_date" = 1440298226000;
//    "quote_content" = "\Ufe4f\Ufe4f\Ufe4f\Ufe4f \U53d1\U8868\U4e8e 2015-8-23 09:51\n\U4ec0\U4e48\U53eb\U51e4\U51f0\U7537\Uff1f\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b\U200b";
//    "quote_pid" = 0;
//    "quote_user_name" = "";
//    "reply_content" =             (
//                                   {
//                                       infor = "\U5c31\U662f\U7535\U5b50\U79d1\U5927\U7684\U5927\U90e8\U5206\U7537\U751f";
//                                       type = 0;
//                                   }
//                                   );
//    "reply_id" = 125744;
//    "reply_name" = Seanchense;
//    "reply_posts_id" = 27517570;
//    "reply_status" = 1;
//    "reply_type" = normal;
//    "role_num" = 1;
//    status = 1;
//    title = "";
//    userTitle = "\U767d\U9ccd (Lv.9)";
//}
@interface SMTopicReply : NSObject
@property (nonatomic, copy) NSString *quoteUserName/*被该帖子引用的帖子发帖者*/, *replyName/*回复者的名字*/, *replyId/*回复者的 id*/, *replyPostId/*该回复（帖子本身）的 id*/;
@property (nonatomic, copy)   NSAttributedString *replyContent/*回复的内容*/;
@property (nonatomic, copy) NSURL *icon;
@property (nonatomic, copy) NSDate *postsDate;
/**
 *  用 SMTopic 的 dict 字段 map 成 SMTopicReply
 *
 *  @param topicDict topicDict description
 *
 *  @return 实体
 */
- (instancetype)initWithTopic:(NSDictionary *)topicDict;
/**
 *  SMTopicReply 的 dict 封装实体
 *
 *  @param dict dict description
 *
 *  @return 实体
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
