//
//  YZGOrderButtonView.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXTopView.h"
#import "UIButton+JWCenter.h"
#import "SCSXTopCollectionCell.h"
#import "SCSXSaveModel.h"
static float const TOP_H = 50;
static float const CELL_H = 45;

@interface SCSXTopView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat supView_H;
    NSMutableArray *kong;
    NSMutableArray *jian;
}
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, strong) NSArray *timeArray;


@end
@implementation SCSXTopView
#pragma mark ************** init
- (id)initWithTitles:(NSArray *)titles Frame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    
    if (self) {
        
        supView_H = self.frame.size.height;
        
        [self setTimeModel];//设置时间数组
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];

        self.titles = titles;
        
        [self addSubviewsForView];
        
    }
    
    return self;
}
- (void)setTimeModel
{
    NSArray *list = @[@{@"name":@"一周内",@"isSelect":@(NO)},@{@"name":@"一个月内",@"isSelect":@(NO)},@{@"name":@"三个月内",@"isSelect":@(NO)}];
    _timeArray = [SCSXSaveModel mj_objectArrayWithKeyValuesArray:list];
}
#pragma mark ************** 添加子控件
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);//每个区的空隙
        layout.minimumInteritemSpacing = 0; //列与列之间的间距
        layout.minimumLineSpacing = 0;//行与行之间的间距
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/2, CELL_H);//cell的大小
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SCSXTopCollectionCell class] forCellWithReuseIdentifier:@"SCSXTopCollectionCell"];
        
       

    }
    return _collectionView;
}

- (UIView *)topView {
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
        
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, TOP_H);

        _topView.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < _titles.count; i++)
        {
            UIButton *retusBtn = [[UIButton alloc]init];
            retusBtn.layer.borderWidth = 0.5;
            retusBtn.layer.borderColor = RGB(227, 229, 230).CGColor;
            retusBtn.frame = CGRectMake(i * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, TOP_H);
            [retusBtn setTitle:_titles[i] forState:0];
            [retusBtn setTitleColor:[UIColor blackColor] forState:0];
            retusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [retusBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
            retusBtn.backgroundColor = [UIColor whiteColor];
            [retusBtn centerStyle:CenterButtonImageStyleRight padding:10];
            [retusBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            retusBtn.tag = 100+ i;
            [_topView addSubview: retusBtn];
        }
    }
    return _topView;
}
#pragma mark ************** 消失
- (void)dismiss
{
  
    [UIView animateWithDuration:0.15 animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0];
        
    } completion:^(BOOL finished) {
        if( self.btnClickBlock)
            self.btnClickBlock(NO);
    }];
}
#pragma mark ************** 显示
- (void)show
{
    
    if( self.btnClickBlock)
        self.btnClickBlock(YES);
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)addSubviewsForView
{
   [self addSubview:self.topView];
   [self addSubview:self.collectionView];
 
}

- (void)btnClick:(UIButton *)sender
{
    
    if(sender.tag == 100)//时间
    {
        _selectArray = _timeArray;
    }
    else if(sender.tag == 101)//空间
    {
         _selectArray = _roomArray;
    }
    else
    {
        
        _selectArray = _styleArray;//风格
    }
    
    NSInteger row = _selectArray.count / 2 + _selectArray.count % 2;
    
    _collectionView.frame = CGRectMake(0, TOP_H, SCREEN_WIDTH, CELL_H *row);
    
    [_collectionView reloadData];
    
    [self show];
}

#pragma mark ************** CollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _selectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    SCSXTopCollectionCell *cell = (SCSXTopCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SCSXTopCollectionCell" forIndexPath:indexPath];
    SCSXSaveModel *model = _selectArray[indexPath.row];
    cell.model = model;
    cell.ClickBlock = ^(){
        
        if(self.titleClickBlock)
        {
            self.titleClickBlock(model);//标题回调
        }
        
        [__weakSelf dismiss];
        
        for(SCSXSaveModel *model in __weakSelf.selectArray)
        {
            model.isSelect = NO;
        }
         model.isSelect = YES;
        
        [__weakSelf.collectionView reloadData];
    };
    
    
    
    return cell;
}


@end
