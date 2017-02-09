//
//  SCSXPJModel.m
//  ggg
//
//  Created by LXY on 16/12/9.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXPJModel.h"

@implementation SCSXPJModel

+ (NSDictionary *)objectClassInArray{
    return @{@"productDetails" : [SCOrderProductDetailModel class]};
}
@end
