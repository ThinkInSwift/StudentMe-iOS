//
//  SMPostTopicReplyListTableViewCellTableViewCell.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/23.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SMTopicReply;

@interface SMPostTopicReplyListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyDateLabel;

- (void)configureCellWithReply:(SMTopicReply *)reply;
+ (CGFloat)height;
@end

