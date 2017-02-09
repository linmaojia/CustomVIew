//
//  SCOrderProductDetailModel.h
//  hysc
//
//  Created by AVGD-Jarvi on 16/10/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCOrderProductDetailModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *dealerPurchasePrice;
@property (nonatomic, strong) NSString *specLength;
@property (nonatomic, strong) NSString *specWidth;
@property (nonatomic, strong) NSString *specHeight;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *stock;
@property (nonatomic, strong) NSString *mallSalePrice;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *productNum;
@property (nonatomic, strong) NSString *productStock;
@property (nonatomic, strong) NSString *virtualQty;

@end
