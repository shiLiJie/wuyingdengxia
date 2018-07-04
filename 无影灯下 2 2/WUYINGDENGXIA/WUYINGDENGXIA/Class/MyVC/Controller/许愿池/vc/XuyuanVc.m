//
//  XuyuanVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XuyuanVc.h"
#import "XuyuanResultVc.h"

@interface XuyuanVc ()<UITextViewDelegate>

//内容输入框
@property (nonatomic, strong) UITextView *detailTextView;
//底部视图区
@property (weak, nonatomic) IBOutlet UIView *chooseView;
//月亮币选择区view
@property (weak, nonatomic) IBOutlet UIView *bottomView;
//是否正在编辑中
@property (nonatomic, assign) BOOL isEditor;
//月亮比按钮
@property (weak, nonatomic) IBOutlet UIButton *yueliangbibtn;
//月亮币左右按钮间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint1;
//几个月亮币按钮
@property (weak, nonatomic) IBOutlet UIButton *yueliangbi1;
@property (weak, nonatomic) IBOutlet UIButton *yueliangbi2;
@property (weak, nonatomic) IBOutlet UIButton *yueliangbi3;
@property (weak, nonatomic) IBOutlet UIButton *yueliangbi4;
@property (weak, nonatomic) IBOutlet UIButton *yueliangbi5;
@property (weak, nonatomic) IBOutlet UIButton *yueliangbiOther;
//月亮币个数
@property (weak, nonatomic) IBOutlet UILabel *menoyLab;
//底部选择月亮币view约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@end

@implementation XuyuanVc

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //输入内容框
    self.detailTextView = [[UITextView alloc] init];
    if (kDevice_Is_iPhoneX) {
        self.detailTextView.frame = CGRectMake(17, 94, kScreen_Width-17, kScreen_Height-128-130);
    }else{
        self.detailTextView.frame = CGRectMake(17, 70, kScreen_Width-17, kScreen_Height-80-130);
    }
    
    [self.view addSubview:self.detailTextView];
    self.detailTextView.text = @"请输入要许愿的内容";
    self.detailTextView.font = [UIFont systemFontOfSize:13];
    self.detailTextView.textColor = RGB(191, 191, 191);
    //设置代理
    self.detailTextView.delegate = self;
    
    //不可投稿状态
    self.isEditor = NO;
    //切圆角
    self.yueliangbibtn.layer.cornerRadius = 12;//半径大小
    self.yueliangbibtn.layer.masksToBounds = YES;//是否切割
    self.yueliangbibtn.layer.borderColor  = RGB(102, 102, 102).CGColor;
    self.yueliangbibtn.layer.borderWidth = 0.5f;
    
    if (kDevice_Is_iPhoneX) {
        self.constraint.constant = 23;
        self.constraint1.constant = 23;
    }
    if (kDevice_Is_iPhone8) {
        self.constraint.constant = 23;
        self.constraint1.constant = 23;
    }
    if (kDevice_Is_iPhone5) {
        self.constraint.constant = 18;
        self.constraint1.constant = 18;
    }
    
    //其他金额按钮UI设置
    self.yueliangbiOther.layer.cornerRadius = CGRectGetHeight(self.yueliangbiOther.frame)/2;//半径大小
    self.yueliangbiOther.layer.borderWidth = 0.5f;//描边宽度
    self.yueliangbiOther.layer.borderColor = RGB201.CGColor;
    self.yueliangbiOther.layer.masksToBounds = YES;//是否切割
    //选择月亮币面值按钮UI设置
    [self initYueliangbiBtn:self.yueliangbi1];
    [self initYueliangbiBtn:self.yueliangbi2];
    [self initYueliangbiBtn:self.yueliangbi3];
    [self initYueliangbiBtn:self.yueliangbi4];
    [self initYueliangbiBtn:self.yueliangbi5];
    
    //为监听键盘高度添加两个观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view bringSubviewToFront:self.chooseView];
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"我要许愿"];
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

//右侧按钮设置点击
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(kScreen_Width-44, 0, 44, 60);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];
    
    return btn;
}

