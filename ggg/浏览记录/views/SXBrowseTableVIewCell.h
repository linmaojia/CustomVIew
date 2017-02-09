//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCFavoriteModel.h"
@interface SXBrowseTableVIewCell : UITableViewCell

@property (nonatomic,copy) void(^cellClickBlack)(NSString *title);
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) SCFavoriteModel *model;
@property (nonatomic,copy) void(^selectBlcok)();
@end
