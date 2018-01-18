//
//  AnswerViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AnswerViewController.h"
#import "JoinAnswerViewController.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"问题详情"];
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
//弹出问答评论导航控制器
- (IBAction)AnswerQuestionClick:(UIButton *)sender {
    JoinAnswerViewController *comment = [[JoinAnswerViewController alloc] init];
    [self.navigationController pushViewController:comment animated:YES];
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
