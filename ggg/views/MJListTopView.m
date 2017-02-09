//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJListTopView.h"

static float const btn_W = 80;
@interface MJListTopView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIScrollView *scroll;    /**< Scrollow视图 */
@property (nonatomic, strong) UIView *lineView;      /**< 顶部横线 */
@property (nonatomic, strong) UIImageView *Img;         /**<  右边图片 */
@property (nonatomic, assign) BOOL isShowMoreView;
@property (nonatomic, strong) UILabel *titleLab;             /**<  标签标题 */


@end

@implementation MJListTopView
#pragma mark ************** init
- (id)initWithTitles:(NSArray *)titles Frame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titles = titles;
     
        [self addSubviewsForView];
        
    }
    
    return self;
}
#pragma mark ************** 懒加载控件
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"    为你精选以下标签";
        _titleLab.backgroundColor = [UIColor whiteColor];
        _titleLab.hidden = YES;
    }
    return _titleLab;
}
- (UIImageView *)Img {
    if (!_Img) {
        _Img = [[UIImageView alloc] init];
        _Img.image = [UIImage imageNamed:@"icon_jian"];
        _Img.backgroundColor = [UIColor whiteColor];
        _Img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImgClick:)];
        [_Img addGestureRecognizer:tap];
    }
    return _Img;
}
- (UIScrollView *)scroll{
    
    if(!_scroll){
        _scroll=[[UIScrollView alloc] init];
        _scroll.contentSize=CGSizeMake(0, 0);
        _scroll.backgroundColor = RGB(247, 247, 247);
    }
    return _scroll;
}
#pragma mark ************** 图片点击
-(void)ImgClick:(UITapGestureRecognizer *)sender
{

    self.isShowMoreView = !self.isShowMoreView;
    
    self.titleLab.hidden = !self.titleLab.hidden;
    
    if(self.isShowTagButton)
    {
        self.isShowTagButton(self.isShowMoreView);
    }
    
    [self showImgAnimations];
  
}
#pragma mark ************** 图片点旋转
- (void)showImgAnimations
{
    [UIView animateWithDuration:0.3f animations:^{
        self.Img.transform = CGAffineTransformRotate(self.Img.transform,M_PI);
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}
- (void)setIndex:(NSInteger)index
{
    self.isShowMoreView = NO;
    
    self.titleLab.hidden = YES;
    
    [self showImgAnimations];
    
    UIButton *selectBtn = (UIButton *)[_scroll viewWithTag: index + 100];
    
    [self optionButtonClick:selectBtn];
}
#pragma mark ************** downView上的button点击事件
- (void)optionButtonClick:(UIButton *)sender
{
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = YES;
    self.tempBtn = sender;
    
    CGFloat sWidth = _scroll.frame.size.width;
    
     CGFloat lineView_W = [self getSizeByString:_titles[sender.tag - 100] AndFontSize:15].width;
    [UIView animateWithDuration:0.15 animations:^{
        
        self.lineView.size = CGSizeMake(lineView_W, 2);
        
        self.lineView.center = CGPointMake(sender.center.x, self.lineView.center.y);

       
        
    } completion:^(BOOL finished) {
        
        CGFloat offectX;
        
        if(sender.center.x > sWidth/2) //滚动到一半就偏移
        {

          if(sender.center.x >= self.scroll.contentSize.width - sWidth/2)//尾部判断
          {
              offectX = self.scroll.contentSize.width - sWidth;
              
             [self.scroll setContentOffset:CGPointMake(offectX,0) animated:YES];
          }
          else
          {
              offectX = sender.center.x - 2* btn_W;//中部判断
              
              [self.scroll setContentOffset:CGPointMake(offectX,0) animated:YES];
          }
           
   
        }
        else
        {
            [self.scroll setContentOffset:CGPointMake(0,0) animated:YES];//头部判断
        }
       
         //block回调
        if(self.topButtonClick)
        {
            self.topButtonClick(sender.tag - 100);
        }
        
    }];
}
#pragma mark ************** 计算文字所占大小
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 10;
    return size;
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    [self addSubview:self.scroll];
    
    [self addSubview:self.Img];
    
    [self addSubview:self.titleLab];
    
    
    CGFloat img_W = self.frame.size.height;
    
    CGFloat scroll_W = self.frame.size.width - img_W;
    
    CGFloat scroll_H = self.frame.size.height;
    
    CGFloat btn_H = scroll_H;
   
    
    
    _scroll.frame = CGRectMake(0, 0, scroll_W, scroll_H);
    
    _Img.frame = CGRectMake(scroll_W, 0, img_W, img_W);
    
    _titleLab.frame = _scroll.frame;
    
    
    
    CGSize size = CGSizeMake(20, btn_H); //第一个 label的起点
    CGFloat padding = 20.0;//间距
    
    
    //添加按钮
    for (int i = 0; i < _titles.count; i++)
    {
        CGFloat btn_W = [self getSizeByString:_titles[i] AndFontSize:15].width;
        
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(size.width, 0, btn_W, btn_H);
        button.titleLabel.font = systemFont(15);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:_titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:mainColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [_scroll addSubview:button];
        if(i == 0)
        {
            button.selected = YES;
            self.tempBtn = button;
        }
        
        size.width += btn_W + padding;
    }
    _scroll.contentSize=CGSizeMake(size.width, btn_H);

    //底部横线
    CGFloat lineView_H = 2;
    
    CGFloat lineView_W = [self getSizeByString:_titles[0] AndFontSize:15].width;
    
    UIButton *selectBtn = (UIButton *)[_scroll viewWithTag:100];
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(0, 0, lineView_W, lineView_H);
    _lineView.center = CGPointMake(selectBtn.center.x, scroll_H - lineView_H/2);
    _lineView.backgroundColor = mainColor;
     [_scroll addSubview:_lineView];
    

}

@end
