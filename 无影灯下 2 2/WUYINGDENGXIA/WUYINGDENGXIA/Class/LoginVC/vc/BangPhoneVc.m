//
//  BangPhoneVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BangPhoneVc.h"

@interface BangPhoneVc ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *VerifField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *verifBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation BangPhoneVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verifBtn.layer.cornerRadius = CGRectGetHeight(self.verifBtn.frame)/2;//半径大小
    self.verifBtn.layer.masksToBounds = YES;//是否切割
    
    self.registBtn.layer.cornerRadius = CGRectGetHeight(self.registBtn.frame)/2;//半径大小
    self.registBtn.layer.masksToBounds = YES;//是否切割
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneField resignFirstResponder];
    [self.VerifField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}

//获取验证码
- (IBAction)getVerif:(UIButton *)sender {
    //改变验证码按钮样式
    [self openCountdown];
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

//确定
- (IBAction)sureBtnClick:(UIButton *)sender {
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
