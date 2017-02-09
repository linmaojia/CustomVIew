//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/*多个按钮*/
@interface MJMoreBtnView : UIView


@property (nonatomic,strong) NSArray *countArray;/*角标数组*/

@property (nonatomic,assign) CGFloat imageView_H;/*图片宽高（默认40）*/

@property (nonatomic,assign) CGFloat label_size;/*文字大小（默认14）*/

@property (nonatomic,assign) CGFloat label_H;/*文字高度（默认30）*/


@property (nonatomic,copy) void(^titleBlock)(NSInteger index);/*标题回调*/

- (id)initWithTitles:(NSArray *)titles Images:(NSArray *)images;
@end
