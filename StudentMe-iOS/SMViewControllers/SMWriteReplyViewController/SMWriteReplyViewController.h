//
//  SMWriteReplyViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/24.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMBaseViewController.h"
@class SMTopic;

@class SMTopicReply;
@interface SMWriteReplyViewController : SMBaseViewController
- (instancetype)initWithReply:(SMTopicReply *)reply topic:(SMTopic *)topic;
@end
