//
//  JoinAnswerViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "JoinAnswerViewController.h"

@interface JoinAnswerViewController ()<UITextViewDelegate>

//问题标题
@property (nonatomic, strong) UITextView *titleLab;
//回答内容视图
@property (nonatomic, strong) UITextView *commentView;

@end

@implementation JoinAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor whiteColor];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.commentView];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(20, CGRectGetMaxY(self.titleLab.frame), Main_Screen_Width-40, 1);
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
}

-(UITextView *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UITextView alloc] init];
        _titleLab.delegate = self;
        _titleLab.text = @"请输入文章标题";
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.frame = CGRectMake(20, 70, Main_Screen_Width-40, 50);
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = RGB(191, 191, 191);
        _titleLab.contentSize = CGSizeMake(Main_Screen_Width-40, 50);

    }
    return _titleLab;
}

-(UITextView *)commentView{
    
    if (!_commentView) {
        _commentView = [[UITextView alloc] init];
        _commentView.frame = CGRectMake(0, CGRectGetMaxY(_titleLab.frame)+10, Main_Screen_Width, Main_Screen_Height/3);
        _commentView.delegate = self;
        _commentView.textContainerInset = UIEdgeInsetsMake(0, 20, 20, 20);
        _commentView.text = @"请输入文章内容";
        _commentView.font = [UIFont systemFontOfSize:13];
        _commentView.textColor = RGB(191, 191, 191);
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

#pragma mark - textview代理方法 -
// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

// 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView == self.titleLab) {
        if ([textView.text isEqualToString:@"请输入文章标题"]) {
            textView.text = @"";
        }
    }else{
        
        if ([textView.text isEqualToString:@"请输入文章内容"]) {
            textView.text = @"";
        }
    }
}

// 文本发生改变
- (void)textViewDidChange:(UITextView *)textView{
    
}

// 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
        return YES;
}

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
