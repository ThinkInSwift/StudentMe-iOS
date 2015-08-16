//
//  SMErr.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SMRespErrCode) {
    SMRespErrCodeNeedLogin = 200102,
    SMRespErrCodeLoginPwdNotRight = 11100001
};

@interface SMErr : NSObject
+ (NSString *)errMessage:(NSUInteger)errcode;


+ (NSError *)errWithErrCode:(NSUInteger)errcode;
@end
