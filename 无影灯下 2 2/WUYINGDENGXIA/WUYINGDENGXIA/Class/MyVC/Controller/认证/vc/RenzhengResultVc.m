//
//  RenzhengResultVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "RenzhengResultVc.h"

@interface RenzhengResultVc ()
@property (weak, nonatomic) IBOutlet UIButton *quedingBtn;

@end

@implementation RenzhengResultVc


- (void)viewDidLoad {
    [super viewDidLoad];
    self.quedingBtn.layer.cornerRadius = CGRectGetHeight(self.quedingBtn.frame)/2;//半径大小
    self.quedingBtn.layer.masksToBounds = YES;//是否切割
    NSNotification *notification =[NSNotification notificationWithName:@"JINZHIFANHUI" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    

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
//点击确定按钮
- (IBAction)sureBtnClick:(UIButton *)sender {
    // 开启返回手势
    NSNotification *notification =[NSNotification notificationWithName:@"HUIFUFANHUI" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //返回设置页
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
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
