//
//  RenzhengOneVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "RenzhengOneVc.h"
#import "BRPickerView.h"
#import "RenzhengTwoVc.h"

@interface RenzhengOneVc ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;//姓名field
@property (weak, nonatomic) IBOutlet UITextField *phoneField;//电话field
@property (weak, nonatomic) IBOutlet UITextField *shenfenField;//身份field
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步按钮
@property (weak, nonatomic) IBOutlet UITextField *userCarId;//身份证号field


@end

@implementation RenzhengOneVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextBtn.layer.cornerRadius = CGRectGetHeight(self.nextBtn.frame)/2;//半径大小
    self.nextBtn.layer.masksToBounds = YES;//是否切割
    
    [self addTargetMethod];//监听文本输入
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    self.phoneField.text = user.phoneNum;
    if (!kStringIsEmpty(user.userIdcard)) {
        if (![user.userIdcard isEqualToString:@"0"]) {
            self.userCarId.text = user.userIdcard;
        }
    }
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"资料认证"];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}
    
-(void)left_button_event:(UIButton *)sender{
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
//选择身份
- (IBAction)chooseShenfenClick:(UIButton *)sender {
    [self.nameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.userCarId resignFirstResponder];
    
    NSArray *arr = @[@"核心组",@"委员",@"主委",@"行业专家",@"普通"];
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"请选择您的身份" dataSource:arr defaultSelValue:@"委员" resultBlock:^(id selectValue) {
        weakSelf.shenfenField.text = selectValue;
    }];
}
//下一步按钮
- (IBAction)nextClick:(UIButton *)sender {
    
    if (!kStringIsEmpty(self.nameField.text)) {
        if (!kStringIsEmpty(self.phoneField.text)) {
            if (!kStringIsEmpty(self.shenfenField.text)) {
                if (!kStringIsEmpty(self.userCarId.text)) {
                    RenzhengTwoVc *vc = [[RenzhengTwoVc alloc] init];
                    
                    vc.nameField = self.nameField.text;
                    vc.phoneField = self.phoneField.text;
                    vc.shenfenField = self.shenfenField.text;
                    vc.usercardid = self.userCarId.text;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [MBProgressHUD showError:@"请先完善信息"];
                }

            }else{
                [MBProgressHUD showError:@"请先完善信息"];
            }
        }else{
            [MBProgressHUD showError:@"请先完善信息"];
        }
    }else{
        [MBProgressHUD showError:@"请先完善信息"];
    }
    
}

//监听信息输入
-(void)addTargetMethod{
    [self.nameField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.userCarId addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
    if (textField == self.nameField) {
//        NSLog(@"textField1 - 姓名输入框内容改变,当前内容为: %@",textField.text);
    }else{
//        NSLog(@"textField1 - 电话输入框内容改变,当前内容为: %@",textField.text);
    }
    if (textField.text.length) {
        
    }else{
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.userCarId resignFirstResponder];
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
