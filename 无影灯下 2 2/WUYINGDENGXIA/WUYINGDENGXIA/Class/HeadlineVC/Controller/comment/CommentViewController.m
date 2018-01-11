//
//  CommentViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *commentView;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor whiteColor];
    
    [self.view addSubview:self.commentView];
}

-(UITextView *)commentView{
    
    if (!_commentView) {
        _commentView = [[UITextView alloc] init];
        _commentView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height/2);
        _commentView.delegate = self;
        _commentView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        _commentView.text = @"讨论正文";
        _commentView.font = [UIFont systemFontOfSize:15];
        _commentView.textColor = [UIColor lightGrayColor];
//        //初始化就是编辑模式
//        [_commentView becomeFirstResponder];
    }
    return _commentView;
}

//导航颜色
-(UIColor*)set_colorBackground{
    return RGB(247, 247, 247);
}

//右侧按钮设置点击
-(UIButton *)set_rightButton{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
}

-(void)right_button_event:(UIButton*)sender{
    
}

////左侧按钮设置点击
//-(UIButton *)set_leftButton{
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    return btn;
//}

//-(void)left_button_event:(UIButton*)sender{
//
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - textview代理方法 -
// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

// 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"讨论正文"]) {
        textView.text = @"";
    }
}

// 文本发生改变
- (void)textViewDidChange:(UITextView *)textView{
    
}

// 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    return YES;
}
//// 将要结束编辑
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    return YES;
//}
// 结束编辑
//- (void)textViewDidEndEditing:(UITextView *)textView{
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.commentView resignFirstResponder];
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
