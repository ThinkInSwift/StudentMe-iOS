//
//  SMPostTopicListTableViewCell.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/6.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMPostTopicListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <NSDate+TimeAgo.h>

@implementation SMPostTopicListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(SMTopic *)topic {
//    cell.postCreateTimeLabel.text = topic.lastReplyDate
    self.postNameLabel.text       = topic.userNickName;
    self.postTitleLabel.text      = topic.title;
    [self.postAvatarImgView sd_setImageWithURL:topic.userAvatar placeholderImage:[UIImage imageNamed:@"yae"]];
    self.postCreateTimeLabel.text = [topic.lastReplyDate timeAgo];
}

+ (CGFloat)height {
    return 50.0;
}
@end
