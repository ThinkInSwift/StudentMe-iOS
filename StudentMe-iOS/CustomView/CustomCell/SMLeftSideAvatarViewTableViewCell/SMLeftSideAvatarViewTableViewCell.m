//
//  SMLeftSideAvatarViewTableViewCell.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/27.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMLeftSideAvatarViewTableViewCell.h"
#define kCellHeight 120.f
@implementation SMLeftSideAvatarViewTableViewCell

- (void)awakeFromNib {
    self.avatarImgView.userInteractionEnabled = YES;
    [self.avatarImgView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showLoginButton:(BOOL)flag {
    self.avatarImgView.hidden = flag;
    self.textLabel.text = flag ? @"登录" : nil;
    
}

+ (CGFloat)cellHeight {
    return kCellHeight;
}
@end
