//
//  SMTopicReply.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/23.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMTopicReply.h"

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

#define REGEX_DETECT_GIF_LINK   @"/.*\\[mobcent_phiz=(.*)\\].*/"
//@"/.*[mobcent_phiz=(.*)]" //see in http://bbs.uestc.edu.cn/forum.php?mod=viewthread&tid=1567147&page=1#pid27836679

@implementation SMTopicReply
- (instancetype)initWithTopic:(NSDictionary *)topicDict imageCallback:(void (^)(void))block {
    self = [self init];
    if (self) {
        _icon           = [NSURL URLWithString:topicDict[@"icon"]];
        _replyName      = topicDict[@"user_nick_name"];
        _replyId        = [NSString stringWithFormat:@"%@", topicDict[@"user_id"]];
        _replyPostId    = [NSString stringWithFormat:@"%@", topicDict[@"topic_id"]];
        _replyContent   = [self replyContent:topicDict[@"content"] imageCallback:block];
        _postsDate      = [NSDate dateWithTimeIntervalSince1970:[(NSString *)topicDict[@"create_date"] integerValue]/1000.0];
        
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict imageCallback:(void (^)(void))block {
    self = [self init];
    if (self) {
        _icon           = [NSURL URLWithString:dict[@"icon"]];
        _replyName      = dict[@"reply_name"];
        _replyId        = [NSString stringWithFormat:@"%@", dict[@"reply_id"]];
        _replyPostId    = [NSString stringWithFormat:@"%@", dict[@"reply_posts_id"]];
        _replyContent   = [self replyContent:dict[@"reply_content"] imageCallback:block];
        _quoteUserName  = [self quoteUserNameWithQuoteContent:dict[@"quote_content"]];
        _postsDate      = [NSDate dateWithTimeIntervalSince1970:[(NSString *)dict[@"posts_date"] integerValue]/1000.0];
        if (_quoteUserName) {
            NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:_quoteUserName];
            [temp appendAttributedString:_replyContent];
            _replyContent = temp;
        }
        
    }
    return self;
}

/**
 *  需要区分所有 type 类型，目前知道  type 为 4 为 @某人
 *                                type 为 0 为正常文本文字
 *                                type 为 1 为图片附件？
 *
 *  @param array array description
 *
 *  @return return value description
 */
- (NSAttributedString *)replyContent:(NSArray *)array imageCallback:(void (^)(void))block {
    NSMutableAttributedString *attributedContent;
    NSString *content = @"";
    for (NSDictionary *dict in array) {
        if ([dict[@"type"] isEqualToNumber:@1]) {
            break;
        }
        content = [content stringByAppendingString:dict[@"infor"]];
        NSURL *url = nil;
        NSUInteger stickerLocation;
        content = [self p_handleStikerString:content stickerUrl:&url location:&stickerLocation];
        attributedContent = [[NSMutableAttributedString alloc] initWithString:content];
        
        if (!url) {
            return attributedContent;
        }
        
        if (!attributedContent) {
            return nil;
        }
        
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        textAttachment.bounds = CGRectMake(1, 0, 30, 30);
        dispatch_queue_t queue = dispatch_queue_create("io.seanchense.github", NULL);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            dispatch_async(dispatch_get_main_queue(), ^{
                textAttachment.image = image;
                block();
            });
        });
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        if (stickerLocation == 0) {
//            [attributedContent replaceCharactersInRange:NSMakeRange(stickerLocation, 1) withAttributedString:attrStringWithImage];
//        } else {
//            if (attributedContent.length == stickerLocation) {
//                [attributedContent appendAttributedString:attrStringWithImage];
//            } else {
//                [attributedContent replaceCharactersInRange:NSMakeRange(stickerLocation + 1, 1) withAttributedString:attrStringWithImage];
//            }
//        }
        NSMutableAttributedString *temp = [attrStringWithImage mutableCopy];
        [temp appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        attrStringWithImage = [temp copy];
        [attributedContent insertAttributedString:attrStringWithImage atIndex:stickerLocation];
    }
    return attributedContent;
}

                           
                           
- (NSString *)quoteUserNameWithQuoteContent:(NSString *)content {
    NSString *userName;
    if (!content || content.length == 0) {
        return nil;
    }
    
    NSArray *strs = [content componentsSeparatedByString:@" "];
    if (!strs || strs.count == 0) {
        return nil;
    }
    
    userName = strs[0];
    return [[@"@" stringByAppendingString:userName] stringByAppendingString:@" "];
}


#pragma mark - private methods
#warning 没有良好的实现
- (NSString *)p_detectRegexStr:(NSString *)regexStr string:(NSString *)str stickerUrl:(NSURL **)url {
    NSError *err = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&err];
    NSArray *array = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    if (!array || array.count == 0  ) {
        return str;
    }
    NSRange matchRange = [array[0] rangeAtIndex:0];
    NSString *match = [str substringWithRange:matchRange];
    NSString *urlStr = [match componentsSeparatedByString:@"="][1];
    *url = [NSURL URLWithString:urlStr];
    return str;
    
}

- (NSString *)p_handleStikerString:(NSString *)str stickerUrl:(NSURL **)url location:(NSUInteger *)location{
    NSLog(@"str is %@", str);
    if (![str containsString:@"mobcent_phiz"]) {
        return str;
    }
    
    NSRange leftRange = [str rangeOfString:@"["];
    *location = leftRange.location;
    NSRange rightRange = [str rangeOfString:@"]"];
    
    NSRange replaceRange = NSMakeRange(leftRange.location, rightRange.location - leftRange.location + 1);
    NSString *rawUrlStr = [str substringWithRange:replaceRange];
    NSString *urlStr = [(NSString *)[rawUrlStr componentsSeparatedByString:@"="][1] componentsSeparatedByString:@"]"][0];
    *url = [NSURL URLWithString:urlStr];
    
    NSMutableString *temp = [str mutableCopy];
    [temp deleteCharactersInRange:replaceRange];
    if (temp.length == 0) {
        [temp appendString:@" "];
    }
    return [temp copy];
}
@end
