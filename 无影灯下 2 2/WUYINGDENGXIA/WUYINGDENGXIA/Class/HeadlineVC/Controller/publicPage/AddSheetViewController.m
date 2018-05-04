//
//  AddSheetViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AddSheetViewController.h"
#import "IQKeyboardManager.h"

@interface AddSheetViewController ()<UITextFieldDelegate>
//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *sueBtn;
//自定义标签textfield
@property (weak, nonatomic) IBOutlet UITextField *addSheetTextfield;

@end

@implementation AddSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //输入框设置代理
    self.addSheetTextfield.delegate = self;
    
    //输入框切圆角
    self.addSheetTextfield.layer.cornerRadius = self.addSheetTextfield.frame.size.height / 2;
    self.addSheetTextfield.layer.masksToBounds = YES;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(50,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.addSheetTextfield.leftView = leftView;
    self.addSheetTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.addSheetTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //添加标签视图
    [self addSheetUi];
    //监听自定义标签文本输入
    [self addTargetMethod];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//}
-(void)viewWillDisappear:(BOOL)animated{
    //取消标签选择
    [self.newsMenu dismissNewsMenu];
//    [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"添加标签"];
}
-(BOOL)hideNavigationBottomLine{
    return NO;
}
//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"cha1") forState:UIControlStateNormal];
    return btn;
}
//左上返回按钮
-(void)left_button_event:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//添加标签视图
-(void)addSheetUi{
    //初始化
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu1];
    self.newsMenu = sheetMenu;
    sheetMenu.mySubjectArray = @[@"科技科技科技科",@"科技2",@"科技3",@"科技4",@"科技5"].mutableCopy;
    sheetMenu.recommendSubjectArray = @[@"体育",@"军事",@"音乐",@"电影",@"中国风",@"摇滚",@"小说",@"梦想",@"机器",@"电脑"].mutableCopy;
    
    //设置视图界面,从新设置的时候 recommendSubjectArray 数组从新定义,然后在调用次方法
    [self.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
        cofig.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    }];
    
    [self.view addSubview:self.newsMenu];
    //配置界面内容
    self.newsMenu.closeMenuButton.hidden = YES;
    self.newsMenu.editMenuButton.frame = CGRectMake(kScreen_Width - 70, 0,50, 30);
    self.newsMenu.myTitleLab1.text = @"已选标签";
    self.newsMenu.recommentTitleLab.text = @"推荐标签";
    
    //回调编辑好的兴趣标签
    [self.newsMenu updataItmeArray:^(NSMutableArray *itemArray) {
        if (self.clossviewblock != nil) {
            self.clossviewblock(itemArray);
        }
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [sheetMenu addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - 私有方法 -
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.addSheetTextfield resignFirstResponder];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}
- (IBAction)sureBtnClick:(UIButton *)sender {
    NSLog(@"创建新标签");
}

#pragma mark - 输入框代理方法 -
-(void)addTargetMethod{
    [self.addSheetTextfield addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textField1TextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if (textField.text.length) {
        self.sueBtn.userInteractionEnabled = YES;
        [self.sueBtn setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
    }else{
        self.sueBtn.userInteractionEnabled = NO;
        [self.sueBtn setTitleColor:RGB(185, 185, 185) forState:UIControlStateNormal];
    }
}
//根据输入内容变换确认按钮颜色和可用性
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if ([textField.text isEqualToString:@""]) {
//        self.sueBtn.userInteractionEnabled = NO;
//        [self.sueBtn setTitleColor:RGB(185, 185, 185) forState:UIControlStateNormal];
//    }else{
//        self.sueBtn.userInteractionEnabled = YES;
//        [self.sueBtn setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
//    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.addSheetTextfield resignFirstResponder];
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
