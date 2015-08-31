//
//  SMNotifyTableViewCell.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TTTAttributedLabel;
@class SMNotification;

@interface SMNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *notificationContent;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *createDateLabel;

- (void)configureCellWithNotification:(SMNotification *)notification;

+ (CGFloat)height;
@end
