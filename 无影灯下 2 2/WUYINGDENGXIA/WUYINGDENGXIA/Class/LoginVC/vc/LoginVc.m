//
//  LoginVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "LoginVc.h"
#import "LJNavigationController.h"
#import "DuanxinLoginVc.h"
#import "RegistVc.h"
#import "ZhaohuiMimaVc.h"

@interface LoginVc ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHigh;//适配iPhone4约束
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录按钮
@property (weak, nonatomic) IBOutlet UITextField *phoneField;//手机号text
@property (weak, nonatomic) IBOutlet UITextField *pwdField;//密码text

@end

@implementation LoginVc

#pragma mark - Public Methods
+ (instancetype)loginControllerWithBlock:(LoginHandler)loginBlock {
    LoginVc *loginVC = [[LoginVc alloc] init];
    loginVC.loginBlock = loginBlock;
    return loginVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kDevice_Is_iPhone4) {
        self.constraintHigh.constant = 80;
    }
    self.loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.frame)/2;//半径大小
    self.loginBtn.layer.masksToBounds = YES;//是否切割
}
#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return YES;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@""];
}

-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    return btn;
}
-(void)left_button_event:(UIButton *)sender{
}

//左侧按钮设置点击
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, kScreen_Width-66, 44, 60);
    [btn setImage:GetImage(@"cha1") forState:UIControlStateNormal];
    return btn;
}

-(void)right_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - 私有方法 -
//立即注册
- (IBAction)gotoRegist:(UIButton *)sender {
    RegistVc *vc = [[RegistVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//登录
- (IBAction)loginClick:(UIButton *)sender {
}
//短信快捷登录
- (IBAction)duanxinLogin:(UIButton *)sender {
    DuanxinLoginVc *vc = [[DuanxinLoginVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//忘记密码
- (IBAction)forgotPwd:(UIButton *)sender {
    ZhaohuiMimaVc *vc = [[ZhaohuiMimaVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//微信登录
- (IBAction)weixin:(UIButton *)sender {
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneField resignFirstResponder];
    [self.pwdField resignFirstResponder];
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
