//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Orientation) {
    vertical,
    horizontal
};

@interface MJHouzzView : UIView

@property (nonatomic,copy) void(^indexChangeBlock)(NSInteger index);
/* 初始化*/
- (id)initWithImageArray:(NSArray *)imageArray Btnframe:(CGRect)btnframe Orientation:(Orientation)orientation;


/**
 @param superFrame  父视图
 @param subFrame    按钮frame
 @param orientation 方向
 */
- (void)setSuperFrame:(CGRect)superFrame SubFrame:(CGRect)subFrame Orientation:(Orientation)orientation;



@end
