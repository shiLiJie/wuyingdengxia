//
//  DuanxinLoginVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DuanxinLoginVc.h"

@interface DuanxinLoginVc ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;//手机号框
@property (weak, nonatomic) IBOutlet UITextField *VerifField;//验证码框
@property (weak, nonatomic) IBOutlet UIButton *verifBtn;//验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录按钮

@end

@implementation DuanxinLoginVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (isIOS10) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

-(void)viewDidLayoutSubviews{
    self.verifBtn.layer.cornerRadius = CGRectGetHeight(self.verifBtn.frame)/2-1;//半径大小
    self.verifBtn.layer.masksToBounds = YES;//是否切割
    
    self.loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.frame)/2-1;//半径大小
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
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}
-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//左侧按钮设置点击
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    return btn;
}

-(void)right_button_event:(UIButton *)sender{
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - 私有方法 -
//登录
- (IBAction)login:(UIButton *)sender {
    NSDictionary *dict = @{
                           @"userphone":self.phoneField.text,
                           @"verifynum":self.VerifField.text
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"login_by_verti"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            [MBProgressHUD showSuccess:obj[@"msg"]];
                                                            //登录成功
                                                            NSDictionary *dic = obj[@"data"];
                                                            
                                                            UserInfoModel *user = [UserInfoModel shareUserModel];
                                                            user.userName = dic[@"username"];
                                                            user.passWord = @"";
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
                                                            user.user_birthday = dic[@"user_birthday"];
                                                            user.userPost = dic[@"userPost"];
                                                            
                                                            [user saveUserInfoToSanbox];
                                                            [self.navigationController popToRootViewControllerAnimated:YES];
                                                            
                                                        }else{
                                                            [MBProgressHUD showError:obj[@"msg"]];
                                                        }
    } fail:^(NSError *error) {
        
    }];
}

//获取验证码
- (IBAction)getVerifBtnClick:(UIButton *)sender {
    
    self.verifBtn.userInteractionEnabled = NO;
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_verifyPhone_login?userphone=%@",self.phoneField.text]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                           // 开启倒计时效果
                                                           [self openCountdown];
                                                           [MBProgressHUD showSuccess:obj[@"msg"]];
                                                           self.verifBtn.userInteractionEnabled = YES;
                                                       }else{
                                                           [MBProgressHUD showError:obj[@"msg"]];
                                                           self.verifBtn.userInteractionEnabled = YES;
                                                       }
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                       self.verifBtn.userInteractionEnabled = YES;
                                                       
                                                   }];
}

// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.verifBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.verifBtn setFont:[UIFont systemFontOfSize:12]];
                self.verifBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.verifBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.verifBtn setFont:[UIFont systemFontOfSize:12]];
                self.verifBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneField resignFirstResponder];
    [self.VerifField resignFirstResponder];
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
