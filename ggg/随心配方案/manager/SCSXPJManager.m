//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "SCSXPJManager.h"
#import "SCSXPJTableVIewCell.h"
#import "SCSXPJModel.h"
@interface SCSXPJManager ()

@end
@implementation SCSXPJManager


+ (CGFloat)HeightWithText:(NSString *)text constrainedToWidth:(CGFloat)width LabFont:(UIFont *)font
{
    CGSize textSize=[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGFloat height = textSize.height;
    
    return height + 5;
    
}

- (CGFloat)getCellHeightWithIndexPath:(NSIndexPath *)indexPath
{
     CGFloat titleHeight;
    
   

    return titleHeight;
    
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

    SCSXPJModel *model = _dataArray[indexPath.row];
    if(model.remark.length > 0)
    {
        return 400 + 40;
    }
    else
    {
        return 400;//为空
    }
    
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SCSXPJTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCSXPJTableVIewCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    cell.cellImgBlack = ^(){
        if(self.cellImgBlack)
            self.cellImgBlack();

    };
    cell.cellProductBlack = ^(NSString *productID){
        if(self.cellProductBlack)
            self.cellProductBlack(productID);
        
    };
    return cell;
    
}


@end
