//
//  SMLoginInputTableViewCell.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/17.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SMLoginInputCellStyle) {
    SMLoginInputCellStyleName,
    SMLoginInputCellStylePassword
};

@interface SMLoginInputTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *input;

- (void)configureWithStyle:(SMLoginInputCellStyle)style;
@end
