//
//  UIViewController+SCCategorys.m
//  SCCategory
//
//  Created by SeanChense on 15/8/9.
//
//

#import "UIViewController+SCCategorys.h"

#import <UIAlertView+BlocksKit.h>
#import <MBProgressHUD.h>
@implementation UIViewController (SCCategorys)

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"出错了";
    alert.message = message;
    [alert bk_addButtonWithTitle:@"好的" handler:^{
        //
    }];
    [alert show];
}

- (void)showHudWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    }];
}
@end
