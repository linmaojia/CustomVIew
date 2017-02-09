//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJMoreButtonView.h"

@interface MJMoreButtonView()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectImages;
@property (nonatomic, strong) UIButton *tempLabBtn;
@property (nonatomic, strong) UIButton *tempImgBtn;

@end

@implementation MJMoreButtonView
#pragma mark ************** init
- (id)initWithTitles:(NSArray *)titles Images:(NSArray *)images SelectImages:(NSArray *)selectImages
{
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        self.titles = titles;
        
        self.images = images;
        
        self.selectImages = selectImages;

        [self addSubviewsForView];
        
    }
    
    return self;
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    for (int i = 0; i < _titles.count; i++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        view.tag = 100+i;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
        [view addGestureRecognizer:tap];
        //图片
        UIButton *imgBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        imgBtn.userInteractionEnabled = NO;
        [imgBtn setImage:[UIImage imageNamed:_images[i]] forState:0];
        [imgBtn setImage:[UIImage imageNamed:_selectImages[i]] forState:UIControlStateSelected];
        [imgBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [view addSubview:imgBtn];
        imgBtn.tag = 200+i;

        //文本
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
        button.userInteractionEnabled = NO;
        button.titleLabel.font = systemFont(14);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:_titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:mainColor forState:UIControlStateSelected];
        button.tag = 300+i;
        [view addSubview:button];
      
    }
}

#pragma mark ************** subView点击事件
- (void)viewClick:(UITapGestureRecognizer *)sender
{
    UIView *subView = (UIView *)[self viewWithTag:sender.view.tag];
    UIButton *labBtn = (UIButton *)[subView viewWithTag:300+(sender.view.tag - 100)];
    UIButton *imgBtn = (UIButton *)[subView viewWithTag:200+(sender.view.tag - 100)];

    self.tempLabBtn.selected = !self.tempLabBtn.selected;
    self.tempImgBtn.selected = !self.tempImgBtn.selected;

    labBtn.selected = YES;
    imgBtn.selected = YES;

    self.tempLabBtn = labBtn;
    self.tempImgBtn = imgBtn;

    
    if(self.titleBlock)
    self.titleBlock(_titles[sender.view.tag - 100]);
}

#pragma mark ************** 父控件布局完成
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat view_W = self.frame.size.width/self.titles.count;
    
    CGFloat view_H = self.frame.size.height;
    
    CGFloat imageView_H = 40;
    
    CGFloat lab_H = 30;

    for(int i = 0; i < self.titles.count; i++)
    {
        UIView *subView = (UIView *)[self viewWithTag:100+i];
        subView.frame = CGRectMake(i* view_W, 0, view_W, view_H);
        //图片
        UIButton *imgBtn = (UIButton *)[subView viewWithTag:200+i];
        imgBtn.frame =  CGRectMake(0, 0, imageView_H, imageView_H);
        imgBtn.center = CGPointMake(view_W/2, view_H/2 - (lab_H/2));
        //文字
        UIButton *labBtn = (UIButton *)[subView viewWithTag:300+i];
        CGFloat titleLab_y = imgBtn.frame.origin.y + imgBtn.frame.size.height + lab_H/2;
        labBtn.frame =  CGRectMake(0, 0, view_W, lab_H);
        labBtn.center = CGPointMake(view_W/2, titleLab_y);
        
        if(self.index == i)
        {
            imgBtn.selected = YES;
            labBtn.selected = YES;

            self.tempLabBtn = labBtn;
            self.tempImgBtn = imgBtn;
            
        }
    }
    
}
@end
