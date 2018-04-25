//
//  RenzhengTwoVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "RenzhengTwoVc.h"
#import "BRPickerView.h"
#import "RenzhengThreeVc.h"

@interface RenzhengTwoVc ()
@property (weak, nonatomic) IBOutlet UITextField *yiyuanField;//医院field
@property (weak, nonatomic) IBOutlet UITextField *keshiField;//科室field
@property (weak, nonatomic) IBOutlet UITextField *zhiwuField;//职务field
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步
@property (weak, nonatomic) IBOutlet UIButton *upBtn;//上一步

@end

@implementation RenzhengTwoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextBtn.layer.cornerRadius = CGRectGetHeight(self.nextBtn.frame)/2;//半径大小
    self.nextBtn.layer.masksToBounds = YES;//是否切割
    self.upBtn.layer.cornerRadius = CGRectGetHeight(self.nextBtn.frame)/2;//半径大小
    self.upBtn.layer.masksToBounds = YES;//是否切割
    
    [self addTargetMethod];//监听文本输入
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
//选择职务
- (IBAction)chooseZhiwu:(UIButton *)sender {
    NSArray *arr = @[@"委员",@"主委员"];
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"请选择您的身份" dataSource:arr defaultSelValue:@"委员" resultBlock:^(id selectValue) {
        weakSelf.zhiwuField.text = selectValue;
    }];
}
//下一步
- (IBAction)nextStep:(UIButton *)sender {
    RenzhengThreeVc *vc = [[RenzhengThreeVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//上一步
- (IBAction)upStep:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//监听信息输入
-(void)addTargetMethod{
    [self.yiyuanField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.keshiField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
    if (textField == self.yiyuanField) {
        NSLog(@"textField1 - 医院输入框内容改变,当前内容为: %@",textField.text);
    }else{
        NSLog(@"textField1 - 科室输入框内容改变,当前内容为: %@",textField.text);
    }
    if (textField.text.length) {

    }else{

    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.yiyuanField resignFirstResponder];
    [self.keshiField resignFirstResponder];
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
