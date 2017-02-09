//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
/**<  保存方案*/
@interface SCSXSaveProJectVC : YZGRootViewController
@property (nonatomic, strong) NSMutableDictionary *param;    /**< 随心配上传参数 */
@property (nonatomic, strong) UIImage *image;    /**< 随心配屏幕截图 */
@end
