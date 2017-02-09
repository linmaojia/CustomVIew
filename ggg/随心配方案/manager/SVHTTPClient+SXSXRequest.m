

#import "SVHTTPClient+SXSXRequest.h"


@implementation SVHTTPClient (SXSXRequest)

+ (void)getSXPTypeWithTarget:(id)target param:(NSString *)param callback:(TypeParamCallback)callback
{
 
    [[SVHTTPClient sharedClient] GET:[NSString stringWithFormat:@"%@%@", APISXPSceneParam, param] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
         if(!error)
         {
            callback(response);
           
         }
         else
         {
            [SVProgressHUD showErrorWithStatus:@"请求出错"];
         }
        
       
    }];
}
+ (void)getSXPListWithTarget:(id)target param:(NSDictionary *)param callback:(ListArrayCallback)callback
{
   
   
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    [[SVHTTPClient sharedClient] GET:APISXPSchemeList parameters:param completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"请求出错"];
        }
        else
        {
           
            callback(response);
        }
        
    }];
}


//上传随心配图片
+ (void)upLoadSXPWithImage:(UIImage *)image callBack:(SXPImageUpLoadCallback)callback
{
    [SVProgressHUD showWithStatus:@"正在上传"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = NO;
    
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].timeoutInterval = 20;
    
    [[SVHTTPClient sharedClient] POST:APISXPImageUpLoad parameters:@{@"picture": imageData} progress:^(float progress) {
        
    } completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                if ([error.localizedDescription isEqualToString:@"The operation timed out."]) {
                    [SVProgressHUD showErrorWithStatus:@"请求超时"];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"上传失败"];
                }
            }
            callback(NO,nil);
        }
        else {
            //[SVProgressHUD showSuccessWithStatus:@"上传成功"];
            callback(YES,response[@"imgPath"]);
            
        }
        
    }];
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//随心配方案保存
+ (void)saveSXPWithDic:(NSMutableDictionary *)param callback:(StateTypeCallback)callback
{
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    [[SVHTTPClient sharedClient] POST:APISXPSave parameters:param completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"请求出错"];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:response[@"message"]];
            callback(YES);
        }
        
    }];
}
@end
