//
//  SMAllCategoryViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/10/30.
//  Copyright © 2015年 UESTC-BBS. All rights reserved.
//

#import "SMAllCategoryViewController.h"

#import <Masonry/Masonry.h>
#import <UIBarButtonItem+BlocksKit.h>

@interface SMAllCategoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray<NSDictionary *>* categories;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SMAllCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] bk_initWithTitle:@"保存"
                                        style:UIBarButtonItemStylePlain
                                      handler:^(id sender) {
#warning 保存更新过的 json 描述文件
                                      }];
    
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
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).with.offset(15);
    }];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.text = self.categories[indexPath.row][@"name"];
    NSString *hasAddStr = self.categories[indexPath.row][@"hasAdd"];
    if ([hasAddStr isEqualToString:@"1"]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *mutableCategories = [self.categories mutableCopy];
    NSMutableDictionary *mutableCategory = [self.categories[indexPath.row] mutableCopy];
    NSString *hasAddStr = self.categories[indexPath.row][@"hasAdd"];
    if ([hasAddStr isEqualToString:@"1"]) {
        mutableCategory[@"hasAdd"] = @"0";
    } else {
        mutableCategory[@"hasAdd"] = @"1";
    }
    
    [mutableCategories replaceObjectAtIndex:indexPath.row withObject:[mutableCategory copy]];
    self.categories = [mutableCategories copy];
    [self.tableView reloadData];
}



@end
