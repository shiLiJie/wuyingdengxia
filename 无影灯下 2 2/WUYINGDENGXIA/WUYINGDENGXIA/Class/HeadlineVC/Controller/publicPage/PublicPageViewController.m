//
//  PublicPageViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PublicPageViewController.h"

@interface PublicPageViewController ()<UITextViewDelegate>
//标题输入框
@property (weak, nonatomic) IBOutlet UITextView *titieTextLab;

//内容输入框
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
//图片区
@property (weak, nonatomic) IBOutlet UIView *picView;
//最底部区域
@property (weak, nonatomic) IBOutlet UIView *chooseView;

@end

@implementation PublicPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titieTextLab.delegate = self;
    self.detailTextView.delegate = self;
}
 
#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"文章投稿"];
}
-(BOOL)hideNavigationBottomLine{
    return NO;
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

//右侧按钮设置点击
-(UIButton *)set_rightButton{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"投稿" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(191, 191, 191) forState:UIControlStateNormal];
    return btn;
}

-(void)right_button_event:(UIButton *)sender{
    NSLog(@"投稿");
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

#pragma mark - textview代理方法 -
// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

// 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == self.titieTextLab) {
        if ([textView.text isEqualToString:@"请输入文章标题"]) {
            textView.text = @"";
            textView.textColor = RGB(51, 51, 51);
            textView.font = BOLDSYSTEMFONT(15);
        }
    }else{
        
        if ([textView.text isEqualToString:@"请输入文章内容"]) {
            textView.text = @"";
            textView.textColor = RGB(51, 51, 51);
            textView.font = [UIFont systemFontOfSize:14];
        }
    }
}

// 文本发生改变
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >= 100)
    {
        textView.text = [textView.text substringToIndex:20];
        NSLog(@"标题最多输入20个字");
    }
}

// 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.titieTextLab resignFirstResponder];
    [self.detailTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
