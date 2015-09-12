//
//  SCIndicatorTitleView.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/9/12.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SCIndicatorTitleView.h"

#import <Masonry/Masonry.h>

@implementation SCIndicatorTitleView {
    UIActivityIndicatorView *_indicatorView;
    UILabel *_label;
}
- (instancetype)initWithTitle:(NSString *)title {
    self = [self init];
    if (self) {
        _title = title;
        _label.text = title;
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _label = [[UILabel alloc] init];
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_label];
        [self addSubview:_indicatorView];
        
        __weak typeof(self) weakSelf = self;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
        
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_label);
            make.right.equalTo(_label.mas_left).with.offset(-5);
        }];
    }
    return self;
}

- (void)startIndicator {
    _indicatorView.hidden = NO;
    if (!_indicatorView.isAnimating) {
        [_indicatorView startAnimating];
    }
}
- (void)stopIndicator {
    _indicatorView.hidden = YES;
    if (_indicatorView.isAnimating) {
        [_indicatorView stopAnimating];
    }
}

- (void)setTitle:(NSString *)title {
    _label.text = title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
