//
//  YZGOrderButtonView.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJSegmentedView : UIView
/*默认第一个选中*/
@property (nonatomic, assign) NSInteger index;

/*block回调*/
@property (nonatomic,copy) void(^btnClickBlock)(NSInteger index);

/*默认不隐藏*/
@property (nonatomic, assign) BOOL isHideLineView;

/*标题大小*/
@property (nonatomic, strong) UIFont *titleFont;

/*标题默认颜色（默认黑色）*/
@property (nonatomic, strong) UIColor *defaultColor;

/*标题选中颜色（默认主色调）*/
@property (nonatomic, strong) UIColor *selectColor;

- (id)initWithTitles:(NSArray *)titles;

@end
