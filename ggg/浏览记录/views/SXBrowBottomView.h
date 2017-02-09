//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SXBrowBottomView : UIView

@property (nonatomic,copy) void(^BtnClick)(BOOL isSelect);

@property (nonatomic,copy) void(^btnTitleClick)(NSString *title);



@end
