//
//  XuyuanchiVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XuyuanchiVc.h"
#import "XuyuanVc.h"
#import "XuyuanJiluVc.h"

@interface XuyuanchiVc ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//用户名
@property (weak, nonatomic) IBOutlet UIButton *yueliangbi;//月亮币个数
@property (weak, nonatomic) IBOutlet UIButton *xuyuanBtn;

@end

@implementation XuyuanchiVc

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    
    self.xuyuanBtn.layer.cornerRadius = CGRectGetHeight(self.xuyuanBtn.frame)/2;//半径大小
    self.xuyuanBtn.layer.masksToBounds = YES;//是否切割
    
    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (!kStringIsEmpty(user.userName)) {
        self.userName.text = user.userName;
    }
    if (!kStringIsEmpty(user.moon_cash)) {
        [self.yueliangbi setTitle:user.moon_cash forState:UIControlStateNormal];
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:user.headimg] placeholderImage:GetImage(@"tx")];
}

#pragma mark - 私有方法 -
//返回
- (IBAction)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//许愿记录
- (IBAction)xuyuanjilu:(UIButton *)sender {
    XuyuanJiluVc *vc = [[XuyuanJiluVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//许愿按钮点击
- (IBAction)xuyuanClick:(UIButton *)sender {
    XuyuanVc *vc = [[XuyuanVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
