//
//  SMCategoriesViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMCategoriesViewController.h"
#import "SMHostViewController.h"

#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger, CellStyle) {
    CellStyleWater,
    CellStyleEmotion,
    CellStyleJob,
    CellStyleDeals
};

struct {
    unsigned int didSelectZone : 1;
    unsigned int didCancelSelectZone : 1;
} _delegateFlags;

@implementation SMCategoriesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(100, 0, 150, 0));
    }];
    self.view.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    UILabel *label = [UILabel new];
    [cell.contentView addSubview:label];
    cell.backgroundColor = [UIColor clearColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
    }];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    switch (indexPath.row) {
        case CellStyleWater:
            label.text = @"水区";
            break;
        case CellStyleEmotion:
            label.text = @"情感";
            break;
        case CellStyleJob:
            label.text = @"就业";
            break;
        case CellStyleDeals:
            label.text = @"二手";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegateFlags.didSelectZone) {
        [_delegate didSelectZone:indexPath.row];
    }
    [self disappearCategory];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegateFlags.didCancelSelectZone) {
        [_delegate didCancelSelectZone];
    }
    [self disappearCategory];
}

- (void)disappearCategory {
    [((SMHostViewController *)self.parentViewController) removeBlurView];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

- (void)setDelegate:(id<SMCategorySelectDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.didSelectZone = [_delegate respondsToSelector:@selector(didSelectZone:)];
    _delegateFlags.didCancelSelectZone = [_delegate respondsToSelector:@selector(didCancelSelectZone)];
}
@end
