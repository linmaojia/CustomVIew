//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SXBrowBottomView.h"

@interface SXBrowBottomView()

@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, strong) UIButton *cancelBtn;             /**<  系统按钮 */
@property(nonatomic, strong)UIButton *selectButton;   /**< 选择按钮 */
@property (nonatomic, strong) UILabel *allLab;@end

@implementation SXBrowBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviewsForView];
        [self addConstraintsForView];
        
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UIButton *)deleBtn {
    if (!_deleBtn) {
        _deleBtn=[[UIButton alloc]init];
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:RGB(210, 50, 50) forState:UIControlStateNormal];
        _deleBtn.titleLabel.font = systemFont(14);//标题文字大小
        _deleBtn.layer.borderWidth = 0.5;
        _deleBtn.layer.borderColor = RGB(210, 50, 50).CGColor;
        _deleBtn.layer.cornerRadius = 3;
        _deleBtn.layer.masksToBounds = YES;
        [_deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _deleBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn=[[UIButton alloc]init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGB(210, 50, 50) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = systemFont(14);//标题文字大小
        _cancelBtn.layer.borderWidth = 0.5;
        _cancelBtn.layer.borderColor = RGB(210, 50, 50).CGColor;
        _cancelBtn.layer.cornerRadius = 3;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelBtn;
}

#pragma mark ************** 按钮被点击
- (void)deleBtnClick:(UIButton *)sender
{
    if(self.btnTitleClick)
        self.btnTitleClick(sender.titleLabel.text);
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
- (UILabel *)allLab {
    if (!_allLab) {
        _allLab = [[UILabel alloc] init];
        _allLab.textAlignment = NSTextAlignmentCenter;
        _allLab.textColor = [UIColor grayColor];
        _allLab.font = systemFont(14);
        _allLab.text = @"全部";
    }
    return _allLab;
}
- (void)selectButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(self.BtnClick)
        self.BtnClick(sender.selected);
        
}



#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.allLab];
    [self addSubview:self.selectButton];
    [self addSubview:self.deleBtn];
    [self addSubview:self.cancelBtn];


}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self);
    }];
    [_allLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectButton.right).offset(10);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@30);
    }];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 35));
    }];
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_cancelBtn.left).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 35));
    }];
}

@end
