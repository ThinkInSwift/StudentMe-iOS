//
//  SCIndicatorTitleView.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/9/12.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCIndicatorTitleView : UIView
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithTitle:(NSString *)title;
- (void)startIndicator;
- (void)stopIndicator;
@end
