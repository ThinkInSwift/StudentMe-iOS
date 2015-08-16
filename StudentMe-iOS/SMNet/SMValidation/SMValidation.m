//
//  SMValidation.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMValidation.h"
#define kBaseHandler [self baseHandleResp:resp]
#define kErrCodeHandler   NSUInteger errCode = [(NSString *)resp[@"head"][@"errCode"] integerValue]

@implementation SMValidation
#pragma mark - validate the response
+ (BOOL)isNeedLoginWithResp:(NSDictionary *)resp {
    kBaseHandler;
    kErrCodeHandler;
    if (errCode == SMRespErrCodeNeedLogin) {
        return YES;
    }
    return NO;
}

+ (BOOL)isFailLoginWithResp:(NSDictionary *)resp {
    kBaseHandler;
    kErrCodeHandler;
    if (errCode == SMRespErrCodeLoginPwdNotRight) {
        return YES;
    }
    
    return NO;
}


#pragma mark - private methods
+ (BOOL)baseHandleResp:(NSDictionary *)resp {
    if (!resp) {
        return YES;
    }
    
    if (!resp[@"head"]) {
        return YES;
    }
    
    return NO;
}
@end
