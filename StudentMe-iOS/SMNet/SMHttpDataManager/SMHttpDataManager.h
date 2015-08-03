//
//  SMHttpDataManager.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//
#import "NSURL+SMURL.h"
#import "SMTopicListFilter.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <AFNetworking/AFNetworking.h>

@interface SMHttpDataManager : RACSignal
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
+ (instancetype)sharedManager;


#pragma mark - user methods

- (RACSignal *)LoginWithUsername:(NSString *)username password:(NSString *)password;

#pragma mark - post methods
/**
 * 获取版块列表。
 */
- (RACSignal *)forumlistWithFid:(NSString *)fid optionalType:(NSString *)type;


/**
 * 获取某一版块的主题列表。
 */

- (RACSignal *)forumTopiclistWithFilter:(SMTopicListFilter *)filter;
@end
