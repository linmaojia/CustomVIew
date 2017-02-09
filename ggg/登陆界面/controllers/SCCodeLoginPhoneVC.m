//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCCodeLoginPhoneVC.h"
#import "JKTextField.h"
#import "SCAuthCodePhoneVC.h"
#import "SVHTTPClient+Login.h"
#import "MJAlertView.h"
static float const TEXT_HEIGHT = 50;
@interface SCCodeLoginPhoneVC ()
@property(nonatomic, strong) JKTextField *phoneTF;
@property(nonatomic, strong) UIButton *commitButton;

@end

@implementation SCCodeLoginPhoneVC

#pragma mark ************** 懒加载控件
- (JKTextField *)phoneTF
{
    if(!_phoneTF)
    {
        _phoneTF = [[JKTextField alloc]init];
        _phoneTF.backgroundColor = [UIColor whiteColor];
        _phoneTF.placeholder = @"请输入用户名";
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.clearButtonMode=YES;
        _phoneTF.keyboardType=UIKeyboardTypeNumberPad; //设置键盘样式
        //左侧文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, TEXT_HEIGHT)];
        label.text = @"  手机号码:";
        label.font = [UIFont systemFontOfSize:14];
        _phoneTF.leftViewMode = UITextFieldViewModeAlways;
        _phoneTF.leftView = label;
        
    }
    return _phoneTF;
}
- (UIButton *)commitButton
{
    if(!_commitButton)
    {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(20, 200, SCREEN_WIDTH-40, 44);
        [_commitButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitButton.backgroundColor = RGB(210, 50, 50);
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton addTarget:self action:@selector(commitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _commitButton;
}

- (void)commitButtonAction:(UIButton *)button
{
    
    ESWeakSelf;
    [SVHTTPClient logoutWithWithPhoneNum:self.phoneTF.text Callback:^(BOOL registration) {
        if(registration)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SCAuthCodePhoneVC *VC = [[SCAuthCodePhoneVC alloc]init];
                VC.phoneString = __weakSelf.phoneTF.text;
                [__weakSelf.navigationController pushViewController:VC animated:YES];
                
            });
            
        }
        else
        {
            [__weakSelf showError];
        }
    }];
//    if ([RegExpValidate validateMobile:self.phoneTF.text])
//    {
//        ESWeakSelf;
//        [SVHTTPClient logoutWithWithPhoneNum:self.phoneTF.text Callback:^(BOOL registration) {
//            if(registration)
//            {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    SCAuthCodePhoneVC *VC = [[SCAuthCodePhoneVC alloc]init];
//                    VC.phoneString = __weakSelf.phoneTF.text;
//                    [__weakSelf.navigationController pushViewController:VC animated:YES];
//                    
//                });
//                
//            }
//            else
//            {
//                [__weakSelf showError];
//            }
//        }];
//    }
//    else
//    {
//        [SVProgressHUD showErrorWithStatus:@"手机号码格式错误！"];
//    }
    
    
    
}
- (void)showError
{
    ESWeakSelf;
    [MJAlertView showAlertViewWithTitle:@"此手机号是未注册用户，没有绑定手机号码，是否确认前往邀请码页进入系统或注册账号？" ConfirmBlock:^{
        NSLog(@"确定");
        [__weakSelf.navigationController popViewControllerAnimated:YES];
        
    } CancelBlock:^{
        NSLog(@"取消");
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"手机验证码登陆";
    self.view.backgroundColor = RGB(243, 239, 236);

}
#pragma mark ************** 获取数据
- (void)getData
{

    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.commitButton];

    _phoneTF.frame = CGRectMake(0, 0, SCREEN_WIDTH, TEXT_HEIGHT);
    _commitButton.frame = CGRectMake(20, 70, SCREEN_WIDTH-40, 44);

}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   

}

@end
