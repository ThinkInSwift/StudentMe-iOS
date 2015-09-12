//
//  UIViewController+SCCategorys.h
//  SCCategory
//
//  Created by SeanChense on 15/8/9.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (SCCategorys)
/**
 *  显示一个 alert
 *
 *  @param message message description
 */
- (void)sc_showAlertWithMessage:(NSString *)message;
/**
 *  显示一个自动消失的 hud （toast）
 *
 *  @param message message description
 */
- (void)sc_showHudWithMessage:(NSString *)message;

@end