//
//  SCFavoriteDetailModel.h
//  hysc
//
//  Created by AVGD-Jarvi on 16/10/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCFavoriteDetailModel : NSObject

@property (nonatomic, strong) NSString *path;    /**< 图片url */
@property (nonatomic, strong) NSString *brandName;    /**< 品牌名 */
@property (nonatomic, strong) NSString *style;    /**< 样式 */
@property (nonatomic, strong) NSString *productType;    /**< 产品类型 */
@property (nonatomic, strong) NSString *productPrice;    /**< 价格 */
@property (nonatomic, strong) NSString *dealerPurchasePrice;    /**< 现价 */
@property (nonatomic, strong) NSString *mallSalePrice;    /**< 成交价 */
@property (nonatomic, copy) NSString *specWidth;    //W
@property (nonatomic, copy) NSString *specHeight;       //H
@property (nonatomic, copy) NSString *specLength;       //D
@property (nonatomic, assign) BOOL isSelected;    /**< <#name#> */

@end
