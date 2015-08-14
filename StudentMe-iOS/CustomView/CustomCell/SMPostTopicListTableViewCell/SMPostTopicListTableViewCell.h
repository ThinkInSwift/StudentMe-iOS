//
//  SMPostTopicListTableViewCell.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/6.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTopic.h"

@interface SMPostTopicListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *postNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postAvatarImgView;
+ (CGFloat)height;

- (void)configureWithData:(SMTopic *)topic;
@end
