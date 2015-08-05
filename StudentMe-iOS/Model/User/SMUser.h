//
//  SMUser.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/5.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMUser : NSObject
@property (strong, nonatomic) NSString *token, *secret, *uid, *avatar, *userName;

- (instancetype)initWithHttpResponseData:(id)data;
- (void)saveToUserDefault;
+ (SMUser *)userFromUserDefault;
@end