//投稿按钮点击方法
-(void)right_button_event:(UIButton *)sender{
    if (self.isEditor) {
        UserInfoModel *user = [UserInfoModel shareUserModel];
        [user loadUserInfoFromSanbox];
        if (user.loginStatus) {
            NSString *mooncash = @"";
            if ([self.yueliangbibtn.titleLabel.text integerValue]>0) {
                mooncash = self.yueliangbibtn.titleLabel.text;
            }else{
                mooncash = @"0";
            }
            NSDictionary *dict = @{
                                   @"userid":user.userid,
                                   @"content":self.detailTextView.text,
                                   @"cash":mooncash
                                   };
            [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_desire"]
                                                         parameters:dict
                                                            success:^(id obj) {
                                                                
                                                                if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                    
                                                                    //跳转到提交结果界面
                                                                    XuyuanResultVc *QuestionResult = [[XuyuanResultVc alloc] init];
                                                                    [self.navigationController pushViewController:QuestionResult animated:YES];
                                                                }else{
                                                                    
                                                                }
                                                            }
                                                               fail:^(NSError *error) {
                                                                   
                                                               }];
        }else{
            LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {
                
            }];
            [self.navigationController pushViewController:loginVc animated:YES];
        }
        
        

    }else{

    }
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - 私有方法 -
//选择月亮币
- (IBAction)chooseYLB:(UIButton *)sender {
    //先退键盘
    [self.detailTextView resignFirstResponder];
    //弹出选择月亮币视图
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomViewConstraint.constant = 0;
        [self.bottomView layoutIfNeeded];
        [self.view layoutIfNeeded];
        self.chooseView.transform = CGAffineTransformMakeTranslation(0, -self.bottomView.frame.size.height);
    }];
}

//初始化月亮币按钮状态
-(void)initYueliangbiBtn:(UIButton *)btn{
    
    btn.layer.cornerRadius = CGRectGetHeight(btn.frame)/2;//半径大小
    btn.layer.borderWidth = 0.5f;//描边宽度
    btn.layer.masksToBounds = YES;//是否切割
    btn.layer.borderColor = RGB201.CGColor;
    [btn setBackgroundColor:[UIColor whiteColor]];
    if ([self.menoyLab.text integerValue] < [btn.titleLabel.text integerValue]) {
        [btn setTitleColor:RGB201 forState:UIControlStateNormal];
    }else{
        [btn setTitleColor:RGB51 forState:UIControlStateNormal];
    }
}

//点击月亮币按钮金额方法
-(void)clickYueliangbiMoneyBtn:(UIButton *)btn
                          btn1:(UIButton *)btn1
                          btn2:(UIButton *)btn2
                          btn3:(UIButton *)btn3
                          btn4:(UIButton *)btn4{
    if ([self.menoyLab.text integerValue] < [btn.titleLabel.text integerValue]) {
        return;
    }else{
        [btn setBackgroundColor:RGB(252, 186, 42)];
        btn.layer.borderColor = RGB(252, 186, 42).CGColor;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.yueliangbibtn setFont:[UIFont systemFontOfSize:11]];
        [self.yueliangbibtn setTitleColor:RGB(252, 186, 42) forState:UIControlStateNormal];
        //设置选中的月亮币
        [self.yueliangbibtn setTitle:btn.titleLabel.text forState:UIControlStateNormal];
        self.yueliangbibtn.layer.borderColor  = RGB(252, 188, 41).CGColor;
        self.yueliangbibtn.layer.borderWidth = 0.5f;
        
        [self initYueliangbiBtn:btn1];
        [self initYueliangbiBtn:btn2];
        [self initYueliangbiBtn:btn3];
        [self initYueliangbiBtn:btn4];
    }
}

