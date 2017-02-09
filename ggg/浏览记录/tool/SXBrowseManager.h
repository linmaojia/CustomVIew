//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ListArrayCallback)(NSArray *listArray);


@interface SXBrowseManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic,copy) void(^AllSelect)(BOOL allSeclect);
/* 浏览列表*/
+ (void)getBrowseListWithTarget:(id)target param:(NSDictionary *)param callback:(ListArrayCallback)callback;
@end
