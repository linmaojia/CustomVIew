//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSXPJModel.h"
@interface SCSXPJTableVIewCell : UITableViewCell

@property (nonatomic,copy) void(^cellImgBlack)();

@property (nonatomic,copy) void(^cellProductBlack)(NSString *productID);


@property (nonatomic,strong) SCSXPJModel *model;


@end
