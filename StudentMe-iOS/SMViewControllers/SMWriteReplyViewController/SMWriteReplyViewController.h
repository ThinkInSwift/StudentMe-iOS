//
//  SMWriteReplyViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/24.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMBaseViewController.h"

typedef NS_ENUM(NSInteger, SMWriteReplyStyle) {
    SMWriteReplyStyleNewTopic,
    SMWriteReplyStyleReplyTC,/*楼主的翻译 TC Topic Creator see in https://zh.wikipedia.org/zh/%E6%A5%BC%E4%B8%BB*/
    SMWriteReplyStyleReplyOthers,
    SMWriteReplyStyleEditPost
};

@class SMTopic;

@class SMTopicReply;
@interface SMWriteReplyViewController : SMBaseViewController
- (instancetype)initWithReply:(SMTopicReply *)reply topic:(SMTopic *)topic style:(SMWriteReplyStyle)style;
@end
