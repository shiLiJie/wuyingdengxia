//
//  MeetDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MeetDetailViewController.h"

@interface MeetDetailViewController ()

@end

@implementation MeetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.meetDetailText.text = @"移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限移动设备的屏幕⼤大⼩小是极其有限的,因此直接展⽰示在⽤用户眼前的内容也相当有限";
    
    

}

//由于Scroller不滚动,没办法才在didappear里设置滚动范围
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scroller.contentSize =  CGSizeMake(0, CGRectGetMaxY(self.meetDetailText.frame));
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"会议名称不能也不能太长"];
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}

//右上角分享
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    return btn;
}
-(void)right_button_event:(UIButton *)sender{
    
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - 私有方法 -
//参会按钮点击
- (IBAction)joinMeetBtnClick:(UIButton *)sender {
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
