//
//  SMLeftSideViewTableViewCell.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMLeftSideViewTableViewCell.h"
#import "UIColor+SMColor.h"

#define kCellHeight 40.f

@implementation SMLeftSideViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.titleLabel.textColor = [UIColor smBlue];
    
    } else {
        self.titleLabel.textColor = [UIColor darkGrayColor];
    }
    
}

+ (CGFloat)cellHeight {
    return kCellHeight;
}

@end
