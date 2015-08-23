//
//  SMPostTopicReplyListViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/23.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SCPullRefreshViewController.h"
@class SMTopic;

@interface SMPostTopicReplyListViewController : SCPullRefreshViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;

- (instancetype)initWithTopic:(SMTopic *)topic;

@end
