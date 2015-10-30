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

struct {
    unsigned int didSelectZone : 1;
    unsigned int didCancelSelectZone : 1;
} _delegateFlags;
@interface SMCategoriesViewController()
@property (nonatomic, copy) NSArray<NSDictionary *>* categories;
@end

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
    
    NSString *path = @"SMCategories";
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    self.categories = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
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
    label.text = self.categories[indexPath.row][@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegateFlags.didSelectZone) {
        [_delegate didSelectZone:self.categories[indexPath.row]];
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
