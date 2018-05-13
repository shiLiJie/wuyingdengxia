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

@property (weak, nonatomic) IBOutlet UILabel *LiwuName;//礼物名称
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
    
    [self.LiwuImage sd_setImageWithURL:[NSURL URLWithString:self.liwumodel.goods_img] placeholderImage:GetImage(@"")];
    self.liwuJiage.text = self.liwumodel.moon_cash;
    self.LiwuName.text = self.liwumodel.goods_name;
    self.detailLab.text = self.liwumodel.goods_tips;
}

//确认兑换点击
- (IBAction)duihuanClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定使用%@月亮币兑换？",self.liwumodel.moon_cash]
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              //确定兑换
                                                              [weakSelf duihuanGoods];
                                                              
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

//兑换礼物
-(void)duihuanGoods{
    __weak typeof(self) weakSelf = self;
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"user_id":user.userid,
                           @"goods_id":weakSelf.liwumodel.goods_id
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_exchange_goods"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            [MBProgressHUD showSuccess:obj[@"msg"]];
                                                            //响应事件
                                                            MyLiwuResultVc *vc = [[MyLiwuResultVc alloc] init];
                                                            vc.liwumodel = [[LiwuModel alloc] init];
                                                            vc.liwumodel = self.liwumodel;
                                                            vc.courtesy_code = obj[@"data"][@"courtesy_code"];
                                                            vc.exchange_code = obj[@"data"][@"exchange_code"];
                                                            vc.order_num = obj[@"data"][@"order_num"];
                                                            [weakSelf.navigationController pushViewController:vc animated:YES];
                                                        }else{
                                                            [MBProgressHUD showError:obj[@"msg"]];
                                                        }
                                                    }
                                                       fail:^(NSError *error) {
                                                           
                                                       }];
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
