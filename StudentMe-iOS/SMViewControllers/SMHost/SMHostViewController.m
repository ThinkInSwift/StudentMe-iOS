//
//  SMHostViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMHostViewController.h"
#import "SMHttpDataManager.h"
#import "SMPostTopicListTableViewCell.h"
#import "SMPostTopicReplyListViewController.h"
#import "SMCategoriesViewController.h"
#import "SCIndicatorTitleView.h"

#import <UIViewController+MMDrawerController.h>
#import "UIViewController+SCCategorys.h"
#import <UIBarButtonItem+BlocksKit.h>
#import <UIControl+BlocksKit.h>

typedef NS_ENUM(NSInteger, SMSegmentZone) {
    SMSegmentZoneWater,
    SMSegmentZoneEmotion,
    SMSegmentZoneJob,
    SMSegmentZoneDeals,
    SMSegmentZonePartTimeJob,
    SMSegmentZoneHighTechNews
};

@interface SMHostViewController () <SMCategorySelectDelegate>
@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;
@property (nonatomic, assign, readwrite) SMSegmentZone segmentZone;
@property (nonatomic, strong, readwrite) UIView *blurView;
@end

@implementation SMHostViewController

- (id)init {
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"SMHostViewController"];
        _segmentZone = SMSegmentZoneWater;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self beginRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (_blurView) {
        [_blurView setFrame:self.view.bounds];
    }
}

- (void)setUp {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setEstimatedRowHeight:[SMPostTopicListTableViewCell height]];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    for (NSString *identifier in @[@"SMPostTopicListTableViewCell"]) {
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"navi_menu"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemAction handler:^(id sender) {
        [weakSelf.view addSubview:self.blurView];
        [weakSelf.navigationController setNavigationBarHidden:YES animated:YES];
        
        SMCategoriesViewController *categoryVc = [[SMCategoriesViewController alloc] init];
        categoryVc.view.frame = self.view.bounds;
        categoryVc.view.alpha = 0;
        categoryVc.delegate = self;
        [weakSelf.view addSubview:weakSelf.blurView];
        [weakSelf.view addSubview:categoryVc.view];
        [weakSelf addChildViewController:categoryVc];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _blurView.alpha = 1;
            categoryVc.view.alpha = 1;
        } completion:nil];
    }];
    
    self.refreshBlock = ^{
        [weakSelf initData];
    };
    
    self.loadMoreBlock = ^{
        
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf loadMoreData];
        
    };
    
    self.navigationItem.titleView = [[SCIndicatorTitleView alloc] initWithTitle:@[@"水区", @"情感", @"就业", @"二手", @"科技资讯"][_segmentZone]];
}

- (void)initData {
    __weak typeof(self) weakSelf = self;
    SMTopicListFilter *filter;
    switch (self.segmentZone) {
        case SMSegmentZoneWater:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterWater];
            break;
        case SMSegmentZoneEmotion:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterEmotion];
            break;
        case SMSegmentZoneDeals:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterDeals];
            break;
        case SMSegmentZoneJob:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterJob];
            break;
        case SMSegmentZonePartTimeJob:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterPartTimeJob];
            break;
        case SMSegmentZoneHighTechNews:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterHighTechNews];
            break;
        default:
            break;
    }
    
    [[[SMHttpDataManager sharedManager] forumTopiclistWithFilter:filter] subscribeNext:^(id x) {
        weakSelf.dataSource = [x mutableCopy];
        [weakSelf.tableView reloadData];
        [weakSelf performSelector:@selector(endRefresh) withObject:weakSelf afterDelay:0.0];
        NSLog(@"more is %@", x);
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
        [weakSelf sc_showAlertWithMessage:error.userInfo[@"info"]];
        [weakSelf performSelector:@selector(endRefresh) withObject:weakSelf afterDelay:0.0];
        [(SCIndicatorTitleView *)self.navigationItem.titleView stopIndicator];
    } completed:^{
        NSLog(@"completed");
        [(SCIndicatorTitleView *)self.navigationItem.titleView stopIndicator];
    }];
}

- (void)loadMoreData {
    __weak typeof(self) weakSelf = self;
    SMTopicListFilter *filter;
    switch (self.segmentZone) {
        case SMSegmentZoneWater:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterWater];
            break;
        case SMSegmentZoneEmotion:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterEmotion];
            break;
        case SMSegmentZoneDeals:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterDeals];
            break;
        case SMSegmentZoneJob:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterJob];
            break;
        case SMSegmentZonePartTimeJob:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterPartTimeJob];
            break;
        case SMSegmentZoneHighTechNews:
            filter = [[SMTopicListFilter alloc] initFilterWithOption:SMTopicListFilterHighTechNews];
            break;
        default:
            break;
    }
    
    filter.page = [NSString stringWithFormat:@"%lu", (unsigned long)self.dataSource.count / [filter.pageSize intValue] + 1];
    
    [[[SMHttpDataManager sharedManager] forumTopiclistWithFilter:filter] subscribeNext:^(id x) {
        [weakSelf.dataSource addObjectsFromArray:x];
        [weakSelf.tableView reloadData];
        [weakSelf performSelector:@selector(endLoadMore) withObject:weakSelf afterDelay:0.0];
        NSLog(@"more is %@", x);
    } error:^(NSError *error) {
        NSLog(@"err is %@", error);
        [weakSelf sc_showAlertWithMessage:error.userInfo[@"info"]];
        [weakSelf performSelector:@selector(endLoadMore) withObject:weakSelf afterDelay:0.0];
    } completed:^{
        NSLog(@"completed");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [SMPostTopicListTableViewCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SMPostTopicListTableViewCell";
    
    SMPostTopicListTableViewCell *cell = (SMPostTopicListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[SMPostTopicListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    SMTopic *topic = [[SMTopic alloc] initWithDictionary:self.dataSource[indexPath.row]];
    [cell configureWithData:topic];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMTopic *topic = [[SMTopic alloc] initWithDictionary:self.dataSource[indexPath.row]];
    SMPostTopicReplyListViewController *vc = [[SMPostTopicReplyListViewController alloc] initWithTopic:topic];
    [self.navigationController pushViewController:vc animated:YES];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

#pragma mark - Getter
- (UIView *)blurView {
    if (!_blurView) {
        _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _blurView.alpha = 1.0f;
        _blurView.frame = [[UIScreen mainScreen] bounds];
    }
    return _blurView;
}

- (void)removeBlurView {
    [UIView animateWithDuration:0.3 animations:^{
        _blurView.alpha = 0;
    } completion:^(BOOL finished) {
        [_blurView removeFromSuperview];
    }];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark - CategoryControllerDelegate

- (void)didSelectZone:(NSInteger)zone {
    self.segmentZone = zone;
    SCIndicatorTitleView *titleView = (SCIndicatorTitleView *)self.navigationItem.titleView;
    [titleView setTitle:@[@"水区", @"情感", @"就业", @"二手", @"兼职", @"科技资讯"][zone]];
    [titleView startIndicator];
    [self initData];
}

- (void)didCancelSelectZone {
    NSLog(@"用户取消选择板块");
}
@end

