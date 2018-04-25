//
//  MyLiwuDetailVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyLiwuDetailVc.h"
#import "MyLiwuResultVc.h"

@interface MyLiwuDetailVc ()

@property (weak, nonatomic) IBOutlet UIImageView *LiwuImage;//礼物图片
@property (weak, nonatomic) IBOutlet UILabel *liwuJiage;//礼物价格lab
@property (weak, nonatomic) IBOutlet UIButton *sureDuihuanBtn;//确认兑换按钮

//兑换须知lab
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end

@implementation MyLiwuDetailVc
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    
    self.detailLab.lineBreakMode = UILineBreakModeWordWrap;
    self.detailLab.numberOfLines = 0;
    self.detailLab.text = @"lineone\nlinetwo";
    
    self.sureDuihuanBtn.layer.cornerRadius = CGRectGetHeight(self.sureDuihuanBtn.frame)/2;//半径大小
    self.sureDuihuanBtn.layer.masksToBounds = YES;//是否切割
}

//确认兑换点击
- (IBAction)duihuanClick:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定使用40月亮币兑换？"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              MyLiwuResultVc *pageDetail = [[MyLiwuResultVc alloc] init];
                                                              [self.navigationController pushViewController:pageDetail animated:YES];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
//返回
- (IBAction)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
