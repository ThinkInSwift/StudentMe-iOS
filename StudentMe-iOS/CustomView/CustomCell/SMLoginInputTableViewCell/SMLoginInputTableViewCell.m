//
//  SMLoginInputTableViewCell.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/17.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMLoginInputTableViewCell.h"

@implementation SMLoginInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (RACSignal *)configureWithStyle:(SMLoginInputCellStyle)style {
    switch (style) {
        case SMLoginInputCellStyleName: {
            self.title.text = @"用户名";
            self.input.placeholder = @"required";
            break;
        }
        case SMLoginInputCellStylePassword: {
            self.title.text = @"密码";
            self.input.placeholder = @"required";
            self.input.secureTextEntry = YES;
            break;
        }
        default:
            break;
    }
    return self.input.rac_textSignal;
}

@end
