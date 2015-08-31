//
//  SMNotify.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, SMNotifyType) {
    /**
     *  回复
     */
    SMNotifyTypePost,
    /**
     *  @ 消息
     */
    SMNotifyTypeAt,
    SMNotifyTypeFriend
};
@interface SMNotify : NSObject

@end

@class SMNotifyFilter;
@interface SMNotifyFilter : NSObject
@property (nonatomic, strong) NSString *page, *pageSize, *type;
- (instancetype)initWithType:(SMNotifyType)type;
- (NSDictionary *)dict;
@end