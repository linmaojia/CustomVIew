//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRecordModle.h"
@interface SXBrowseSectionHeadView : UITableViewHeaderFooterView

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) SCRecordModle *model;

@property (nonatomic,copy) void(^headClickBlcok)();

@end
