//
//  SMLoginViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMLoginViewController.h"
#import "SMLoginInputTableViewCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIBarButtonItem+BlocksKit.h>
#import <Masonry/Masonry.h>

static NSString *const identifier = @"SMLoginInputTableViewCell";

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
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil]
         forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(130);
        make.height.equalTo(@82);
        make.width.equalTo(weakSelf.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SMLoginInputTableViewCell *cell = (SMLoginInputTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[SMLoginInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell configureWithStyle:indexPath.row];
    return cell;
}



@end
