//
//  KViewController.m
//  ggg
//
//  Created by longma on 16/9/20.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "KViewController.h"
#import "MJHouzzView.h"
@interface KViewController ()
{
    MJHouzzView *view;
}

@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, assign) Orientation orientation;

@end

@implementation KViewController


#pragma mark ************** 系统方法
- (UIButton *)deleBtn {
    if (!_deleBtn) {
        _deleBtn=[[UIButton alloc]init];
        [_deleBtn setImage:[UIImage imageNamed:@"pan"] forState:UIControlStateNormal];
        _deleBtn.backgroundColor = [UIColor grayColor];
        _deleBtn.layer.cornerRadius = 35;
        _deleBtn.layer.masksToBounds = YES;
        [_deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _deleBtn;
}
#pragma mark ************** 按钮被点击
- (void)deleBtnClick:(UIButton *)sender
{
    ESWeakSelf;
    
    NSArray *array = @[@"pan",@"rule",@"pan",@"rule",@"pan",@"rule",@"pan"];

    view = [[MJHouzzView alloc]initWithImageArray:array Btnframe:self.deleBtn.frame Orientation:self.orientation];
    view.indexChangeBlock = ^(NSInteger index){
        
         [__weakSelf.deleBtn setImage:[UIImage imageNamed:array[index]] forState:0];
    };
    [self.view addSubview:view];
}

//测试发现横竖屏切换的时候，系统会响应一些函数，其中 viewWillLayoutSubviews就是之一。
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    //获取设备朝向
    UIDevice *device = [UIDevice currentDevice] ;
    
    switch (device.orientation) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
          self.deleBtn.frame = CGRectMake(20, SCREEN_HEIGHT - 100, 70, 70);
          self.orientation = horizontal;
          [view setSuperFrame:self.view.frame SubFrame:self.deleBtn.frame Orientation:horizontal];
        }
            NSLog(@"横屏--%@", NSStringFromCGRect(self.deleBtn.frame));
            break;
            
        case UIDeviceOrientationPortrait:
        {
            self.deleBtn.frame = CGRectMake(20, SCREEN_HEIGHT - 100, 70, 70);
            self.orientation = vertical;
             [view setSuperFrame:self.view.frame SubFrame:self.deleBtn.frame Orientation:vertical];
        }
          
            NSLog(@"竖屏--%@", NSStringFromCGRect(self.deleBtn.frame));
            break;

    }
    
    
}

#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.deleBtn];
    self.deleBtn.frame = CGRectMake(20, SCREEN_HEIGHT - 100, 70, 70);
   


    
}

@end
