//
//  PlayDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/12.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PlayDetailViewController.h"

@interface PlayDetailViewController ()

@end

@implementation PlayDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"视频主题名称"];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
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

#pragma mark - 私有方法 -

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
