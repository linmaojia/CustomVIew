//
//  YZGOrderButtonView.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSXSaveModel.h"
@interface SCSXTopView : UIView

/*block回调*/
@property (nonatomic,copy) void(^btnClickBlock)(BOOL isShow);

/*block标题回调*/
@property (nonatomic,copy) void(^titleClickBlock)(SCSXSaveModel *model);


/* 初始化*/
- (id)initWithTitles:(NSArray *)imageArray Frame:(CGRect)btnframe;


@property (nonatomic, strong) NSArray *styleArray;
@property (nonatomic, strong) NSArray *roomArray;
@end
