//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJMoreBtnView.h"

@interface MJMoreBtnView()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *images;


@end

@implementation MJMoreBtnView
#pragma mark ************** init
- (id)initWithTitles:(NSArray *)titles Images:(NSArray *)images
{
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        self.titles = titles;
        
        self.images = images;
        
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
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        view.tag = 100+i;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
        [view addGestureRecognizer:tap];
        //图片
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        titleImg.image = [UIImage imageNamed:_images[i]];
        [titleImg setContentMode:UIViewContentModeScaleAspectFit];
        [view addSubview:titleImg];
        titleImg.tag = 200+i;
        
        //文本
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.text = _titles[i];
        titleLab.backgroundColor = [UIColor clearColor];
        [view addSubview:titleLab];
        titleLab.tag = 300+i;
        
        //数量
        UILabel *countLable = [[UILabel alloc] initWithFrame:CGRectZero];
        countLable.hidden = YES;
        countLable.font = [UIFont systemFontOfSize:12];
        countLable.textAlignment = NSTextAlignmentCenter;
        countLable.textColor = [UIColor whiteColor];
        countLable.text = @"2";
        countLable.backgroundColor = [UIColor redColor];
        countLable.layer.cornerRadius = 10;
        countLable.layer.masksToBounds = YES;
        countLable.tag = 400+i;
        [view addSubview:countLable];
    }
}
- (void)setCountArray:(NSArray *)countArray
{
    
    for(int i = 0; i < countArray.count; i++)
    {
        
        UIView *subView = (UIView *)[self viewWithTag:100+i];
        UILabel *countLable = (UILabel *)[subView viewWithTag:400+i];
        CGRect frame = countLable.frame;
        NSString *text = countArray[i];
        
        if([text integerValue] > 0)
        {
            frame.size.width = 20;
            countLable.hidden = NO;
            if([text integerValue] > 99)
            {
               text = @"99+";
               frame.size.width = 30;
            }
        }
        else
        {
            countLable.hidden = YES;
        }
        countLable.frame = frame;
        countLable.text = text;
        
    }
}

#pragma mark ************** subView点击事件
- (void)viewClick:(UITapGestureRecognizer *)sender
{
    if(self.titleBlock)
    self.titleBlock(sender.view.tag - 100);
}

#pragma mark ************** 父控件布局完成
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat view_W = self.frame.size.width/self.titles.count;
    
    CGFloat view_H = self.frame.size.height;

    CGFloat lab_H = 30;
    
    CGFloat count_H = 20;
    
    CGFloat imageView_H = 40;
    
    CGFloat label_size = 14;
    if(self.imageView_H)
    {
        imageView_H = self.imageView_H;//存在赋值
    }
    if(self.label_size)
    {
        label_size = self.label_size;
    }
    if(self.label_H)
    {
        lab_H = self.label_H;
    }
   


    for(int i = 0; i < self.titles.count; i++)
    {
        UIView *subView = (UIView *)[self viewWithTag:100+i];
        subView.frame = CGRectMake(i* view_W, 0, view_W, view_H);
        //图片
        UIImageView *imageView = (UIImageView *)[subView viewWithTag:200+i];
        imageView.frame =  CGRectMake(0, 0, imageView_H, imageView_H);
        imageView.center = CGPointMake(view_W/2, view_H/2 - (lab_H/2));
        //文字
        UILabel *lable = (UILabel *)[subView viewWithTag:300+i];
        lable.font = [UIFont systemFontOfSize:label_size];
        CGFloat titleLab_y = imageView.frame.origin.y + imageView.frame.size.height + lab_H/2;
        lable.frame =  CGRectMake(0, 0, view_W, lab_H);
        lable.center = CGPointMake(view_W/2, titleLab_y);
        //数量
        UILabel *countLable = (UILabel *)[subView viewWithTag:400+i];
        CGFloat countLable_x = imageView.frame.origin.x + imageView.frame.size.width - count_H/2;
        CGFloat countLable_y = imageView.frame.origin.y - 5;
        countLable.frame =  CGRectMake(countLable_x, countLable_y, count_H, count_H);
        
    }
    
}
@end
