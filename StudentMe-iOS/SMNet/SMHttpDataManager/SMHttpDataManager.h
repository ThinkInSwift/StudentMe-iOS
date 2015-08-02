//
//  SMHttpDataManager.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//
#import "NSURL+SMURL.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <AFNetworking/AFNetworking.h>

@interface SMHttpDataManager : RACSignal
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
+ (instancetype)sharedManager;


#pragma mark - user methods

- (RACSignal *)LoginWithUsername:(NSString *)username password:(NSString *)password;

#pragma mark - post methods

- (RACSignal *)forumlistWithFid:(NSString *)fid optionalType:(NSString *)type;
@end
