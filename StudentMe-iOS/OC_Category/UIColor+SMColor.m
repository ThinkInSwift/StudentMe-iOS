//
//  UIColor+SMColor.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "UIColor+SMColor.h"

@implementation UIColor (SMColor)
+ (UIColor *)sm_blue {
    return [UIColor colorWithRed:0x3f/255.0 green:0xb7/255.0 blue:0xfc/255.0 alpha:1.0];
}

+ (UIColor *)sm_blueLight {
    return [UIColor colorWithRed:120.0/255.0 green:181.0/255.0 blue:209.0/255.0 alpha:1.0];
}

+ (UIColor *)sm_defaultBlue {
    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}
@end
