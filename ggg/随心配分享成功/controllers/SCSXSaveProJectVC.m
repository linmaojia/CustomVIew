//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXSaveProJectVC.h"
#import "SVHTTPClient+SXSXRequest.h"
#import "MJTextViews.h"
#import "SCSXSaveModel.h"
@interface SCSXSaveProJectVC ()
@property (nonatomic, strong) UITextField *titleTf;
@property (nonatomic, strong) MJTextViews *textView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *styleView;
@property (nonatomic, strong) UIView *roomView;
@property (nonatomic, strong) UIView *styleLeftView;
@property (nonatomic, strong) UIView *roomLeftView;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSArray *styleArray;
@property (nonatomic, strong) NSArray *roomArray;
@property (nonatomic, strong) NSArray *seleectArray;

@end

@implementation SCSXSaveProJectVC

#pragma mark ************** 懒加载控件
- (UIScrollView *)scroll{
    if(!_scroll){
        _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scroll.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.hidden = YES;
    }
    return _scroll;
}
- (UIView *)styleView {
    if (!_styleView) {
        _styleView = [[UIView alloc] init];
        _styleView.frame = CGRectMake(0, 70, SCREEN_WIDTH, 100);
        _styleView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0, 0, 70, 40);
        title.textAlignment = NSTextAlignmentCenter;
        title.font = systemFont(16);
        title.text = @"风格";
        title.textColor = [UIColor blackColor];
        
        _styleLeftView = [[UIView alloc] init];
        _styleLeftView.frame = CGRectMake(70, 10, SCREEN_WIDTH - 80, 50);
        _styleLeftView.backgroundColor = [UIColor whiteColor];
        
        [_styleView addSubview:title];
        [_styleView addSubview:_styleLeftView];
        
    }
    return _styleView;
}
- (UIView *)roomView {
    if (!_roomView) {
        _roomView = [[UIView alloc] init];
        _roomView.frame = CGRectMake(0, 170, SCREEN_WIDTH, 100);
        _roomView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0, 0, 70, 40);
        title.textAlignment = NSTextAlignmentCenter;
        title.font = systemFont(16);
        title.text = @"房型";
        title.textColor = [UIColor blackColor];
        
        _roomLeftView = [[UIView alloc] init];
        _roomLeftView.frame = CGRectMake(70, 10, SCREEN_WIDTH - 80, 50);
        _roomLeftView.backgroundColor = [UIColor whiteColor];
        
        [_roomView addSubview:title];
        [_roomView addSubview:_roomLeftView];
        
    }
    return _roomView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
        _topView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(0, 0, 70, 60);
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = systemFont(16);
        titleLab.text = @"标题";
        titleLab.textColor = [UIColor blackColor];
        
        _titleTf = [[UITextField alloc]init];
        _titleTf.frame = CGRectMake(70, 10, SCREEN_WIDTH - 80, 40);
        _titleTf.textColor = [UIColor blackColor];
        _titleTf.backgroundColor = [UIColor whiteColor];
        _titleTf.textAlignment = NSTextAlignmentLeft;//文本居中
        _titleTf.clearButtonMode=YES;//设置清除按钮
        _titleTf.layer.borderWidth = 0.5;
        _titleTf.layer.borderColor = [UIColor grayColor].CGColor;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 60, SCREEN_WIDTH, 10);
        lineView.backgroundColor = RGB(243, 239, 236);
        
        [_topView addSubview:titleLab];
        [_topView addSubview:_titleTf];
        [_topView addSubview:lineView];
        
    }
    return _topView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, 400, SCREEN_WIDTH, 200);
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UILabel *rearkLab = [[UILabel alloc] init];
        rearkLab.frame = CGRectMake(0, 0, 70, 40);
        rearkLab.textAlignment = NSTextAlignmentCenter;
        rearkLab.font = systemFont(16);
        rearkLab.text = @"备注";
        rearkLab.textColor = [UIColor blackColor];
        
        _textView = [[MJTextViews alloc]init];
        _textView.frame = CGRectMake(70, 0, SCREEN_WIDTH - 90, 200);
        _textView.limitTextLength = 150;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.placehoderText = @"非必填(150字内)";
        _textView.limitTextLengthBlock = ^(){
            [SVProgressHUD showErrorWithStatus:@"超出字数限制"];
        };
        
        [_bottomView addSubview:rearkLab];
        [_bottomView addSubview:_textView];
    }
    return _bottomView;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"保存方案";
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = editItem;
    
}

