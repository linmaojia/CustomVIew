//
//  YZGOrderButtonView.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJOtherView : UIView
/*默认第一个选中*/
@property (nonatomic, assign) NSInteger index;

/*block回调*/
@property (nonatomic,copy) void(^btnClickBlock)(NSInteger index);

/*默认不隐藏*/
@property (nonatomic, assign) BOOL isHideLineView;


- (id)initWithTitles:(NSArray *)titles;
@end
