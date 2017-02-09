//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SXBrowseManager.h"
#import "SCRecordModle.h"
#import "SXBrowseSectionHeadView.h"
#import "SXBrowseTableVIewCell.h"
@interface SXBrowseManager ()

@end
@implementation SXBrowseManager

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SCRecordModle *model = _dataArray[section];
    return  model.fModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ESWeakSelf;
    SCRecordModle *model = _dataArray[indexPath.section];
    
    SXBrowseTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SXBrowseTableVIewCell" forIndexPath:indexPath];
    cell.isShow = self.isShow;
    SCFavoriteModel *faModel = model.fModel[indexPath.row];
    cell.model = faModel;
    cell.selectBlcok = ^(){
        faModel.isSelected = !faModel.isSelected;
        [__weakSelf isSectionSelectAction:model];
    };
    cell.cellClickBlack = ^(NSString *title){
        
    };
    return cell;
    
}
/*分区头部部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ESWeakSelf;
    SXBrowseSectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SXBrowseSectionHeadView"];
    
    if(!sectionHeadView)
    {
        sectionHeadView = [[SXBrowseSectionHeadView alloc] initWithReuseIdentifier:@"SXBrowseSectionHeadView"];
    }
    SCRecordModle *model = _dataArray[section];
    sectionHeadView.isShow = self.isShow;
    sectionHeadView.model = model;
    sectionHeadView.headClickBlcok = ^(){
        [__weakSelf changeSection:section];
    };
    
    return sectionHeadView;
    
}
#pragma mark ************** 更新分区头
- (void)isSectionSelectAction:(SCRecordModle *)model
{
    BOOL isSectionSelect = YES;//是否分区头全选
    
    for(SCFavoriteModel * Model in model.fModel)
    {
        if(!Model.isSelected)
            isSectionSelect = NO;//说明该区还有商品没选中
    }
    model.isSelected = isSectionSelect;
    [self allSelectActon];
}
#pragma mark ************** 处理分区
- (void)changeSection:(NSInteger)section
{
    SCRecordModle *model = _dataArray[section];
    model.isSelected = !model.isSelected;
    for(SCFavoriteModel *models in model.fModel)
    {
        models.isSelected = model.isSelected;
    }
    
    [self allSelectActon];
}
#pragma mark ************** 判断是否全选
- (void)allSelectActon
{
    BOOL isAllSelect = YES;
    for(SCRecordModle *model in _dataArray)
    {
        if(!model.isSelected)
            isAllSelect = NO;
    }
    //全选
    self.AllSelect(isAllSelect);
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}
+ (NSArray *)formateDate:(NSArray *)dataArray{
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        NSDictionary *dic = dataArray[i];
        if ([dic[@"itemType"] isEqualToNumber:@0]) {
            NSMutableDictionary *tempDic = [NSMutableDictionary new];
            NSMutableArray *newArray = [NSMutableArray new];
            [tempDic setValue:dic[@"label"] forKey:@"label"];
            [tempDic setValue:newArray forKey:@"fModel"];
            [tempArray addObject:tempDic];
        } else {
            NSDictionary *lastDic = [tempArray lastObject];
            NSMutableArray *targetArray = lastDic[@"fModel"];
            [targetArray addObject:dic];
        }
    }
    return tempArray;
}

+ (void)getBrowseListWithTarget:(id)target param:(NSDictionary *)param callback:(ListArrayCallback)callback
{
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    [[SVHTTPClient sharedClient] GET:APIBrowseList parameters:param completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"请求出错"];
        }
        else
        {
            NSArray *temp = [self formateDate:response];
            NSArray *favoriteArray = [SCRecordModle mj_objectArrayWithKeyValuesArray:temp];
            callback(favoriteArray);
        }
        
    }];

}
@end
