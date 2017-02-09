//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCAuthCodePhoneVC.h"
#import "JKTextField.h"
#import "JKCountDownButton.h"
#import "SVHTTPClient+Login.h"
static float const TEXT_HEIGHT = 50;  /**< 文本框高度 */
@interface SCAuthCodePhoneVC ()
@property(nonatomic, strong) UIButton *commitButton;
@property(nonatomic, strong) UIView *codeView;
@property(nonatomic, strong) JKTextField *authCodeTF;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation SCAuthCodePhoneVC

#pragma mark ************** 懒加载控件
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(14);
        _titleLab.text = @"查看详情";
        _titleLab.textColor = [UIColor grayColor];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}
- (JKTextField *)authCodeTF
{
    if(!_authCodeTF)
    {
        _authCodeTF = [[JKTextField alloc] init];
        _authCodeTF.keyboardType= UIKeyboardTypeNumberPad;
        _authCodeTF.clearButtonMode=YES;
        _authCodeTF.font = [UIFont systemFontOfSize:15];
        _authCodeTF.backgroundColor = [UIColor whiteColor];
        //_authCodeTF.placeholder = @"输入号码";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, TEXT_HEIGHT)];
        label.text = @"   验证码";
        label.font = [UIFont systemFontOfSize:14];
        _authCodeTF.leftView = label;
        _authCodeTF.leftViewMode = UITextFieldViewModeAlways;//一定要加上
        
        //右边计时按钮
        _authCodeTF.rightView = self.codeView;
        _authCodeTF.rightViewMode = UITextFieldViewModeAlways;
        
        
    }
    return _authCodeTF;
}

//发送验证码
- (void)sendAuthCode
{
    [SVHTTPClient findPasswordWithPhoneNum:self.phoneString templateCode:@"1" callback:^(BOOL findPasswordState) {
           
    }];
}

- (UIView *)codeView
{
    if(!_codeView)
    {
        ESWeakSelf;
        _codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, TEXT_HEIGHT)];
        _codeView.backgroundColor = [UIColor whiteColor];
        
        JKCountDownButton *countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        countDownCode.layer.cornerRadius = 3;
        countDownCode.layer.masksToBounds = YES;
        countDownCode.backgroundColor = RGB(18, 140, 37);
        countDownCode.frame = CGRectMake(10, (TEXT_HEIGHT-35)/2, 80, 35);
        [countDownCode setTitle:@"获取验证码" forState:0];
        countDownCode.titleLabel.font = systemFont(13);
        [countDownCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // ESWeak_(countDownCode);
        [countDownCode customWithTime:10 ToucheBlock:^{
            
            [__weakSelf sendAuthCode];//发送验证码
            
            [countDownCode showTime];//第一次点击
            
        } NextToucheBlock:^{
            
            [countDownCode setTitle:@"点击重新获取" forState:0];//第二次点击
            [__weakSelf sendAuthCode];//发送验证码
        }];
        
        [_codeView addSubview:countDownCode];
        
    }
    return _codeView;
    
}
- (UIButton *)commitButton
{
    if(!_commitButton)
    {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitButton setTitle:@"马上进入" forState:UIControlStateNormal];
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
    [SVHTTPClient getPhoneAuthorizationCodeWithClientId:ClientId account:self.phoneString loginCode:self.authCodeTF.text callback:^(NSString *phoneAuthorizationCode, BOOL state) {
        if (phoneAuthorizationCode && state) {
            [SVHTTPClient getPhoneAccessTokenWithAuthorizationCode:phoneAuthorizationCode callback:^(NSString *accessToken, float outDate) {
                if(accessToken)
                {
                  
                }
            }];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"手机验证码登陆";
    self.view.backgroundColor = RGB(243, 239, 236);

}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.authCodeTF];
    [self.view addSubview:self.commitButton];
    
    _titleLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _authCodeTF.frame = CGRectMake(0, 40, SCREEN_WIDTH, TEXT_HEIGHT);
    _commitButton.frame = CGRectMake(20, 110, SCREEN_WIDTH-40, 44);
    
    NSString *phome = [NSString stringWithFormat:@"    请输入 %@ 收到的短信验证码",self.phoneString];
    _titleLab.text = phome;
}

@end