#pragma mark ************** 重新布局
- (void)addConstraintsForView
{
    
    [self creatTagLabelWithView:_styleLeftView Titles:_styleArray Type:YES];
    
    [self creatTagLabelWithView:_roomLeftView Titles:_roomArray Type:NO];
    
    CGRect frame = _roomView.frame;
    frame.origin.y = _styleView.frame.origin.y + _styleView.frame.size.height + 20;
    _roomView.frame = frame;
    
    CGRect bottomFrame = _bottomView.frame;
    bottomFrame.origin.y = _roomView.frame.origin.y + _roomView.frame.size.height + 20;
    _bottomView.frame = bottomFrame;
    
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH, _bottomView.frame.origin.y + _bottomView.frame.size.height + 20);
    
    NSLog(@"---%@",NSStringFromCGSize(_scroll.contentSize));
    
    _scroll.hidden = NO;
}
#pragma mark ************** 获取数据
- (void)getData
{
    /*  010 - 风格  011 - 空间*/
    ESWeakSelf;
    [SVProgressHUD show];
    [SVHTTPClient getSXPTypeWithTarget:self param:@"010" callback:^(NSArray *sceneParamArray) {
        
        __weakSelf.styleArray = [SCSXSaveModel mj_objectArrayWithKeyValuesArray:sceneParamArray];
        
        [SVHTTPClient getSXPTypeWithTarget:self param:@"011" callback:^(NSArray *sceneParamArray) {
            
            [SVProgressHUD dismiss];
            __weakSelf.roomArray = [SCSXSaveModel mj_objectArrayWithKeyValuesArray:sceneParamArray];
            
            [__weakSelf addConstraintsForView];
            
        }];
        
    }];
    
    
}
#pragma mark ************** 创建标签
- (void)creatTagLabelWithView:(UIView *)view Titles:(NSArray *)titles Type:(BOOL)isStyle
{
    CGFloat spece = 5;
    CGFloat btn_H = 30;
    CGFloat btn_W = ((SCREEN_WIDTH - 80)-2*spece)/3;
    
    NSInteger row = titles.count / 3 + titles.count % 3;
    
    int index = 0;
    
    for(int j = 0; j < row; j++)
    {
        for (int i = 0; i < 3; i++)
        {
            SCSXSaveModel *model = titles[index];
            
            UIButton *button=[[UIButton alloc]init];
            button.frame = CGRectMake(i * (btn_W + spece), j * (btn_H + spece), btn_W, btn_H);
            [button setTitle:model.name forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            button.backgroundColor = RGB(236, 236, 236);
            
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [view addSubview:button];
            
            isStyle == YES?[button setTag:100+index]:[button setTag:200+index];
            
            index++;
            
            if(index == titles.count)
            {
                break;
            }
            
        }
    }
    
    CGRect frame = view.frame;
    frame.size.height = row *(spece + btn_H);
    view.frame = frame;
    
    CGRect superFrame = view.superview.frame;
    superFrame.size.height = row *(spece + btn_H);
    view.superview.frame = superFrame;
    
    
}
#pragma mark ************** 标签按钮点击事件
- (void)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    SCSXSaveModel *model;
    if(sender.tag < 200)
    {
        model = _styleArray[sender.tag - 100];
    }
    else
    {
        model = _roomArray[sender.tag - 200];
    }
    
    model.isSelect = !model.isSelect;
    
    if(sender.selected)
    {
        sender.layer.borderWidth = 0.5;
        sender.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    else
    {
        sender.layer.borderWidth = 0.5;
        sender.layer.borderColor = RGB(236, 236, 236).CGColor;
    }
}
#pragma mark ************** 点击保存
- (void)saveAction
{
    //上传图片
    ESWeakSelf;
    [SVHTTPClient upLoadSXPWithImage:self.image callBack:^(BOOL state, NSString *picUrl) {
        if(state)
        {
           [__weakSelf saveSXPWithPicUrl:picUrl];
        }
    }];
    
    
    
}
- (void)saveSXPWithPicUrl:(NSString *)picUrl
{
    ESWeakSelf;
    [self setParam];
    
    [self.param setObject:picUrl forKey:@"imgPath"];
    
    [SVHTTPClient saveSXPWithDic:self.param callback:^(BOOL state) {
        if(state)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__weakSelf.navigationController popToRootViewControllerAnimated:YES];
                
            });
        }
    }];
    //
    //    NSLog(@"--%@",dic);
}
- (void)setParam
{
    [self.param setObject:self.titleTf.text forKey:@"title"];
    [self.param setObject:self.textView.textFied.text forKey:@"remark"];
    
    //获取style
    NSString *styleString = @"";
    for(SCSXSaveModel *model in _styleArray)
    {
        if(model.isSelect)
            styleString = [styleString stringByAppendingFormat:@"%@/",model.name];
        
    }
    [self.param setObject:styleString forKey:@"style"];
    
    //获取room
    NSString *roomString = @"";
    for(SCSXSaveModel *model in _roomArray)
    {
        if(model.isSelect)
            roomString = [roomString stringByAppendingFormat:@"%@/",model.name];
    }
    
    [self.param setObject:roomString forKey:@"space"];
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.scroll];
    
    [self.scroll addSubview:self.topView];
    
    [self.scroll addSubview:self.styleView];
    
    [self.scroll addSubview:self.roomView];
    
    [self.scroll addSubview:self.bottomView];
    
}

@end
