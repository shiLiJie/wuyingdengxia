//
//  PageDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PageDetailViewController.h"
#import "CommentViewController.h"
#import "PersonViewController.h"

@interface PageDetailViewController ()

@end

@implementation PageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"文章详情"];
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
//参与评论按钮点击事件
- (IBAction)clickToComment:(UIButton *)sender {
    CommentViewController *comment = [[CommentViewController alloc] init];
    [self.navigationController pushViewController:comment animated:YES];
//    PersonViewController *comment = [[PersonViewController alloc] init];
//    [self.navigationController pushViewController:comment animated:YES];
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
