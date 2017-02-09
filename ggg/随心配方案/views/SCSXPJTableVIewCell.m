//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXPJTableVIewCell.h"
#import "SCSXPJCollectionCell.h"
#import "SCSXPJManager.h"
#import "SCOrderProductDetailModel.h"

@interface SCSXPJTableVIewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *proImg;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailTitleLab;
@property (nonatomic, strong) UILabel *editLab;
@property (nonatomic, strong) UILabel *styleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *productArray;
@property (nonatomic, strong) UIButton *downBtn; /**<  向下箭头按钮 */

@end
@implementation SCSXPJTableVIewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGB(243, 239, 236);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _productArray = @[@"x",@"x",@"x",@"x"];
        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
        
        
    }
    return self;
}
#pragma mark ************** 懒加载控件

- (UIButton *)downBtn {
    if (!_downBtn) {
        _downBtn=[[UIButton alloc]init];
        [_downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_downBtn setImage:[UIImage imageNamed:@"pull-up"] forState:UIControlStateNormal];
        [_downBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateSelected];
        //_downBtn.backgroundColor = [UIColor redColor];

    }
    return _downBtn;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10; //列与列之间的间距
        layout.minimumLineSpacing = 0;//行与行之间的间距
        layout.itemSize = CGSizeMake(250, 100);//cell的大小
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);//每个区的空隙
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SCSXPJCollectionCell class] forCellWithReuseIdentifier:@"SCSXPJCollectionCell"];
    }
    return _collectionView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(243, 239, 236);
    }
    return _lineView;
}
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = systemFont(14);
        _timeLab.text = @"2016-12-03";
        _timeLab.textColor = [UIColor grayColor];
    }
    return _timeLab;
}
- (UILabel *)styleLab {
    if (!_styleLab) {
        _styleLab = [[UILabel alloc] init];
        _styleLab.textAlignment = NSTextAlignmentLeft;
        _styleLab.font = systemFont(14);
        _styleLab.text = @"欧式风格/卧室/客厅";
        _styleLab.textColor = [UIColor grayColor];
    }
    return _styleLab;
}
- (UILabel *)editLab {
    if (!_editLab) {
        _editLab = [[UILabel alloc] init];
        _editLab.textAlignment = NSTextAlignmentCenter;
        _editLab.font = systemFont(14);
        _editLab.text = @"点击编辑";
        _editLab.backgroundColor = RGBA(0, 0, 0, 0.3);
        _editLab.textColor = [UIColor whiteColor];
    }
    return _editLab;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = boldSystemFont(16);
        _titleLab.text = @"卧室客厅欧式风格";
        _titleLab.backgroundColor = [UIColor whiteColor];
    }
    return _titleLab;
}
- (UILabel *)detailTitleLab {
    if (!_detailTitleLab) {
        _detailTitleLab = [[UILabel alloc] init];
        _detailTitleLab.textAlignment = NSTextAlignmentLeft;
        _detailTitleLab.font = systemFont(14);
        _detailTitleLab.text = @"由欧式简约灯饰搭配简约客厅/卧室所组成的简约欧式风格";
        _detailTitleLab.textColor = [UIColor grayColor];
        _detailTitleLab.numberOfLines = 0;
    }
    return _detailTitleLab;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIView *)superView {
    if (!_superView) {
        _superView = [[UIView alloc] init];
        _superView.backgroundColor = [UIColor whiteColor];
    }
    return _superView;
}
- (UIImageView *)proImg {
    if (!_proImg) {
        _proImg = [[UIImageView alloc] init];
        _proImg.image = [UIImage imageNamed:@"u10913"];
        [_proImg setContentMode:UIViewContentModeScaleAspectFill];
        _proImg.clipsToBounds=YES;
        _proImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [_proImg addGestureRecognizer:tap];
    }
    return _proImg;
}
#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
     if(self.cellImgBlack)
         self.cellImgBlack();
}
#pragma mark ************** 打开备注文字
- (void)downBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _model.isOpen = sender.selected;
    
    
     CGFloat remark_H = [SCSXPJManager HeightWithText:_model.remark constrainedToWidth:(SCREEN_WIDTH - 45) LabFont:[UIFont systemFontOfSize:14]];
    if(_model.isOpen)
    {
        [_detailTitleLab updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(remark_H));
        }];
    }
    else
    {
        [_detailTitleLab updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(40));
        }];
    }
}
#pragma mark ************** 设置cell 内容
- (void)setModel:(SCSXPJModel *)model
{
    _model = model;
    
    _titleLab.text = model.title;

    _detailTitleLab.text = model.remark;
    
    [_proImg sd_setImageWithURL:[NSURL URLWithString:[model.imgPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
    
    _styleLab.text = [self clearLastString:[NSString stringWithFormat:@"%@%@",model.style,model.space]];
    
    _timeLab.text = [self changeTime:model.addDate];
    
    _productArray = model.productDetails;
    
    //设置Remark
    if(model.remark.length > 0)
    {
        
        CGFloat remark_H = [SCSXPJManager HeightWithText:model.remark constrainedToWidth:(SCREEN_WIDTH - 45) LabFont:[UIFont systemFontOfSize:14]];
        if(remark_H > 40)
        {
            _downBtn.hidden = NO;
            [_downBtn setSelected:model.isOpen];
            if(model.isOpen)
            {
                [_detailTitleLab updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(remark_H));
                }];
            }
           
        }
        else
        {
            [_detailTitleLab updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(40));
            }];
              _downBtn.hidden = YES;
        }
 
    }
    else
    {
        
        [_detailTitleLab updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        _downBtn.hidden = YES;
        
    }
   
   
    
//     CGFloat titleHeight = [SCSXPJManager HeightWithText:model.title constrainedToWidth:(SCREEN_WIDTH - 40) LabFont:[UIFont systemFontOfSize:14]];
//
    
}
- (NSString *)clearLastString:(NSString *)str
{
    NSString *string;
    if(str.length > 0)
    {
       string =  [str substringWithRange:NSMakeRange(0, [str length] - 1)];
    }
    return string;
}
#pragma mark ************** 时间戳转换
- (NSString *)changeTime:(NSInteger)time{
    NSString *strTime;
    NSDate *newdate=[NSDate dateWithTimeIntervalSince1970:time/1000];//NSDate
    //定义时间格式
    NSDateFormatter *dateformatter=[NSDateFormatter new];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    //转为字符串
    strTime =[dateformatter stringFromDate:newdate];
    return strTime;
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.superView];
    [self.superView addSubview:self.titleLab];
    [self.superView addSubview:self.detailTitleLab];
    [self.superView addSubview:self.downBtn];
    [self.superView addSubview:self.proImg];
    [self.proImg addSubview:self.editLab];
    [self.superView addSubview:self.lineView];
    [self.superView addSubview:self.styleLab];
    [self.superView addSubview:self.timeLab];
    [self.superView addSubview:self.collectionView];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_superView).offset(5);
        make.left.equalTo(_superView).offset(10);
        make.right.equalTo(_superView).offset(-10);
        make.height.equalTo(@30);
    }];
    [_detailTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom).offset(5);
        make.left.equalTo(_superView).offset(10);
        make.right.equalTo(_superView).offset(-15);
        make.height.equalTo(@40);
    }];
    [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_detailTitleLab.bottom);
        make.right.equalTo(_superView);
        make.width.height.equalTo(@20);
    }];
    
    [_proImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailTitleLab.bottom).offset(10);
        make.left.equalTo(_superView).offset(10);
        make.right.equalTo(_superView).offset(-10);
        make.height.equalTo(@200);
    }];
    [_editLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_proImg);
        make.height.equalTo(@25);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_superView);
        make.top.equalTo(_proImg.bottom);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.bottom.equalTo(_superView).offset(-5);
        make.right.equalTo(_superView).offset(-10);
        make.width.equalTo(@80);
    }];
    [_styleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.bottom.equalTo(_superView).offset(-5);
        make.left.equalTo(_superView).offset(10);
        make.right.equalTo(_timeLab.left).offset(-30);
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.right.left.equalTo(_superView);
        make.bottom.equalTo(_styleLab.top);
    }];
   ///UICollectionView
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
        make.right.left.equalTo(_superView);
        make.bottom.equalTo(_lineView.top);

    }];
    /*
     底部日期 30 + 5
     吊灯 100
     背景 200 + 10
     上下空隙 10 
     标题 30 + 5
     说明 30 + 5
     
     */
}

#pragma mark ************** CollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SCSXPJCollectionCell *cell = (SCSXPJCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SCSXPJCollectionCell" forIndexPath:indexPath];
    cell.model = _productArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SCOrderProductDetailModel *model =  _productArray[indexPath.row];
    
    if(self.cellProductBlack)
        self.cellProductBlack(model.productId);
    NSLog(@"%ld被点击",indexPath.row);
    
}
@end
