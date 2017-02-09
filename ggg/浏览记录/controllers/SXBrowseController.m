//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SXBrowseController.h"
#import "SXBrowseManager.h"
#import "SXBrowseSectionHeadView.h"
#import "SXBrowseTableVIewCell.h"
#import "SXBrowBottomView.h"
@interface SXBrowseController ()
{
    BOOL isEdit;
    UIBarButtonItem *editItem;
}
@property (nonatomic, strong) SXBrowseManager *manager;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SXBrowBottomView *bottomView;

@end

@implementation SXBrowseController

#pragma mark ************** 懒加载控件
- (SXBrowBottomView *)bottomView {
    if (!_bottomView) {
        ESWeakSelf;
        _bottomView = [[SXBrowBottomView alloc]init];
        _bottomView.hidden = YES;
        _bottomView.BtnClick = ^(BOOL isSeclect){
        };
        _bottomView.btnTitleClick = ^(NSString *title){
        };
    }
    return _bottomView;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self.manager;
        _tableView.dataSource = self.manager;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        [_tableView registerClass:[SXBrowseTableVIewCell class] forCellReuseIdentifier:@"SXBrowseTableVIewCell"];
        [_tableView registerClass:[SXBrowseSectionHeadView class] forHeaderFooterViewReuseIdentifier:@"SXBrowseSectionHeadView"];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [__weakSelf getDataWithPageNum:++__weakSelf.pageNum];
        }];
        _tableView.mj_footer.hidden = NO;
    }
    return _tableView;
}

- (SXBrowseManager *)manager {
    if (!_manager) {
        ESWeakSelf;
        _manager = [[SXBrowseManager alloc]init];
        _manager.AllSelect = ^(BOOL allSeclect){
            [__weakSelf.tableView reloadData];
        };
    }
    return _manager;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _pageNum = 1;
    
    [self getDataWithPageNum:_pageNum];
}


- (void)backAction
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
   
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"浏览记录";
    editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(Action)];
    self.navigationItem.rightBarButtonItem = editItem;
   
    
}
#pragma mark ************** 更换编辑按钮文字
- (void)Action
{
    isEdit = !isEdit;
    isEdit == YES?[editItem setTitle:@"完成"]:[editItem setTitle:@"编辑"];
    self.manager.isShow = isEdit;
    _bottomView.hidden = !isEdit;
    [self.tableView reloadData];
}
#pragma mark ************** 获取数据
- (void)getDataWithPageNum:(NSInteger)pageNum
{
    if(pageNum == 1)
    {
        [SVProgressHUD show];
        
        [self.tableView.mj_footer resetNoMoreData];
        
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    ESWeakSelf;
    NSDictionary *dic = @{@"pageNumber":@(pageNum),@"rowsPerPage":@10};
    [SXBrowseManager getBrowseListWithTarget:self param:dic callback:^(NSArray *listArray) {
        pageNum == 1? [self.manager.dataArray removeAllObjects]:nil;
        
        [SVProgressHUD dismiss];
        
        __weakSelf.tableView.mj_footer.hidden = NO;
        
        [__weakSelf.tableView.mj_footer endRefreshing];
        
        listArray.count == 0?[__weakSelf.tableView.mj_footer endRefreshingWithNoMoreData]:nil;
        
        if(!__weakSelf.manager.dataArray)
        {
            __weakSelf.manager.dataArray = [NSMutableArray array];
        }
        [__weakSelf.manager.dataArray addObjectsFromArray:listArray];
        
        [__weakSelf.tableView reloadData];
    }];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}
@end
