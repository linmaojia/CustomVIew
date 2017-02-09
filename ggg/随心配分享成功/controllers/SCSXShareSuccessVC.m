//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXShareSuccessVC.h"
#import "MJMoreBtnView.h"
@interface SCSXShareSuccessVC ()
@property (strong, nonatomic) IBOutlet UILabel *shaerLab;
@property (strong, nonatomic) IBOutlet UIButton *sxBtn;
@property (strong, nonatomic) IBOutlet UIButton *homeBtns;
@property (nonatomic, strong) MJMoreBtnView *mjMoreBtnView;

@end

@implementation SCSXShareSuccessVC

#pragma mark ************** 懒加载控件
- (MJMoreBtnView *)mjMoreBtnView{
    if(!_mjMoreBtnView){
       
        NSArray *imageArray = @[@"wxCicleshare",@"wxfriend",@"weixinCollect",@"QQfFriend"];
        NSArray *titleArray = @[@"微信好友",@"朋友圈",@"微信收藏",@"QQ"];
        ESWeakSelf;
        _mjMoreBtnView = [[MJMoreBtnView alloc]initWithTitles:titleArray Images:imageArray];
        
//        _mjMoreBtnView.titleBlock = ^(NSString *title)
//        {
//            [__weakSelf shaerWithTitle:title];
//        };
        
        
    }
    return _mjMoreBtnView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    
    _sxBtn.layer.borderWidth = 0.5;
    _sxBtn.backgroundColor = [UIColor whiteColor];
    _sxBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _sxBtn.layer.cornerRadius = 3;
    _sxBtn.layer.masksToBounds = YES;
    
    _homeBtns.layer.borderWidth = 0.5;
    _homeBtns.backgroundColor = [UIColor whiteColor];
    _homeBtns.layer.borderColor = [UIColor blackColor].CGColor;
    _homeBtns.layer.cornerRadius = 3;
    _homeBtns.layer.masksToBounds = YES;

}
#pragma mark ************** 随心配方案
- (IBAction)SXBtn:(id)sender {
    NSLog(@"---方案");
}
#pragma mark ************** 首页
- (IBAction)homeBtn:(id)sender {
    NSLog(@"----首页");
}
#pragma mark ************** 分享
- (void)shaerWithTitle:(NSString *)title
{
    //@[@"微信好友",@"朋友圈",@"微信收藏",@"QQ"];
    if([title isEqualToString:@"微信好友"])
    {
        
    }
    else if([title isEqualToString:@"朋友圈"])
    {
    
    }
    else if([title isEqualToString:@"微信收藏"])
    {
        
    }
    else
    {
        
    }
}
#pragma mark ************** 获取数据
- (void)getData
{
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    [self.view addSubview:self.mjMoreBtnView];


}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_mjMoreBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shaerLab.bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@80);
    }];
}
@end
