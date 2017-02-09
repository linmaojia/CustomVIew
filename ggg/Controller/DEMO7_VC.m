//
//  DEMO1_VC.m
//  ggg
//
//  Created by LXY on 16/9/29.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO7_VC.h"
#import "MJListTopView.h"
#import "YZGRankingListLabView.h"

@interface DEMO7_VC ()
{
  YZGRankingListLabView *centerView;
}
@property (nonatomic, strong) MJListTopView *topView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger index;

@end

@implementation DEMO7_VC
- (MJListTopView *)topView {
    if (!_topView) {
        ESWeakSelf;
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        _topView = [[MJListTopView alloc] initWithTitles:_titles Frame:frame];
        _topView.topButtonClick = ^(NSInteger index)
        {
             NSLog(@"--%ld",index);
            __weakSelf.index = index;
        };
        _topView.isShowTagButton = ^(BOOL flag){
            NSLog(@"--%d",flag);
            [__weakSelf isShowTagButtonAction:flag];
        };
        
    }
    return _topView;
}
#pragma mark ************** 是否显示标签按钮
- (void)isShowTagButtonAction:(BOOL)flag
{
    if(flag == YES)
    {
        ESWeakSelf;
        CGFloat origin_y =  50;
        CGFloat height = SCREEN_HEIGHT - 64 -origin_y;
        centerView = [[YZGRankingListLabView alloc] initWithTitles:_titles Index:_index];
        centerView.frame = CGRectMake(0, origin_y, SCREEN_WIDTH, height);
        centerView.tagButtonClick = ^(NSInteger index)
        {
            __weakSelf.index = index;

            __weakSelf.topView.index = index;
        };
        [self.view insertSubview:centerView atIndex:0];//最低层
        
    }
    else
    {
        [centerView dismiss];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
}

-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    [SVProgressHUD dismiss];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    _titles = @[@"耳机",@"U盘",@"手机",@"连衣裙",@"肉干肉蒲",@"餐桌",@"饮料冲调",@"大家电",@"粮油调味",@"流行男鞋",@"中外名酒",@"进口食品",@"男装",@"面部护肤",@"清洁用品"];
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.topView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
  
 
}



@end