- (IBAction)yueliangbi1:(UIButton *)sender {
    [self clickYueliangbiMoneyBtn:sender btn1:self.yueliangbi2 btn2:self.yueliangbi3 btn3:self.yueliangbi4 btn4:self.yueliangbi5];
}
- (IBAction)yueliangbi2:(UIButton *)sender {
    [self clickYueliangbiMoneyBtn:sender btn1:self.yueliangbi1 btn2:self.yueliangbi3 btn3:self.yueliangbi4 btn4:self.yueliangbi5];
}
- (IBAction)yueliangbi3:(UIButton *)sender {
    [self clickYueliangbiMoneyBtn:sender btn1:self.yueliangbi2 btn2:self.yueliangbi1 btn3:self.yueliangbi4 btn4:self.yueliangbi5];
}
- (IBAction)yueliangbi4:(UIButton *)sender {
    [self clickYueliangbiMoneyBtn:sender btn1:self.yueliangbi2 btn2:self.yueliangbi3 btn3:self.yueliangbi1 btn4:self.yueliangbi5];
}
- (IBAction)yueliangbi5:(UIButton *)sender {
    [self clickYueliangbiMoneyBtn:sender btn1:self.yueliangbi2 btn2:self.yueliangbi3 btn3:self.yueliangbi4 btn4:self.yueliangbi1];
}
//选择其他金额月亮币
- (IBAction)yueliangbiOther:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入金额" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    __weak typeof(self) weakSelf =self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            //获取第1个输入框；
            UITextField *userNameTextField = alertController.textFields.firstObject;
            if ([weakSelf.menoyLab.text integerValue] < [userNameTextField.text integerValue]){
                [MBProgressHUD showError:@"当前月亮币不足"];
            }else{
                [self.yueliangbibtn setFont:[UIFont systemFontOfSize:11]];
                [self.yueliangbibtn setTitleColor:RGB(252, 186, 42) forState:UIControlStateNormal];
                self.yueliangbibtn.layer.borderColor  = RGB(252, 188, 41).CGColor;
                self.yueliangbibtn.layer.borderWidth = 0.5f;
                [self.yueliangbibtn setTitle:userNameTextField.text forState:UIControlStateNormal];
            }
        });
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入金额";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - textview代理方法 -
// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (kDevice_Is_iPhoneX) {
        self.detailTextView.frame = CGRectMake(17, 94, kScreen_Width-17, kScreen_Height-128-130-180 -39 -10 );
    }else{
        self.detailTextView.frame = CGRectMake(17, 70, kScreen_Width-17, kScreen_Height-80-130-180 -39 -10 );
    }
    
    
    return YES;
}

// 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请输入要许愿的内容"]) {
        textView.text = @"";
        textView.textColor = RGB(51, 51, 51);
        textView.font = [UIFont systemFontOfSize:14];
    }
}

// 文本发生改变
- (void)textViewDidChange:(UITextView *)textView{
    if (
        ![self.detailTextView.text isEqualToString:@""] &&
        ![self.detailTextView.text isEqualToString:@"请输入要许愿的内容"])
    {
        self.isEditor = YES;
        [self.right_button setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];//右上角按钮变蓝色
        self.right_button.userInteractionEnabled = YES;
    }else{
        self.isEditor = NO;
        [self.right_button setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];//右上角按钮变灰色
        self.right_button.userInteractionEnabled = YES;
    }
}

//暂时或永久结束编辑调用
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    //如果什么都没有输入,结束编辑后默认还原
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入要许愿的内容";
        textView.textColor = RGB(191, 191, 191);
        textView.font = [UIFont systemFontOfSize:13];
    }
}

// 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

#pragma mark - 监听键盘通知方法 -
-(void)keyboardWillAppear:(NSNotification *)notification
{
    //弹出键盘需要先回收月亮币选择框
    self.bottomViewConstraint.constant = -140;
    NSDictionary *info = [notification userInfo];
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //取出键盘位置大小信息
    CGRect keyboardBounds = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //记录Y轴变化
    CGFloat keyboardHeight = keyboardBounds.size.height;
    //上移动画options
    UIViewAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    
    
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{
        //根据选择的编辑框来决定键盘上的view上移距离
        //        if (self.choosetype == titleType) {
        //            self.chooseView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
        //        }else{
        self.chooseView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
        //
        //        }
        
        
    } completion:nil];
}
-(void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //下移动画options
    UIViewAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    //回复动画
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{
        
        self.chooseView.transform = CGAffineTransformIdentity;
        if (kDevice_Is_iPhoneX) {
            self.detailTextView.frame = CGRectMake(17, 94, kScreen_Width-17, kScreen_Height-128-130);
        }else{
            self.detailTextView.frame = CGRectMake(17, 70, kScreen_Width-17, kScreen_Height-80-130);
        }
        
        
    } completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注销通知用
-(void)dealloc{
    
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
