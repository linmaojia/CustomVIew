//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MJAlertView : UIView

+ (void)showAlertViewWithTitle:(NSString *)title ConfirmBlock:(void(^)())confirmBlock CancelBlock:(void(^)())cancelBlock;

+ (void)showAlertViewWithTitle:(NSString *)title ConfirmText:(NSString *)confirmText CancelText:(NSString *)cancelText ConfirmBlock:(void(^)())confirmBlock CancelBlock:(void(^)())cancelBlock;

/*修改颜色*/
+ (void)showOtherAlertViewWithTitle:(NSString *)title ConfirmText:(NSString *)confirmText ConfirmColor:(UIColor *)confirmColor ConfirmBgColor:(UIColor *)confirmBgColor CancelText:(NSString *)cancelText CancelColor:(UIColor *)cancelColor CancelBgColor:(UIColor *)cancelBgColor ConfirmBlock:(void(^)())confirmBlock CancelBlock:(void(^)())cancelBlock;
@end
