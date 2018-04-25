//
//  MyLiwuResultVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyLiwuResultVc.h"
#import "MyDuihuanVc.h"

@interface MyLiwuResultVc ()
@property (weak, nonatomic) IBOutlet UILabel *liwuName;//礼物名称
@property (weak, nonatomic) IBOutlet UILabel *liwuJiage;//礼物价格
@property (weak, nonatomic) IBOutlet UILabel *liwuJuanma;//卷码
@property (weak, nonatomic) IBOutlet UILabel *liwuDingdanhao;//订单号
@property (weak, nonatomic) IBOutlet UIButton *backBtn;//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *duihuanjiluBtn;//兑换记录按钮

@end

@implementation MyLiwuResultVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backBtn.layer.cornerRadius = CGRectGetHeight(self.backBtn.frame)/2;//半径大小
    self.backBtn.layer.borderWidth = 0.5f;//描边宽度
    self.backBtn.layer.borderColor = RGB(221, 221, 221).CGColor;
    self.backBtn.layer.masksToBounds = YES;//是否切割
    
    self.duihuanjiluBtn.layer.cornerRadius = CGRectGetHeight(self.duihuanjiluBtn.frame)/2;//半径大小
    self.duihuanjiluBtn.layer.masksToBounds = YES;//是否切割
    
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return YES;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"兑换结果"];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"") forState:UIControlStateNormal];
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
//返回
- (IBAction)goback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//兑换记录
- (IBAction)duihuanjilu:(UIButton *)sender {
    MyDuihuanVc *vc = [[MyDuihuanVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
