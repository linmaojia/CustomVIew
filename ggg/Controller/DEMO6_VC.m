//
//  DEMO1_VC.m
//  ggg
//
//  Created by LXY on 16/9/29.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO6_VC.h"
#import "MJMoreBtnView.h"
#import "MJSegmentedView.h"
#import "MJMoreButtonView.h"
@interface DEMO6_VC ()

@property (nonatomic, strong) MJMoreBtnView *mjMoreBtnView;
@property (nonatomic, strong) MJSegmentedView *titleView;
@property (nonatomic, strong) MJMoreButtonView *moreButton;
@property (nonatomic, strong) MJMoreBtnView *buttonView;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation DEMO6_VC
- (MJMoreBtnView *)buttonView{
    if(!_buttonView){
        
        NSArray *imageArray = @[@"icon_download",@"tab_service",@"tab_collect",@"icon_shopping_gray"];
        NSArray *titleArray = @[@"下载",@"客服",@"收藏",@"购物车"];
        
        _buttonView = [[MJMoreBtnView alloc]initWithTitles:titleArray Images:imageArray];
        _buttonView.backgroundColor = [UIColor whiteColor];
        _buttonView.imageView_H = 20;
        _buttonView.label_size = 11;
        _buttonView.label_H = 20;
        
        _buttonView.titleBlock = ^(NSInteger index)
        {
            NSLog(@"----%@",titleArray[index]);
        };
        
        
    }
    return _buttonView;
}
- (MJMoreBtnView *)mjMoreBtnView{
    if(!_mjMoreBtnView){

        NSArray *imageArray = @[@"icon_obligation",@"icon_committed",@"icon_Receipt",@"icon_order"];
        NSArray *titleArray = @[@"待付款",@"待发货",@"待收货",@"我的订单"];
        
        _mjMoreBtnView = [[MJMoreBtnView alloc]initWithTitles:titleArray Images:imageArray];
        
        _mjMoreBtnView.titleBlock = ^(NSInteger index)
        {
            NSLog(@"----%@",titleArray[index]);
        };
       
    }
    return _mjMoreBtnView;
}
- (MJMoreButtonView *)moreButton{
    if(!_moreButton){
        
        /*
         boore_changtu_mor
         boore_changtu
         boore_lianjie_mor
         boore_lianjie
         */
        NSArray *imageArray = @[@"boore_lianjie_mor",@"boore_changtu_mor",@"boore_lianjie_mor",@"boore_changtu_mor"];
        NSArray *selectArray = @[@"boore_lianjie",@"boore_changtu",@"boore_lianjie",@"boore_changtu"];
        NSArray *titleArray = @[@"分享链接",@"分享图片",@"分享QQ",@"分享微信"];
        
        _moreButton = [[MJMoreButtonView alloc]initWithTitles:titleArray Images:imageArray SelectImages:selectArray];
        
        _moreButton.titleBlock = ^(NSString *title)
        {
            NSLog(@"----%@",title);
        };
        
        
    }
    return _moreButton;
}
- (MJSegmentedView *)titleView {
    if (!_titleView) {
        _titleView = [[MJSegmentedView alloc] initWithTitles:@[@"全部", @"待付款", @"待发货", @"待收货", @"已完成"]];
        _titleView.btnClickBlock = ^(NSInteger index)
        {
            NSLog(@"--%ld",index);
        };
    }
    return _titleView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    //布局是在异步执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
        NSArray *countArray = @[@"0",@"4",@"100"];
        
        _mjMoreBtnView.countArray = countArray;
        
        //收藏
        
        UIView *subView = (UIView *)[_buttonView viewWithTag:100+2];
        UIImageView *imageView = (UIImageView *)[subView viewWithTag:200+2];
        imageView.image = [UIImage imageNamed:@"tab_collect_in"];
    });

    
}
- (void)viewWillAppear:(BOOL)animated
{
  
}
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    [SVProgressHUD dismiss];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.mjMoreBtnView];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.moreButton];
    [self.view addSubview:self.buttonView];

    


}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_mjMoreBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    
    
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mjMoreBtnView.bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@45);
    }];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@80);

    }];
    
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH-100));

    }];
    

    
    
  
}



@end
