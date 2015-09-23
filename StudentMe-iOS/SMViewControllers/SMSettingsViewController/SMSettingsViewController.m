//
//  SMSettingsViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/9/23.
//  Copyright © 2015年 UESTC-BBS. All rights reserved.
//

#import "SMSettingsViewController.h"

#import "UIColor+SMColor.h"

#import <Masonry/Masonry.h>
#import <UIViewController+MMDrawerController.h>
#import <UIBarButtonItem+BlocksKit.h>

typedef NS_ENUM(NSInteger, SMSettingCell) {
    SMSettingCellEnableSticker,
    SMSettingCellCategoryJar
};

const CGFloat LabelLeftPadding = 20.f;
const CGFloat elementRightPadding = 10.f;


@interface SMSettingsViewControllerCellLabel : UILabel

@end

@implementation SMSettingsViewControllerCellLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:13.f];
    }
    return self;
}

@end

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
//    __weak typeof(self) weakSelf = self;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    switch (indexPath.row) {
        case SMSettingCellEnableSticker: {
            UILabel *label = [SMSettingsViewControllerCellLabel new];
            UISwitch *uiSwitch = [UISwitch new];
            
            [cell.contentView addSubview:label];
            [cell.contentView addSubview:uiSwitch];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).with.offset(LabelLeftPadding);
                make.centerY.equalTo(cell.contentView);
            }];
            label.text = @"显示表情";
            
            [uiSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).with.offset(-elementRightPadding);
                make.centerY.equalTo(cell.contentView);
            }];
            uiSwitch.transform = CGAffineTransformMakeScale(1, 1);
            uiSwitch.onTintColor = [UIColor sm_defaultBlue];
            break;
        }
        case SMSettingCellCategoryJar:
            //
            break;
        default:
            break;
    }
    return cell;
}



@end
