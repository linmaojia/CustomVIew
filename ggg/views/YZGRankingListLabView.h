//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/*标签View*/
@interface YZGRankingListLabView : UIView

@property (nonatomic,copy) void(^tagButtonClick)(NSInteger index);  //block回调

- (void)dismiss;

- (id)initWithTitles:(NSArray *)titles Index:(NSInteger )index;

@end
