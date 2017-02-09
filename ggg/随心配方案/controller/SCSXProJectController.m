//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXProJectController.h"
#import "SVHTTPClient+SXSXRequest.h"
#import "SCSXPJManager.h"
#import "SCSXPJTableVIewCell.h"
#import "SCSXPJModel.h"
#import "SCSXTopView.h"
#import "SCSXSaveModel.h"
@interface SCSXProJectController ()
@property (nonatomic, strong) SCSXPJManager *manager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SCSXTopView *topView;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSMutableDictionary *param;//请求参数

@end

@implementation SCSXProJectController

#pragma mark ************** 懒加载控件
- (SCSXTopView *)topView {
    if (!_topView) {
        ESWeakSelf;
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        NSArray *titleArray = @[@"时间",@"空间",@"风格"];
        _topView = [[SCSXTopView alloc]initWithTitles:titleArray Frame:frame];
        _topView.btnClickBlock = ^(BOOL isShow){
            [__weakSelf isShowWithBool:isShow];
        };
        _topView.titleClickBlock = ^(SCSXSaveModel *model){
           //根据标题网络请求
            NSLog(@"%@被点击",model.name);
            [__weakSelf loadForTitleWith:model];

        };
       
    }
    return _topView;
}
- (void)loadForTitleWith:(SCSXSaveModel *)model
{
    [_param removeAllObjects];
    //空间：011 ， 风格：010 ，
    if([model.dictid isEqualToString:@"011"])
    {
         [_param setObject:model.name forKey:@"spaceName"];
    }
    else if([model.dictid isEqualToString:@"010"])
    {
         [_param setObject:model.name forKey:@"styleName"];
    }
    else
    {
        if([model.name isEqualToString:@"一周内"])
        {
             [_param setObject:@"1" forKey:@"dateType"];
        }
        if([model.name isEqualToString:@"一个月内"])
        {
            [_param setObject:@"2" forKey:@"dateType"];
        }
        if([model.name isEqualToString:@"三个月内"])
        {
            [_param setObject:@"3" forKey:@"dateType"];
        }
    }
    _pageNum = 1;
    [self getDataWithPageNum:_pageNum];
    
}
- (void)isShowWithBool:(BOOL)isShow
{
    if(isShow)
    {
        [self.view bringSubviewToFront:self.topView];
    }
    else
    {
        [self.view bringSubviewToFront:self.tableView];
    }

}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self.manager;
        _tableView.dataSource = self.manager;
        _tableView.backgroundColor = RGB(243, 239, 236);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SCSXPJTableVIewCell class] forCellReuseIdentifier:@"SCSXPJTableVIewCell"];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [__weakSelf getDataWithPageNum:++__weakSelf.pageNum];
        }];
        _tableView.mj_footer.hidden = YES;

    }
    return _tableView;
}
- (SCSXPJManager *)manager {
    if (!_manager) {
        ESWeakSelf;
        _manager = [[SCSXPJManager alloc]init];
        _manager.cellImgBlack = ^(){
            NSLog(@"--点击编辑---");
        };
        _manager.cellProductBlack = ^(NSString *productID){
            NSLog(@"---我是产品id--%@",productID);
        };
    }
    return _manager;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    _pageNum = 1;
    
    [self getDataType];
    
   
}
#pragma mark ************** 获取类型数组
- (void)getDataType
{
    /*  010 - 风格  011 - 空间*/
    ESWeakSelf;
    [SVProgressHUD show];
    [SVHTTPClient getSXPTypeWithTarget:self param:@"010" callback:^(NSArray *sceneParamArray) {
        
        __weakSelf.topView.styleArray = [SCSXSaveModel mj_objectArrayWithKeyValuesArray:sceneParamArray];
        
        [SVHTTPClient getSXPTypeWithTarget:self param:@"011" callback:^(NSArray *sceneParamArray) {
            
            __weakSelf.topView.roomArray = [SCSXSaveModel mj_objectArrayWithKeyValuesArray:sceneParamArray];
        
             [__weakSelf getDataWithPageNum:__weakSelf.pageNum];
        }];
        
    }];
    
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"随心配方案";
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(newAction)];
    self.navigationItem.rightBarButtonItem = editItem;
    
    _param = [NSMutableDictionary dictionary];

}
#pragma mark ************** 点击新增
- (void)newAction
{
}
#pragma mark ************** 获取随心配数据
- (void)getDataWithPageNum:(NSInteger)pageNum
{
    if(pageNum == 1)
    {
         [SVProgressHUD show];
        
        [self.tableView.mj_footer resetNoMoreData];
        
         [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    [_param setObject:@(pageNum) forKey:@"pageNumber"];
    [_param setObject:@5 forKey:@"rowsPerPage"];

    ESWeakSelf;
    [SVHTTPClient getSXPListWithTarget:self param:_param callback:^(NSArray *listArray) {
        
         pageNum == 1? [self.manager.dataArray removeAllObjects]:nil;
        
         [SVProgressHUD dismiss];
        
        __weakSelf.tableView.mj_footer.hidden = NO;
        
        [__weakSelf.tableView.mj_footer endRefreshing];
        
        NSArray *ListArray = [SCSXPJModel mj_objectArrayWithKeyValuesArray:listArray];
        
        listArray.count == 0?[__weakSelf.tableView.mj_footer endRefreshingWithNoMoreData]:nil;
     
        
        if(!__weakSelf.manager.dataArray)
        {
            __weakSelf.manager.dataArray = [NSMutableArray array];
        }
        [__weakSelf.manager.dataArray addObjectsFromArray:ListArray];
        
        [__weakSelf.tableView reloadData];
    }];


}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
   

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.right.left.bottom.equalTo(self.view);

    }];
}
@end
