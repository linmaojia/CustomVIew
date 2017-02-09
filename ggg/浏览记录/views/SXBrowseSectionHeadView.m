//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SXBrowseSectionHeadView.h"

@interface SXBrowseSectionHeadView()

@property (nonatomic, strong) UILabel *timeLab;
@property(nonatomic, strong)UIButton *selectButton;   /**< 选择按钮 */
@property (nonatomic, strong) UILabel *allLab;

@end

@implementation SXBrowseSectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = RGB(245, 245, 245);
        [self addSubviewsForView];
        [self addConstraintsForView];
        
    }
    return self;
}
#pragma mark ************** 懒加载控件
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
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.textColor = [UIColor grayColor];
        _timeLab.font = systemFont(14);
        _timeLab.text = @"12月14日";
    }
    return _timeLab;
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

- (void)setModel:(SCRecordModle *)model
{
    _timeLab.text = model.label;
    
    if(self.isShow)
    {
        [_selectButton updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
        }];
    }
    else
    {
        [_selectButton updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(-70);
        }];
    }
    
    _selectButton.selected = model.isSelected;
    
}
- (void)selectButtonClick:(UIButton *)sender
{
    //sender.selected = !sender.selected;
    
    if(self.headClickBlcok)
        self.headClickBlcok();
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.allLab];
    [self.contentView addSubview:self.selectButton];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(-70);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self.contentView);
    }];
    [_allLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectButton.right).offset(10);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@30);
    }];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_allLab.right).offset(10);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@100);
    }];
   
}

@end
