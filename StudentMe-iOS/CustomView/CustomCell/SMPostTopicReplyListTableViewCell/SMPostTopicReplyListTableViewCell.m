//
//  SMPostTopicReplyListTableViewCellTableViewCell.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/23.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMPostTopicReplyListTableViewCell.h"
#import "SMTopicReply.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <NSDate+TimeAgo.h>

@implementation SMPostTopicReplyListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithReply:(SMTopicReply *)reply {
    [self.iconImgView sd_setImageWithURL:reply.icon];
    self.userNameLabel.text = reply.replyName;
    self.replyContentLabel.text = reply.replyContent;
    self.replyDateLabel.text    = [reply.postsDate timeAgo];
}


+ (CGFloat)height {
    return 60.f;
}
@end
