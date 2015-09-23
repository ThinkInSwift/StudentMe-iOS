//
//  SMSettingsViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/9/23.
//  Copyright © 2015年 UESTC-BBS. All rights reserved.
//

#import "SMSettingsViewController.h"

#import <Masonry/Masonry.h>
#import <UIViewController+MMDrawerController.h>
#import <UIBarButtonItem+BlocksKit.h>

typedef NS_ENUM(NSInteger, SMSettingCell) {
    SMSettingCellEnableSticker,
    SMSettingCellCategoryJar
};

@interface SMSettingsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SMSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.title = @"设置";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.edges.equalTo(strongSelf.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"navi_menu"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    switch (indexPath.row) {
        case SMSettingCellEnableSticker:
            //
            break;
        case SMSettingCellCategoryJar:
            //
            break;
        default:
            break;
    }
    return cell;
}



@end
