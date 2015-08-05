//
//  SMUser.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/5.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMUser.h"

@implementation SMUser

- (instancetype)initWithHttpResponseData:(id)data {
    self = [self init];
    if (self) {
        NSDictionary *dic = (NSDictionary *)data;
        _userName   = dic[@"userName"];
        _uid        = dic[@"uid"];
        _secret     = dic[@"secret"];
        _token      = dic[@"token"];
        _avatar     = dic[@"avatar"];
        
    }
    
    return self;
}
@end
