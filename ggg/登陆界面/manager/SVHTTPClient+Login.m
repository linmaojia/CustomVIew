//
//  SVHTTPClient+Login.m
//  hysc
//
//  Created by AVGD-Jarvi on 16/9/22.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SVHTTPClient+Login.h"

@implementation SVHTTPClient (Login)

/**
 *  @author Kim, 16-02-26 15:02:50
 *
 *  密钥加密(clientSecre+timestamp)进行md5加密
 *
 *  @param clientSecret 密钥
 *
 *  @return 客户端密钥（有效期为10分钟）
 */
+ (NSString *)clientSecretEncrypt
{
    NSDate *date = [[NSDate alloc] init];
    NSString *timestamp = date.timestamp;
    
    //拼接后的字符串
    NSString *newString = [[NSString alloc] initWithFormat:@"%@%@",ClientSecret, timestamp];
    
    return newString.md5;
}
+ (void)getPhoneAccessTokenWithAuthorizationCode:(NSString *)authorizationCode callback:(PhoneAccessTokenCallback)callback
{
    [SVProgressHUD show];
    [[SVHTTPClient sharedClient] POST:APIGetAccessToken parameters:@{@"code":authorizationCode,@"clientId":ClientId,@"grantType":@"authorization_code",@"clientSecret":[self clientSecretEncrypt],@"timestamp":[[NSDate alloc] init].timestamp} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }
        else
        {
            [SVProgressHUD dismiss];
            
            callback(response[@"accessToken"], [response[@"expiresIn"] floatValue]);
        }
        
    }];
}

+ (void)getPhoneAuthorizationCodeWithClientId:(NSString *)clientId account:(NSString *)account loginCode:(NSString *)loginCode callback:(PhoneAuthorizationCodeCallback)callback
{
    [SVProgressHUD show];
    [[SVHTTPClient sharedClient] POST:APIPhoneGetAuthorizationCode parameters:@{@"clientId":clientId,@"responseType":@"code",@"scope":@"EDSMobileApp", @"state":@"[fiemq", @"mobile":account,@"code":loginCode} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"数据获取失败\n请检查网络连接是否正常"];
            }
            
            callback(nil,NO);
        }
        else
        {
            [SVProgressHUD dismiss];
            
            if ([response[@"code"] isEqualToString:@""]) {
                callback(response[@"telNo"],NO);
            } else {
                callback(response[@"code"],YES);
            }
        }
        
    }];
}


+ (void)findPasswordWithPhoneNum:(NSString *)phoneNum templateCode:(NSString *)templateCode callback:(FindPasswordCallback)callBack
{
    [SVProgressHUD show];
    [[SVHTTPClient sharedClient] GET:APIGetMobileCode parameters:@{@"mobilePhone":phoneNum, @"templateCode":templateCode} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }
        else
        {
            NSString *successString = response[@"message"];
            [SVProgressHUD showSuccessWithStatus:successString];
            callBack(YES);
        }
        
    }];
}

/* 判断手机号码是否是已注册账号*/
+ (void)logoutWithWithPhoneNum:(NSString *)phoneNum Callback:(PhoneRegistCallBack)callBack
{
     [SVProgressHUD show];
    [[SVHTTPClient sharedClient] GET:APISXPPhoneRegist parameters:@{@"mobilePhone":phoneNum} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(error)
        {
            callBack(NO);
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:response[@"message"]];
            callBack(YES);
        }
        
    }];

    
}
@end
