//
//  SMNotificationViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SCPullRefreshViewController.h"


@interface SMNotificationViewController : SCPullRefreshViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *dataSource;

@end
