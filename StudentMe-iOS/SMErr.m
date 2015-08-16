//
//  SMErr.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMErr.h"

@implementation SMErr
+ (NSString *)errMessage:(NSUInteger)errcode {
    switch (errcode) {
        case SMRespErrCodeNeedLogin: return @"抱歉，您尚未登录，没有权限访问该版块";
            
            
        default:return @"未知错误";
            
    }
}

+ (NSError *)errWithErrCode:(NSUInteger)errcode {
    NSError *err = [[NSError alloc] initWithDomain:nil code:errcode userInfo:@{@"info":[self errMessage:errcode]}];
    
    return err;
}


@end
