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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXLoginSucess) name:@"WXLogin" object:nil];
}
-(void)WXLogin:(NSNotification *)notification{
    
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
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"login_by_phone?phone_num=%@&password=%@",self.phoneField.text,self.pwdField.text]] parameters:nil success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            //登录成功
            NSDictionary *dic = obj[@"data"];
            UserInfoModel *user = [UserInfoModel shareUserModel];
            user.userName = dic[@"username"];
            user.passWord = self.pwdField.text;
            user.loginStatus = YES;
            user.certid = dic[@"certid"];
            user.ctime = dic[@"ctime"];
            user.fansnum = dic[@"fansnum"];
            user.headimg = dic[@"headimg"];
            user.isV = dic[@"isV"];
            user.isadmin = dic[@"isadmin"];
            user.isfinishCer = dic[@"isfinishCer"];
            user.ishead = dic[@"ishead"];
            user.isphoneverify = dic[@"isphoneverify"];
            user.last_login_time = dic[@"last_login_time"];
            user.phoneNum = dic[@"phoneNum"];
            user.supportnum = dic[@"supportnum"];
            user.userDegree = dic[@"userDegree"];
            user.userEmail = dic[@"userEmail"];
            user.userHospital = dic[@"userHospital"];
            user.userIdcard = dic[@"userIdcard"];
            user.userLoginway = dic[@"userLoginway"];
            user.userMajor = dic[@"userMajor"];
            user.userOffice = dic[@"userOffice"];
            user.userPosition = dic[@"userPosition"];
            user.userReal_name = dic[@"userReal_name"];
            user.userSchool = dic[@"userSchool"];
            user.userStschool = dic[@"userStschool"];
            user.userTitle = dic[@"userTitle"];
            user.userUnit = dic[@"userUnit"];
            user.user_token = dic[@"user_token"];
            user.useravatar_id = dic[@"useravatar_id"];
            user.usercity = dic[@"usercity"];
            user.userid = dic[@"userid"];
            user.usersex = dic[@"usersex"];
            user.usertoken = dic[@"usertoken"];
            user.moon_cash = dic[@"moon_cash"];
            user.we_chat_id = dic[@"we_chat_id"];
            
            [user saveUserInfoToSanbox];
            
            self.loginBlock(YES, nil);
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:obj[@"msg"]];
        }
        
        
    } fail:^(NSError *error) {
        //登录失败
    }];
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
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
    if (accessToken && openID) {
        
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
        
        [[HttpRequest shardWebUtil] getNetworkRequestURLString:[NSString stringWithFormat:@"%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, AppID, refreshToken] parameters:nil success:^(id obj) {
            //
            NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:obj];
            NSString *reAccessToken = [refreshDict objectForKey:WX_ACCESS_TOKEN];
            // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
            if (reAccessToken) {
                // 更新access_token、refresh_token、open_id
                [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_OPEN_ID] forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_REFRESH_TOKEN] forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                // 当存在reAccessToken不为空时直接执行AppDelegate中的wechatLoginByRequestForUserInfo方法
//                !self.requestForUserInfoBlock ? : self.requestForUserInfoBlock();
                [self wechatLoginByRequestForUserInfo];
            }
            else {
                [self wechatLogin];
            }
        } fail:^(NSError *error) {
            NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);
        }];
    }
    else {
        [self wechatLogin];
    }
}

//授权成功,获取用户信息
- (void)wechatLoginByRequestForUserInfo {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID] parameters:nil success:^(id obj) {
//        NSLog(@"请求用户信息的response = %@", obj);
    
        UserInfoModel *user = [UserInfoModel shareUserModel];
        user.userName = obj[@"nickname"];
        user.headimg = obj[@"headimgurl"];
        user.usercity = obj[@"city"];
        
        NSString *sex = [NSString stringWithFormat:@"%@",obj[@"sex"]];
        if ([sex isEqualToString:@"1"]) {
            user.usersex = @"男";
        }else{
            user.usersex = @"女";
        }
        
        user.loginStatus = YES;
        
        [user saveUserInfoToSanbox];
        [MBProgressHUD showSuccess:@"登录成功"];
        self.loginBlock(YES, nil);
        
        [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"wechat_login?wechat_open_id=%@",openID]]
                                                    parameters:nil
                                                       success:^(id obj) {
            
        } fail:^(NSError *error) {
            
        }];
        
    } fail:^(NSError *error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}

-(void)wechatLogin{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }
    else {
        [self setupAlertController];
    }
}

//第一次微信登录成功发送过来的通知,发送网络请求看是否存在手机号,如果存在直接返回手机号登录,如果不存在,弹出绑定手机界面
-(void)WXLoginSucess{
    
}

- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
