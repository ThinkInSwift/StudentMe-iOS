//
//  SMNotificationViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMNotificationViewController.h"
#import "SMNotificationTableViewCell.h"
#import "SMHttpDataManager.h"

#import "UIViewController+SCCategorys.h"

#import <UIBarButtonItem+BlocksKit.h>
#import <UIViewController+MMDrawerController.h>

@implementation SMNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self beginRefresh];
}

- (void)setUp {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setEstimatedRowHeight:[SMNotificationTableViewCell height]];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    for (NSString *identifier in @[@"SMNotificationTableViewCell"]) {
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"navi_menu"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    
    
    self.refreshBlock = ^{
        [weakSelf initData];
    };
    
    self.loadMoreBlock = ^{
        
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf loadMoreData];
        
    };
}

- (void)initData {
    __weak typeof(self) weakSelf = self;
    SMTopicListFilter *filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterWater];
    [[[SMHttpDataManager sharedManager] forumTopiclistWithFilter:filter] subscribeNext:^(id x) {
        weakSelf.dataSource = [x mutableCopy];
        [weakSelf.tableView reloadData];
        [weakSelf performSelector:@selector(endRefresh) withObject:weakSelf afterDelay:0.0];
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
        [weakSelf showAlertWithMessage:error.userInfo[@"info"]];
        [weakSelf performSelector:@selector(endRefresh) withObject:weakSelf afterDelay:0.0];
    } completed:^{
        NSLog(@"completed");
    }];
}

- (void)loadMoreData {
    __weak typeof(self) weakSelf = self;
    SMTopicListFilter *filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterWater];
    filter.page = [NSString stringWithFormat:@"%lu", (unsigned long)self.dataSource.count / [filter.pageSize intValue] + 1];
    
    [[[SMHttpDataManager sharedManager] forumTopiclistWithFilter:filter] subscribeNext:^(id x) {
        [weakSelf.dataSource addObjectsFromArray:x];
        [weakSelf.tableView reloadData];
        [weakSelf performSelector:@selector(endLoadMore) withObject:weakSelf afterDelay:0.0];
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
        [weakSelf showAlertWithMessage:error.userInfo[@"info"]];
        [weakSelf performSelector:@selector(endLoadMore) withObject:weakSelf afterDelay:0.0];
    } completed:^{
        NSLog(@"completed");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource || self.dataSource.count != 0 ? self.dataSource.count : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SMNotificationTableViewCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SMNotificationTableViewCell";
    SMNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[SMNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell configureCellWithNotification:[SMNotification new]];
    return cell;
}

@end
