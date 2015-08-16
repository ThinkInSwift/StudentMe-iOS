//
//  SMLoginViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMLoginViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIBarButtonItem+BlocksKit.h>


@interface SMLoginViewController ()

@end

@implementation SMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *btn_cancel = [[UIBarButtonItem alloc] bk_initWithTitle:@"取消" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.navigationItem.leftBarButtonItem = btn_cancel;
    
    self.title = @"登录";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}



@end
