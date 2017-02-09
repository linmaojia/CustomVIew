//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRankingListLabView.h"

@interface YZGRankingListLabView()<UIScrollViewDelegate>
{
    
    CGFloat self_width,self_height,bgView_H,bgView_W;//按钮背景高度
}
@property (nonatomic, strong) UIView *btnBgView;   /**< 按钮背景 */
@property (nonatomic, strong) UIButton *tempBtn;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger index;

@end

@implementation YZGRankingListLabView
#pragma mark ************** init
- (id)initWithTitles:(NSArray *)titles Index:(NSInteger )index
{
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        
        self.titles = titles;
        
        self.index = index;
        
        [self addSubviewsForView];
        
        [self show];
        
    }
    
    return self;
}

#pragma mark ************** 懒加载控件
- (UIView *)btnBgView
{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc] init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    }
    return _btnBgView;
}

- (void)tagButtonClick:(UIButton *)sender
{
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = YES;
    self.tempBtn = sender;
    self.index = sender.tag - 100;
    
    [self dismiss];
    
}
#pragma mark ************** 计算文字所占大小
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 20;
    return size;
}
#pragma mark ************** 显示
- (void)show
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        _btnBgView.frame = CGRectMake(0, 0, bgView_W, bgView_H);
        
        
    } completion:nil];
    
}
#pragma mark ************** 消失
- (void)dismiss
{
    [UIView animateWithDuration:0.4f  animations:^{
        
        [self setBackgroundColor:RGBA(0, 0, 0, 0)];
        
        _btnBgView.frame = CGRectMake(0, - bgView_H, bgView_W, bgView_H);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    //回调
    if(self.tagButtonClick)
        self.tagButtonClick(self.index);

}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{

    [self addSubview:self.btnBgView];
    
    bgView_W = SCREEN_WIDTH;
    
    _btnBgView.frame = CGRectMake(0, -150, bgView_W, 150);
    
    CGSize size = CGSizeMake(10, 40); //第一个 label的起点
    
    CGFloat padding = 10.0;//间距
    
    CGFloat btn_H = 20;
    
    for (int i = 0; i < _titles.count; i ++)
    {
        CGFloat btn_W = [self getSizeByString:_titles[i] AndFontSize:14].width;
        if (btn_W > bgView_W)
        {
            btn_W = bgView_W;
        }
        if (bgView_W - size.width < btn_W)
        {
            size.height += btn_H + padding;
            
            size.width = 10.0;
        }
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(size.width, size.height - 30, btn_W, btn_H);
        button.titleLabel.numberOfLines = 0;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 8.0;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [_btnBgView addSubview:button];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == self.index)//改变颜色
        {
            self.tempBtn = button;
            self.tempBtn.selected = YES;
        }
        
        size.width += btn_W + padding;
    }
    
       bgView_H = size.height;
    
}

@end
