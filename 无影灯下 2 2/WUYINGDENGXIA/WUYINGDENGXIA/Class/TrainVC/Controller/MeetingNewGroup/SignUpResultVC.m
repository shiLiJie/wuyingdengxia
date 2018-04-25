//
//  SignUpResultVC.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "SignUpResultVC.h"

@interface SignUpResultVC ()
//会议名称
@property (weak, nonatomic) IBOutlet UILabel *meetNameLab;
//会议时间
@property (weak, nonatomic) IBOutlet UILabel *meetTimeLab;
//提交成功lab需要改变字体大小
@property (weak, nonatomic) IBOutlet UILabel *sucessLab;
//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;
//查看进度按钮
@property (weak, nonatomic) IBOutlet UIButton *lookProBtn;
//按钮底部约束,需要改变
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnConstraint;

@end

@implementation SignUpResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (kDevice_Is_iPhone5) {
        self.btnConstraint.constant = 10;
        self.sucessLab.font = [UIFont systemFontOfSize:9];
    }
    
    //切圆角
    self.goBackBtn.layer.masksToBounds = YES;
    self.goBackBtn.layer.cornerRadius = CGRectGetHeight(self.goBackBtn.frame);//2.0是圆角的弧度，根据需求自己更改
    self.goBackBtn.layer.borderColor = RGB(243, 243, 243).CGColor;//设置边框颜色
    self.goBackBtn.layer.borderWidth = 0.5f;//设置边框颜色
    self.goBackBtn.layer.cornerRadius = CGRectGetHeight(self.goBackBtn.frame)/2;
    //关键语句
    self.lookProBtn.layer.masksToBounds = YES;
    self.lookProBtn.layer.cornerRadius = CGRectGetHeight(self.lookProBtn.frame)/2;
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"报名提交"];
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    btn.hidden = YES;
    return btn;
}


#pragma mark - 私有方法 -
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}
- (IBAction)goBackBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)lookProBtnClick:(UIButton *)sender {
    
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
