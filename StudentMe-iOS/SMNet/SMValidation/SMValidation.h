//
//  SMValidation.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMErr.h"

@interface SMValidation : NSObject
#pragma mark - validate the response
+ (BOOL)isNeedLoginWithResp:(NSDictionary *)resp;
+ (BOOL)isFailLoginWithResp:(NSDictionary *)resp;
@end
