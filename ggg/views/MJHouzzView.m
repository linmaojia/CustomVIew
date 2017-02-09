//
//  YZGAlertView.m
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJHouzzView.h"



@interface MJHouzzView()
{
    NSInteger row;
    CGFloat btn_W;
    BOOL isShow;
   
}
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGRect btnFrame;
@property (nonatomic, assign) Orientation orientation;

@end

@implementation MJHouzzView
#pragma mark **************** init
- (UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]init];
        _bgView.center = self.center;
        _bgView.layer.cornerRadius = btn_W/2;
        _bgView.clipsToBounds = YES;
        _bgView.backgroundColor = [UIColor grayColor];
    }
    return _bgView;
}
- (id)initWithImageArray:(NSArray *)imageArray Btnframe:(CGRect)btnframe Orientation:(Orientation)orientation
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (self = [super initWithFrame:keyWindow.frame])
    {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        
        self.btnFrame = btnframe;
        self.imageNames = imageArray;
        self.orientation = orientation;
        
    }
    return self;
}
#pragma mark **************** 设置器
- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    [self addSubviewsForView];
    
    [self show];
    
}
#pragma mark **************** 重新布局
- (void)setSuperFrame:(CGRect)superFrame SubFrame:(CGRect)subFrame Orientation:(Orientation)orientation
{
    self.orientation = orientation;
    
    self.frame = superFrame;

    self.btnFrame = subFrame;
    
    [self layoutBtnSubView];
    
}
- (void)layoutBtnSubView
{
    
    if(self.orientation == vertical)
    {
        
        self.bgView.frame = CGRectMake(self.btnFrame.origin.x, self.btnFrame.origin.y - (_imageNames.count - 1) * btn_W, btn_W, btn_W *_imageNames.count);
        
        for (int i = 0; i < _imageNames.count; i++) {
            
            UIButton *button = (UIButton *)[self.bgView viewWithTag:100+i];
            
            button.frame = CGRectMake(0, i * btn_W, btn_W, btn_W);
        }
    }
    if(self.orientation == horizontal)
    {
        
        self.bgView.frame = CGRectMake(self.btnFrame.origin.x, self.btnFrame.origin.y - (row - 1) * btn_W, btn_W *2, btn_W *row);
        
        int index = 0;
        
        for(int j = 0; j < row; j++)
        {
            for (int i = 0; i < 2; i++)
            {
                UIButton *button = (UIButton *)[self.bgView viewWithTag:100+index];
                
                button.frame = CGRectMake(i * btn_W, j * btn_W, btn_W, btn_W);
                
                index ++;
                
                if(index == _imageNames.count)
                {
                    break;
                }
            }
            
        }
    }
    
   
}


#pragma mark ************** 按钮被点击
-(void)btnClick:(UIButton *)sender
{
    [self dismiss];
    if(self.indexChangeBlock)
    self.indexChangeBlock(sender.tag - 100);
}
#pragma mark ************** 消失
- (void)dismiss
{
     for(UIButton *button in _bgView.subviews)
     {
         button.hidden = YES;
     }
    [UIView animateWithDuration:0.15 animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0];
        
        self.bgView.frame = self.btnFrame;
        
    } completion:^(BOOL finished) {

        
        [self removeFromSuperview];
    }];
}
#pragma mark ************** 显示
- (void)show {
    
    [UIView animateWithDuration:0.15f animations:^{
        
        [self setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
        
        if(self.orientation == horizontal)
        {
            self.bgView.frame = CGRectMake(self.btnFrame.origin.x, self.btnFrame.origin.y - (row - 1) * btn_W, btn_W *2, btn_W *row);
           
        }
        if(self.orientation == vertical)
        {
            self.bgView.frame = CGRectMake(self.btnFrame.origin.x, self.btnFrame.origin.y - (_imageNames.count - 1) * btn_W, btn_W, btn_W *_imageNames.count);
        }

    } completion:^(BOOL finished) {

        isShow = YES;
    }];
}

#pragma mark ************** 创建视图
- (void)addSubviewsForView
{
    btn_W = self.btnFrame.size.width;
    
    [self addSubview:self.bgView];
 
    self.bgView.frame = self.btnFrame;
    
    row = _imageNames.count / 2 + _imageNames.count % 2;
    
    int index = 0;
    
    for(int j = 0; j < row; j++)
    {
        for (int i = 0; i < 2; i++)
        {
            
            UIButton *button=[[UIButton alloc]init];
            button.frame = CGRectMake(i * btn_W, j * btn_W, btn_W, btn_W);
            [button setImage:[UIImage imageNamed:_imageNames[index]] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            button.tag = 100 + index;
            [self.bgView addSubview:button];
          
            index++;
           
            if(index == _imageNames.count)
            {
                break;
            }
            
        }
        
    }

    
}




@end
