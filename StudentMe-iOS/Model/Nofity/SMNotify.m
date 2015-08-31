//
//  SMNotify.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMNotify.h"

@implementation SMNotify

@end


@implementation SMNotifyFilter

- (instancetype)initWithType:(SMNotifyType)type {
    self = [self init];
    if (self) {
        switch (type) {
            case SMNotifyTypePost:
                _type = @"post";
                break;
            case SMNotifyTypeAt:
                _type = @"at";
                break;
            case SMNotifyTypeFriend:
                _type = @"friend";
                break;
            default:
                break;
        }
        _page = @"1";
        _pageSize = @"20";
    }
    
    return self;
}

- (NSDictionary *)dict {
    return @{
             @"page":self.page,
             @"pageSize":self.pageSize,
             @"type":self.type};
}

@end