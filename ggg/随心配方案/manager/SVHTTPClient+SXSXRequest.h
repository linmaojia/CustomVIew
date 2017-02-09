



#import "SVHTTPClient.h"

typedef void (^TypeParamCallback)(NSArray *typeParamCallback);

typedef void (^ListArrayCallback)(NSArray *listArray);

typedef void (^SXPImageUpLoadCallback)(BOOL state, NSString *picUrl);

typedef void (^StateTypeCallback)(BOOL state);


@interface SVHTTPClient (SXSXRequest)


//获取类型列表的参数项
+ (void)getSXPTypeWithTarget:(id)target param:(NSString *)param callback:(TypeParamCallback)callback;


/* 获取随心配方案列表*/
+ (void)getSXPListWithTarget:(id)target param:(NSDictionary *)param callback:(ListArrayCallback)callback;

//上传随心配图片
+ (void)upLoadSXPWithImage:(UIImage *)image callBack:(SXPImageUpLoadCallback)callback;

//随心配方案保存
+ (void)saveSXPWithDic:(NSMutableDictionary *)param callback:(StateTypeCallback)callback;

@end
