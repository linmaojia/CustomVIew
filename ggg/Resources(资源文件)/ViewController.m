//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "ViewController.h"
#import "MJAlertView.h"
#import "DEMO6_VC.h"
#import "MJMenuView.h"
#import "DEMO7_VC.h"
#import "DEMO8_VC.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation ViewController

#pragma mark ************** 懒加载控件
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"自定义View";
    //文字
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"QQ弹窗" style:UIBarButtonItemStylePlain target:self action:@selector(Action)];
    self.navigationItem.rightBarButtonItem = editItem;
    _dataArray = @[@"删除Alert",@"多个按钮",@"Scroll_横向滚动标题",@"自定义Button",@"分享成功",@"保存方案",@"登陆",@"浏览记录"];
}
- (void)Action
{
    
    [MJMenuView showWithImageArray:@[@"menu_icon_chat",@"menu_icon_phone",@"menu_icon_folder",@"menu_icon_scan"] titleArray:@[@"多人聊天",@"语音电话",@"传文件",@"退出登录"] itemAction:^(NSString *title) {
        NSLog(@"--%@",title);
    }];
}
#pragma mark ************** 获取数据
- (void)getData
{
    
}
#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边尖括号
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[DEMO8_VC new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[DEMO6_VC new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[DEMO7_VC new] animated:YES];
            break;
            
        default:
            break;
    }
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
