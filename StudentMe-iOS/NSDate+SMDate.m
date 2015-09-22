//
//  NSDate+SMDate.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/9/22.
//  Copyright © 2015年 UESTC-BBS. All rights reserved.
//

#import "NSDate+SMDate.h"

@implementation NSDate (SMDate)
+ (NSDate *)sm_dateWithServerTimestamp:(NSString *)timeStamp {
    return [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]/1000.0];
}
@end
