//
//  NSURL+SMURL.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (SMURL)

+ (NSString *)sm_hostString;

#pragma mark - user
+ (NSString *)sm_loginString;

#pragma mark - post
+ (NSString *)sm_forumlistString;
+ (NSString *)sm_forumTopiclistString;
+ (NSString *)sm_forumPostlistString;
+ (NSString *)sm_forumTopicAdminString;

#pragma mark - message
+ (NSString *)sm_messageNotifylistString;
@end
