//
//  SMLoginViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol SMLoginDelegate <NSObject>
- (void)didLoginSucc;
@optional
- (void)didLoginFail;

@end

@interface SMLoginViewController : SMBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (nonatomic, weak) id <SMLoginDelegate> delegate;

@end
