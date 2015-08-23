//
//  SMPostTopicReplyListViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/23.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMPostTopicReplyListViewController.h"
#import "SMHttpDataManager.h"
#import "SMPostTopicReplyListTableViewCell.h"
#import "SMTopic.h"

#import "UIViewController+SCCategorys.h"
#import <UIBarButtonItem+BlocksKit.h>

@interface SMPostTopicReplyListViewController ()

@end

@implementation SMPostTopicReplyListViewController

- (instancetype)initWithTopic:(SMTopic *)topic {
    self = [self init];
    if (self) {
        _dataSource = [@[] mutableCopy];
        [_dataSource addObject:topic];//暂时
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self initData];
}

- (void)setUp {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setEstimatedRowHeight:[SMPostTopicReplyListTableViewCell height]];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    for (NSString *identifier in @[@"SMPostTopicReplyListTableViewCell"]) {
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }
    
    __weak typeof(self) weakSelf = self;
    
    self.refreshBlock = ^{
        [weakSelf initData];
    };
    
    self.loadMoreBlock = ^{
        
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf performSelector:@selector(endLoadMore) withObject:strongSelf afterDelay:2.0];
        
    };
}

- (void)initData {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataSource || self.dataSource.count != 0 ? self.dataSource.count : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SMPostTopicReplyListTableViewCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SMPostTopicReplyListTableViewCell";
    
    SMPostTopicReplyListTableViewCell *cell = (SMPostTopicReplyListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[SMPostTopicReplyListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    
    return cell;
}



@end
