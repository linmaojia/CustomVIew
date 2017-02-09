//
//  SCSXPJModel.h
//  ggg
//
//  Created by LXY on 16/12/9.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCOrderProductDetailModel.h"
@interface SCSXPJModel : NSObject

@property (nonatomic, copy) NSString *title;//测试标题
@property (nonatomic, copy) NSString *remark;//测试备注信息
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *space;
@property (nonatomic, copy) NSString *style;

@property (nonatomic, copy) NSString *schemeId;

@property (nonatomic, assign) NSInteger addDate;
@property (nonatomic, strong) NSDictionary *dataDetail;

@property (nonatomic, assign) BOOL isOpen;


@property (nonatomic, strong) NSArray<SCOrderProductDetailModel *> *productDetails;    /**< 介绍图片数组 */

@end
