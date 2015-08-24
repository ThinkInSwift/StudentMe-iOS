//
//  SMWriteReplyViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/24.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMWriteReplyViewController.h"
#import "SMHttpDataManager.h"

#import "UIViewController+SCCategorys.h"
#import <UIBarButtonItem+BlocksKit.h>
@interface SMWriteReplyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) NSString *name;
@end

@implementation SMWriteReplyViewController
- (instancetype)initWithReplyUserName:(NSString *)name {
    self = [self init];
    if (self) {
        _name   = name;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    @weakify(self);
    
    self.contentTextView.text = [[@"@" stringByAppendingString:self.name] stringByAppendingString:@" "];
    UIBarButtonItem *btn_cancel = [[UIBarButtonItem alloc] bk_initWithTitle:@"取消" style:UIBarButtonItemStylePlain handler:^(id sender) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = btn_cancel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
