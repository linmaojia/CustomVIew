//
//  SVHTTPClient+Login.h
//  hysc
//
//  Created by AVGD-Jarvi on 16/9/22.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SVHTTPClient.h"

//发送验证码状态
typedef void (^FindPasswordCallback)(BOOL findPasswordState);
//使用PhoneAuthorizationCode换取accessToken
typedef void (^PhoneAccessTokenCallback)(NSString *accessToken, float outDate);
//获取PhoneAuthorizationCode state:登录状态NO为EDS会员商城会员,YES为ETao会员
typedef void (^PhoneAuthorizationCodeCallback)(NSString *phoneAuthorizationCode, BOOL state);

typedef void(^PhoneRegistCallBack)(BOOL registration);

@interface SVHTTPClient (Login)

+ (void)getPhoneAccessTokenWithAuthorizationCode:(NSString *)authorizationCode callback:(PhoneAccessTokenCallback)callback;

+ (void)findPasswordWithPhoneNum:(NSString *)phoneNum templateCode:(NSString *)templateCode callback:(FindPasswordCallback)callBack;

+ (void)getPhoneAuthorizationCodeWithClientId:(NSString *)clientId account:(NSString *)account loginCode:(NSString *)loginCode callback:(PhoneAuthorizationCodeCallback)callback;




/* 判断手机号码是否是已注册账号*/
+ (void)logoutWithWithPhoneNum:(NSString *)phoneNum Callback:(PhoneRegistCallBack)callBack;

@end
