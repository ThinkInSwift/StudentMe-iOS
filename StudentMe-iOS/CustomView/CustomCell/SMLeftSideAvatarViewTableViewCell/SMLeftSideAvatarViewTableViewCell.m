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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight {
    return kCellHeight;
}
@end
