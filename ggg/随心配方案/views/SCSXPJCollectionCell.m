

#import "SCSXPJCollectionCell.h"

@interface SCSXPJCollectionCell ()

@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *styleLab;
@property (nonatomic, strong) UILabel *bandLab;
@property (nonatomic, strong) UILabel *markLab;

@end


@implementation SCSXPJCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UILabel *)bandLab {
    if (!_bandLab) {
        _bandLab = [[UILabel alloc] init];
        _bandLab.textAlignment = NSTextAlignmentLeft;
        _bandLab.font = systemFont(13);
        _bandLab.text = @"品牌:波尔图";
        _bandLab.textColor = [UIColor grayColor];
    }
    return _bandLab;
}
- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.textAlignment = NSTextAlignmentLeft;
        _numLab.font = systemFont(13);
        _numLab.text = @"编号:DSLSFLSLSL-233";
        _numLab.textColor = [UIColor grayColor];
    }
    return _numLab;
}
- (UILabel *)markLab {
    if (!_markLab) {
        _markLab = [[UILabel alloc] init];
        _markLab.textAlignment = NSTextAlignmentLeft;
        _markLab.font = systemFont(13);
        _markLab.text = @"规格:W0H34DF";
        _markLab.textColor = [UIColor grayColor];
    }
    return _markLab;
}
- (UILabel *)styleLab {
    if (!_styleLab) {
        _styleLab = [[UILabel alloc] init];
        _styleLab.textAlignment = NSTextAlignmentLeft;
        _styleLab.font = systemFont(13);
        _styleLab.text = @"风格:亚洲风格,新中试";
        _styleLab.textColor = [UIColor grayColor];
    }
    return _styleLab;
}
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"ff"];
        _leftImg.backgroundColor = RGB(230, 230, 230);
    }
    return _leftImg;
}

- (void)setModel:(SCOrderProductDetailModel *)model
{
    _model = model;
    
    NSURL *url = [NSURL URLWithString:[[model.path stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_leftImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    _numLab.text = [NSString stringWithFormat:@"编号: %@",model.productNum];
    _bandLab.text = [NSString stringWithFormat:@"品牌: %@",model.brandName];
    _styleLab.text = [NSString stringWithFormat:@"风格: %@",model.style];;
    
    NSString *specWidth = model.specWidth ? model.specWidth : @"0";
    NSString *specHeight = model.specHeight ? model.specHeight : @"0";
    NSString *specdd = model.specLength ? model.specLength : @"0";
    _markLab.text = [NSString stringWithFormat:@"规格: W:%@ H:%@ D:%@",specWidth,specHeight,specdd];

}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
   
    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.bandLab];
    [self.contentView addSubview:self.styleLab];
    [self.contentView addSubview:self.markLab];


}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.width.equalTo(@80);
        make.left.equalTo(self.contentView);
    }];
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg);
        make.left.equalTo(_leftImg.right).offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_bandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numLab.bottom);
        make.left.equalTo(_numLab);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_styleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bandLab.bottom);
        make.left.equalTo(_numLab);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_styleLab.bottom);
        make.left.equalTo(_numLab);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView).offset(-5);
    }];
 
}



@end
