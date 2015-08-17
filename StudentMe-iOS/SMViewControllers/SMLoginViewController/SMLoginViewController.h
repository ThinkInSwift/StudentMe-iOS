//
//  SMLoginViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMBaseViewController.h"

@interface SMLoginViewController : SMBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@end
