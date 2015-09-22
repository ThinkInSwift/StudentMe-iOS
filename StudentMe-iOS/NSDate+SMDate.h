//
//  NSDate+SMDate.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/9/22.
//  Copyright © 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SMDate)
+ (NSDate *)sm_dateWithServerTimestamp:(NSString *)timeStamp;
@end
