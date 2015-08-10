//
//  SMLeftSideViewTableViewCell.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMLeftSideViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (CGFloat)cellHeight;

@end
