//
//  SMCategoriesViewController.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/31.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMBaseViewController.h"
@protocol SMCategorySelectDelegate <NSObject>

- (void)didSelectZone:(NSInteger)zone;
- (void)didCancelSelectZone;

@end

@interface SMCategoriesViewController : SMBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <SMCategorySelectDelegate> delegate;
@end

