//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SCSXPJManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) void(^cellImgBlack)();
@property (nonatomic,copy) void(^cellProductBlack)(NSString *productID);

@property (nonatomic, strong) NSMutableArray *dataArray;
/* */

+ (CGFloat)HeightWithText:(NSString *)text constrainedToWidth:(CGFloat)width LabFont:(UIFont *)font;

@end
