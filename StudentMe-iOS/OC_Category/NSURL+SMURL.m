//
//  NSURL+SMURL.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "NSURL+SMURL.h"

@implementation NSURL (SMURL)

+ (NSString *)sm_hostString {
    return @"http://bbs.uestc.edu.cn";
}

#pragma mark - user
+ (NSString *)sm_loginString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"user/login"];
}

#pragma mark - post
+ (NSString *)sm_forumlistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/forumlist"];
}

+ (NSString *)sm_forumTopiclistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/topiclist"];
}

+ (NSString *)sm_forumPostlistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/postlist"];
}

+ (NSString *)sm_forumTopicAdminString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/topicadmin"];
}

#pragma mark - message
+ (NSString *)sm_messageNotifylistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"message/notifylist"];
}

#pragma mark - private method

+ (NSString *)prefixbbsUrlString {
    return [[self sm_hostString] stringByAppendingString:[self bbsMiddleUrlString]];
}

+ (NSString *)bbsMiddleUrlString {
    return @"/mobcent/app/web/index.php?r=";
}
@end
