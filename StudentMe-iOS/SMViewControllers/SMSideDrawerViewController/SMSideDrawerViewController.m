//
//  SMSideDrawerViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMSideDrawerViewController.h"
#import "SMLeftSideViewTableViewCell.h"
#import "SMLeftSideAvatarViewTableViewCell.h"

@interface SMSideDrawerViewController ()

@end

@implementation SMSideDrawerViewController

- (void)viewDidLoad {
    if(OSVersionIsAtLeastiOS7()){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    else {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    for (NSString * identifier in @[@"SMLeftSideViewTableViewCell", @"SMLeftSideAvatarViewTableViewCell"]) {
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }
    
    
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UIColor * tableViewBackgroundColor;
    if(OSVersionIsAtLeastiOS7()){
        tableViewBackgroundColor = [UIColor colorWithRed:110.0/255.0
                                                   green:113.0/255.0
                                                    blue:115.0/255.0
                                                   alpha:1.0];
    }
    else {
        tableViewBackgroundColor = [UIColor colorWithRed:77.0/255.0
                                                   green:79.0/255.0
                                                    blue:80.0/255.0
                                                   alpha:1.0];
    }
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:66.0/255.0
                                                  green:69.0/255.0
                                                   blue:71.0/255.0
                                                  alpha:1.0]];
    // 设置 Navitagtionbar 的样式
    //    UIColor * barColor = [UIColor colorWithRed:161.0/255.0
    //                                         green:164.0/255.0
    //                                          blue:166.0/255.0
    //                                         alpha:1.0];
    //    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]){
    //        [self.navigationController.navigationBar setBarTintColor:barColor];
    //    }
    //    else {
    //        [self.navigationController.navigationBar setTintColor:barColor];
    //    }
    //
    //
    //    NSDictionary *navBarTitleDict;
    //    UIColor * titleColor = [UIColor colorWithRed:55.0/255.0
    //                                           green:70.0/255.0
    //                                            blue:77.0/255.0
    //                                           alpha:1.0];
    //    navBarTitleDict = @{NSForegroundColorAttributeName:titleColor};
    //    [self.navigationController.navigationBar setTitleTextAttributes:navBarTitleDict];
    self.navigationController.navigationBarHidden = YES;
    
    self.drawerWidths = @[@(160),@(200),@(240),@(280),@(320)];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    //    CGRect frame = CGRectMake(self.tableView.frame.origin.x
    //                              , self.tableView.frame.origin.y,
    //                              self.tableView.frame.size.width,
    //                               self.tableView.frame.size.height);
    //    [self.tableView setFrame:frame];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)contentSizeDidChange:(NSString *)size{
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case DrawerSectionUserInfo:
            return 1;
        case DrawerSectionSettings:
            return 4;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case DrawerSectionUserInfo: {
            static NSString *CellIdentifier = @"SMLeftSideAvatarViewTableViewCell";
            SMLeftSideAvatarViewTableViewCell *cell = (SMLeftSideAvatarViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[SMLeftSideAvatarViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
            }
            return [self configureAvatarCell:cell cellForRowAtIndexPath:indexPath];
        }
            break;
        case DrawerSectionSettings: {
            static NSString *CellIdentifier = @"SMLeftSideViewTableViewCell";
            SMLeftSideViewTableViewCell *cell = (SMLeftSideViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[SMLeftSideViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
            }
            return [self configureSettingsCell:cell cellForRowAtIndexPath:indexPath];
        }
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case DrawerSectionUserInfo:
            return 120.f;
            break;
        case DrawerSectionSettings:
            return 80.f;
        default:
            return 0.f;
            break;
    }
}


- (UITableViewCell *)configureAvatarCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // do custom configure
    return cell;
}

- (UITableViewCell *)configureSettingsCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // do custom configure
    return cell;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
