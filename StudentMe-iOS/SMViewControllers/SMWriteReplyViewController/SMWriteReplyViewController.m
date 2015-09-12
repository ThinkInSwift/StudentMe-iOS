//
//  SMWriteReplyViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/24.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMWriteReplyViewController.h"
#import "SMHttpDataManager.h"
#import "SMTopic.h"
#import "SMTopicReply.h"

#import "UIViewController+SCCategorys.h"

#import <MBProgressHUD.h>
#import <UIBarButtonItem+BlocksKit.h>
@interface SMWriteReplyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) SMTopicReply *reply;
@property (nonatomic, strong) SMTopic *topic;
@property (nonatomic, assign) SMWriteReplyStyle style;
@end

@implementation SMWriteReplyViewController
- (instancetype)initWithReply:(SMTopicReply *)reply topic:(SMTopic *)topic style:(SMWriteReplyStyle)style {
    self = [self init];
    if (self) {
        _reply  = reply;
        _topic  = topic;
        _style  = style;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    @weakify(self);
    
    self.contentTextView.text = [[@"@" stringByAppendingString:self.reply.replyName] stringByAppendingString:@" "];
    [self.contentTextView becomeFirstResponder];
    UIBarButtonItem *btn_cancel = [[UIBarButtonItem alloc] bk_initWithTitle:@"取消" style:UIBarButtonItemStylePlain handler:^(id sender) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = btn_cancel;
    
    [self setTitle:@"回复"];
    
    UIBarButtonItem *btn_post = [[UIBarButtonItem alloc] bk_initWithTitle:@"发表" style:UIBarButtonItemStylePlain handler:^(id sender) {
        @strongify(self);
        [self willPostReply];
    }];
    self.navigationItem.rightBarButtonItem = btn_post;
    RAC(btn_post, enabled) = [[self.contentTextView rac_textSignal] map:^id(NSString  *value) {
        if (!value) {
            return @NO;
        }
        
        if (value.length == 0) {
            return @NO;
        }
        
        return @YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willPostReply {
    @weakify(self);
    SMTopicCreateFilter *filter;
    if (self.style == SMWriteReplyStyleReplyTC) {
        filter = [[SMTopicCreateFilter alloc] initWithFilterStyle:SMTopicCreateFilterStyleReplyPost
                                                       fid:self.topic.boardId
                                                       tid:self.topic.topicId
                                               replyPostId:self.reply.replyPostId
                                                   content:self.contentTextView.text
                                                 isReplyTC:YES];
    } else {
        filter = [[SMTopicCreateFilter alloc] initWithFilterStyle:SMTopicCreateFilterStyleReplyPost
                                                              fid:self.topic.boardId
                                                              tid:self.topic.topicId
                                                      replyPostId:self.reply.replyPostId
                                                          content:self.contentTextView.text
                                                        isReplyTC:NO];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"请稍候...";
    [[[SMHttpDataManager sharedManager] forumTopicAdminWithFilter:filter] subscribeNext:^(id x) {
        @strongify(self);
        [hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [hud hide:YES];
        [self sc_showAlertWithMessage:[NSString stringWithFormat:@"%@", error]];
    } completed:^{
    }];
}

@end
