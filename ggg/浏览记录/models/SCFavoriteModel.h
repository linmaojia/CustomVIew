//
//  SCFavoriteModel.h
//  hysc
//
//  Created by AVGD-Jarvi on 16/10/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCFavoriteDetailModel.h"

@interface SCFavoriteModel : NSObject

@property (nonatomic, strong) SCFavoriteDetailModel *productDetail;
@property (nonatomic, strong) NSString *favoritesId;
@property (nonatomic, strong) NSString *recordId;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *brandCode;
@property (nonatomic, strong) NSString *invitationId;
@property (nonatomic, strong) NSString *addDate;
@property (nonatomic, assign) BOOL isSelected;    /**< <#name#> */
@end
