//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SXBrowseTableVIewCell.h"
#import "SCOrderProductDetailModel.h"

@interface SXBrowseTableVIewCell()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) UIImageView *productImageView;     /**< 商品图 */
@property (nonatomic, strong) UILabel *titleLable;     /**< 商品标题 */
@property (nonatomic, strong) UILabel *sizeLable;     /**< 商品规格 */
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UILabel *numLab;             /**<  产品编号 */
@property(nonatomic, strong)UILabel *originalPriceLabel;   /**< 原价label */
@property(nonatomic, strong)UIButton *selectButton;   /**< 选择按钮 */
@property (nonatomic, strong) UIButton *shopCartButton;

@end
@implementation SXBrowseTableVIewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
        
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UIButton *)shopCartButton
{
    if(_shopCartButton == nil)
    {
        _shopCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopCartButton.frame = CGRectMake(10, 100, 80, 30);
        [_shopCartButton setTitle:@"+ 加入购物车" forState:UIControlStateNormal];
        [_shopCartButton setTitleColor:[UIColor colorWithRed:1  green:0.008  blue:0 alpha:1] forState:UIControlStateNormal];
        _shopCartButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _shopCartButton.layer.cornerRadius = 3;
        _shopCartButton.layer.masksToBounds = YES;
        _shopCartButton.layer.borderColor = [UIColor colorWithRed:1  green:0.008  blue:0 alpha:1].CGColor;
        _shopCartButton.layer.borderWidth = 1;
        [_shopCartButton addTarget:self action:@selector(shopCartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopCartButton;
}
- (UIButton *)selectButton
{
    if(!_selectButton)
    {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"logo_del_pro"];
    }
    return _leftImg;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(SCFavoriteModel *)model
{
    SCFavoriteDetailModel *productModel = model.productDetail;
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[productModel.path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:nil];
    _titleLable.text = [NSString stringWithFormat:@"%@%@%@", productModel.brandName, productModel.style, productModel.productType];
    
    _sizeLable.text = [NSString stringWithFormat:@"规格: W:%@ H:%@ D:%@", productModel.specWidth, productModel.specHeight, productModel.specLength];
    _priceLable.text = [NSString stringWithFormat:@"优惠价: %.2f", [productModel.mallSalePrice floatValue]];
    _originalPriceLabel.text = [NSString stringWithFormat:@"零售价: %.2f", [productModel.productPrice floatValue]];
    
    _selectButton.selected = model.isSelected;

    if(self.isShow)
    {
        [_selectButton updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
        }];
    }
    else
    {
        [_selectButton updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(-30);
        }];
    }
    
}

- (void)selectButtonClick:(UIButton *)sender
{
    
    if(self.selectBlcok)
        self.selectBlcok();
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.productImageView];
    [self.contentView addSubview:self.shopCartButton];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.sizeLable];
    [self.contentView addSubview:self.priceLable];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.originalPriceLabel];
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(-30);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self.contentView);
    }];
    [self.productImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(_selectButton.right).offset(10);
        make.bottom.equalTo(self.contentView).offset(-30);
        make.width.mas_equalTo(90);
    }];
    [self.shopCartButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView);
        make.top.equalTo(self.productImageView.bottom);
        make.width.mas_equalTo(_productImageView);
        make.height.equalTo(@25);
    }];
    
    [self.titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(@22);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLable);
        make.top.equalTo(self.titleLable.mas_bottom);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(_titleLable);
    }];
    
    [self.sizeLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.numLab.mas_bottom);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(_titleLable);
    }];
    
    [_originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.sizeLable.mas_bottom);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(_titleLable);
        
    }];
    
    [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.originalPriceLabel.mas_bottom);
        make.width.equalTo(@120);
        make.height.mas_equalTo(_titleLable);
    }];

  
}
- (UIImageView *)productImageView
{
    if(_productImageView == nil)
    {
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}

- (UILabel *)titleLable
{
    if(_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.text = @"古窑●玫瑰客厅/高层/复式/";
    }
    return _titleLable;
}

- (UILabel *)sizeLable
{
    if(_sizeLable == nil)
    {
        _sizeLable = [[UILabel alloc] init];
        _sizeLable.font = [UIFont systemFontOfSize:14];
        _sizeLable.textColor = [UIColor blackColor];
        _sizeLable.text = @"规格：H：590 D：410";
    }
    return _sizeLable;
}

- (UILabel *)priceLable
{
    if(_priceLable == nil)
    {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = [UIColor colorWithRed:0.827  green:0.192  blue:0.196 alpha:1];
        _priceLable.font = [UIFont systemFontOfSize:14];
        _priceLable.text = @"零售价";

    }
    return _priceLable;
}
- (UILabel *)originalPriceLabel
{
    if(!_originalPriceLabel)
    {
        _originalPriceLabel = [[UILabel alloc] init];
        _originalPriceLabel.font = [UIFont systemFontOfSize:14];
        _originalPriceLabel.text = @"批发价:23.99";
        
    }
    return _originalPriceLabel;
}

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.textAlignment = NSTextAlignmentLeft;
        _numLab.font = systemFont(14);
        _numLab.text = @"MYDIDJLOSL";
    }
    return _numLab;
}

@end
