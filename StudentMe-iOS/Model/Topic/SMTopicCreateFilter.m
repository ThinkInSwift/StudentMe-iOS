//
//  SMTopicCreateFilter.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/28.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMTopicCreateFilter.h"

@implementation SMTopicCreateFilter
- (instancetype)initWithFilterStyle:(SMTopicCreateFilterStyle)style
                                fid:(NSString *)fid
                                tid:(NSString *)tid
                            replyPostId:(NSString *)replyPostId
                            content:(NSString *)content {
    self = [self init];
    if (self) {
        switch (style) {
            case SMTopicCreateFilterStyleNewPost:
                _act = @"new";
                break;
            case SMTopicCreateFilterStyleReplyPost:
                _act = @"reply";
                break;
            case SMTopicCreateFilterStyleEditPost:
                _act = @"edit";
                break;
                
            default:
                break;
        }
        _fid = fid;
        _tid = tid;
        _replyId = replyPostId;
        _content = content;
    }
    
    return self;
}


- (NSDictionary *)dict {
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setObject:_act forKey:@"act"];
    [dict setObject:[self json] forKey:@"json"];
    
    return dict;

}

- (NSString *)json {
    NSMutableDictionary *dict = [@{} mutableCopy];
    NSMutableDictionary *body = [@{} mutableCopy];
    NSMutableDictionary *json = [@{} mutableCopy];
    [json setObject:_fid forKey:@"fid"];
    [json setObject:_tid forKey:@"tid"];
    [json setObject:@"1" forKey:@"isAnonymous"];
    [json setObject:@"1" forKey:@"isOnlyAuthor"];
//    [json setObject:<#(id)#> forKey:@"typeId"];
    [json setObject:@"1" forKey:@"isQuote"];
    [json setObject:_replyId forKey:@"replyId"];
    [json setObject:@"From iOS" forKey:@"title"];
    [json setObject:[self contentArray] forKey:@"content"];
    
    [body setObject:json forKey:@"json"];
    [dict setObject:body forKey:@"body"];

    NSError* err;
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return dataString;
    
}

- (NSString *)contentArray {
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setObject:@"0" forKey:@"type"];
    [dict setObject:_content forKey:@"infor"];
    
    NSArray *array = @[dict];
    
    NSError* err;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&err];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return dataString;
}
@end
