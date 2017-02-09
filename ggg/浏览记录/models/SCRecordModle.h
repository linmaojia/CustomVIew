//
//  SCRecordModle.h
//  hysc
//
//  Created by AVGD-Jarvi on 16/11/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCFavoriteModel.h"

@interface SCRecordModle : NSObject

@property (nonatomic, assign) BOOL isSelected;    /**< <#name#> */
@property (nonatomic, strong) NSString *label;    /**< <#name#> */
@property (nonatomic, strong) NSMutableArray <SCFavoriteModel *>*fModel;    /**< <#name#> */

@end
