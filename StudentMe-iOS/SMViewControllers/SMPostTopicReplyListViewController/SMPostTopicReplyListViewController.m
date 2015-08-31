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
#import "SMTopicReply.h"
#import "SMWriteReplyViewController.h"

#import "UIViewController+SCCategorys.h"
#import <UIBarButtonItem+BlocksKit.h>

@interface SMPostTopicReplyListViewController ()
@property (strong, nonatomic) SMTopic *topic;
@end

@implementation SMPostTopicReplyListViewController

- (instancetype)initWithTopic:(SMTopic *)topic {
    self = [self init];
    if (self) {
        _dataSource = [@[] mutableCopy];
        _topic      = topic;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self beginRefresh];
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
        
        [strongSelf loadMoreData];
    };
    
    self.title = self.topic.title;
    
//    UIBarButtonItem *btnReply = [[UIBarButtonItem alloc] bk_initWithTitle:@"抢沙发" style:UIBarButtonItemStylePlain handler:^(id sender) {
//        [weakSelf willReplyUserWithName:weakSelf.topic.userNickName];
//    }];
//    self.navigationItem.rightBarButtonItem = btnReply;
}

- (void)initData {
    @weakify(self);
    [[[SMHttpDataManager sharedManager] forumPostlistWithTopicId:self.topic.topicId page:@"1"] subscribeNext:^(id x) {
        @strongify(self);
        [self.dataSource removeAllObjects];
        for (NSDictionary *dict in x[@"list"]) {
            SMTopicReply *reply = [[SMTopicReply alloc] initWithDict:dict];
            [self.dataSource addObject:reply];
        }
        SMTopicReply *reply = [[SMTopicReply alloc] initWithTopic:x[@"topic"]];
        [self.dataSource insertObject:reply atIndex:0];
        
    } error:^(NSError *error) {
        //
    } completed:^{
        @strongify(self);
        [self.tableView reloadData];
        [self performSelector:@selector(endRefresh) withObject:self afterDelay:0.0];
    }];
}

/**
 *  除开楼主，回复的列表数目不是 20 的整数倍判断为没有后续回复
 *  如果刚好回复数是 20 的整数倍，会出现重复的列表
 */
- (void)loadMoreData {
    if ((self.dataSource.count - 1) % 20 != 0) {
        [self performSelector:@selector(endLoadMore) withObject:self afterDelay:0.2];//没有后续的回复
        return;
    }
    
    @weakify(self);
    NSString *nextPage = [NSString stringWithFormat:@"%lu", ((unsigned long)self.dataSource.count / 20) + 1];
    [[[SMHttpDataManager sharedManager] forumPostlistWithTopicId:self.topic.topicId page:nextPage] subscribeNext:^(id x) {
        @strongify(self);
        for (NSDictionary *dict in x[@"list"]) {
            SMTopicReply *reply = [[SMTopicReply alloc] initWithDict:dict];
            [self.dataSource addObject:reply];
        }
        
        
    } error:^(NSError *error) {
        //
    } completed:^{
        @strongify(self);
        [self.tableView reloadData];
        [self performSelector:@selector(endLoadMore) withObject:self afterDelay:0.0];
    }];
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
    
    SMTopicReply *reply = self.dataSource[indexPath.row];
    [cell configureCellWithReply:reply];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMTopicReply *reply = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        [self willReply:reply style:SMWriteReplyStyleReplyTC];
    } else {
        [self willReply:reply style:SMWriteReplyStyleReplyOthers];
    }
     
}

- (void)willReply:(SMTopicReply *)reply style:(SMWriteReplyStyle)style{
    SMWriteReplyViewController *vc = [[SMWriteReplyViewController alloc] initWithReply:reply topic:self.topic style:style];
    UINavigationController *nav    = [[UINavigationController alloc] initWithRootViewController:vc];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
}


@end
