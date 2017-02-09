//
//  DEMO8_VC.m
//  ggg
//
//  Created by LXY on 17/1/3.
//  Copyright © 2017年 AVGD. All rights reserved.
//

#import "DEMO8_VC.h"

@interface DEMO8_VC ()

@end

@implementation DEMO8_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)alertView:(id)sender {
    [MJAlertView showAlertViewWithTitle:@"删除历史" ConfirmBlock:^{
        NSLog(@"确定");
    } CancelBlock:^{
        NSLog(@"取消");
    }];
}
- (IBAction)chanView:(id)sender {
    [MJAlertView showAlertViewWithTitle:@"便宜不等人,请三思而行!" ConfirmText:@"去意已决" CancelText:@"我再想想" ConfirmBlock:^{
        
    } CancelBlock:^{
        
    }];
}
- (IBAction)orherView:(id)sender {
    [MJAlertView showOtherAlertViewWithTitle:@"删除历史" ConfirmText:@"确定" CancelText:@"前往首页" ConfirmBlock:^{
        
    } CancelBlock:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
