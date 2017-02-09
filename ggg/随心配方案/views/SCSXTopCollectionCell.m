

#import "SCSXTopCollectionCell.h"

@interface SCSXTopCollectionCell ()

@property (nonatomic, strong) UILabel *titleLab;

@end


@implementation SCSXTopCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = systemFont(14);
        _titleLab.text = @"欧式风格/卧室/客厅";
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.layer.borderWidth = 0.5;
        _titleLab.layer.borderColor = RGB(227, 229, 230).CGColor;
        
        _titleLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickxx)];
        [self addGestureRecognizer:tap];
    }
    return _titleLab;
}
- (void)clickxx
{
    if(self.ClickBlock)
        self.ClickBlock();
}
- (void)setModel:(SCSXSaveModel *)model
{
    _titleLab.text = model.name;
    //判断是否选中
    if(model.isSelect)
    {
      _titleLab.textColor = [UIColor redColor];
    }
    else
    {
        _titleLab.textColor = [UIColor blackColor];
    }
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.titleLab];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
 
}



@end
