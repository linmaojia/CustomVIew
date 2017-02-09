//
//  YZGOrderButtonView.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJOtherView.h"
#import "SCMJButtons.h"
@interface MJOtherView ()

@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *titles;

@end
@implementation MJOtherView
#pragma mark ************** init
- (id)initWithTitles:(NSArray *)titles
{
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        self.titles = titles;
        
        [self addSubviewsForView];
        
    }
    
    return self;
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
//    for (int i = 0; i < _titles.count; i++)
//    {
//        
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
//        button.titleLabel.font = systemFont(15);
//        button.backgroundColor = [UIColor clearColor];
//        [button setTitle:_titles[i] forState:0];
//        [button setTitleColor:[UIColor blackColor] forState:0];
//        [button setTitleColor:mainColor forState:UIControlStateSelected];
//        [button setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"xuanzhongshi"] forState:UIControlStateSelected];
//        [button setAdjustsImageWhenHighlighted:NO];
//        [button addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 100+i;
//        [self addSubview:button];
//        
//    }
    //直接取消高亮的方法
    for (int i = 0; i < _titles.count; i++)
    {
        
        SCMJButtons *button = [[SCMJButtons alloc]initWithFrame:CGRectZero];
        button.titleLabel.font = systemFont(15);
        [button setTitle:_titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:mainColor forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"xuanzhongshi"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [self addSubview:button];
        
    }
}


#pragma mark ************** 隐藏线条
- (void)setIsHideLineView:(BOOL)isHideLineView
{
    self.lineView.hidden = isHideLineView;
}
#pragma mark ************** 点击事件
- (void)optionButtonClick:(UIButton *)sender
{
    
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = YES;
    self.tempBtn = sender;
    
    if(self.btnClickBlock)
    self.btnClickBlock(sender.tag - 100);
}

#pragma mark ************** 父控件布局完成
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btn_W = self.frame.size.width/self.titles.count;
    
    CGFloat btn_H = self.frame.size.height;

    for(int i = 0; i < self.titles.count; i++)
    {
        UIButton *subView = (UIButton *)[self viewWithTag:100+i];
        subView.frame = CGRectMake(i* btn_W, 0, btn_W, btn_H);
        
        if(self.index == i)
        {
            subView.selected = YES;
            self.tempBtn = subView;
        }
   
    }

}
@end
