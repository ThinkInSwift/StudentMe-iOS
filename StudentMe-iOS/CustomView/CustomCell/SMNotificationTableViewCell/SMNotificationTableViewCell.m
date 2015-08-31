//
//  SMNotifyTableViewCell.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMNotificationTableViewCell.h"

#import <TTTAttributedLabel/TTTAttributedLabel.h>
@implementation SMNotificationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithNotification:(SMNotification *)notification {
    
}

+ (CGFloat)height {
    return 50.f;
}
@end
