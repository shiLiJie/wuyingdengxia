//
//  PublicPageViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

typedef enum _chooseType{
    
    titleType = 0,//标题类型
    detailType    //内容类型
    
} chooseType;

#import "PublicPageViewController.h"

@interface PublicPageViewController ()<UITextViewDelegate>
//标题输入框
@property (nonatomic, strong) UITextView *titieTextLab;
//内容输入框
@property (nonatomic, strong) UITextView *detailTextView;
//图片区
@property (weak, nonatomic) IBOutlet UIView *picView;
//最底部区域
@property (weak, nonatomic) IBOutlet UIView *chooseView;

@property (nonatomic, assign) chooseType choosetype;
@end

@implementation PublicPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //添加ui控件
    [self addUi];
    
    [self.view bringSubviewToFront:self.chooseView];
    
    //为监听键盘高度添加两个观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
 
#pragma mark - UI -

//添加ui控件
-(void)addUi{
    
    //输入标题框
    self.titieTextLab = [[UITextView alloc] init];
    self.titieTextLab.frame = CGRectMake(17, 65, kScreen_Width-17, 46);
    [self.view addSubview:self.titieTextLab];
    self.titieTextLab.text = @"请输入文章标题";
    self.titieTextLab.font = [UIFont systemFontOfSize:13];
    self.titieTextLab.textColor = RGB(191, 191, 191);
    //输入内容框
    self.detailTextView = [[UITextView alloc] init];
    self.detailTextView.frame = CGRectMake(17, 115, kScreen_Width-17, kScreen_Height-115-130);
    [self.view addSubview:self.detailTextView];
    self.detailTextView.text = @"请输入文章内容";
    self.detailTextView.font = [UIFont systemFontOfSize:13];
    self.detailTextView.textColor = RGB(191, 191, 191);
    //设置代理
    self.titieTextLab.delegate = self;
    self.detailTextView.delegate = self;
    //设置标题框和内容框中间的分割线
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(17, 113, kScreen_Width-17, 1);
    lab.backgroundColor = RGB(232, 232, 232);
    [self.view addSubview:lab];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

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

#pragma mark - 按钮点击方法和私有方法 -
//选择图片按钮点击方法
- (IBAction)choosePicBtnClick:(UIButton *)sender {
}
//选择标签按钮点击方法
- (IBAction)chooseSheetBtnClick:(UIButton *)sender {
}

#pragma mark - textview代理方法 -
// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //开始编辑后判断是哪个输入框开始编辑
    if (textView == self.titieTextLab) {
        self.choosetype = titleType;
    }else{
        self.choosetype = detailType;
        self.detailTextView.frame = CGRectMake(17, 115, kScreen_Width-17, kScreen_Height-115-130-180 -39 -10 );
    }
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
    
}

//暂时或永久结束编辑调用
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView == self.titieTextLab) {
        //标题截取20字符
        if (textView.text.length >= 20){
            textView.text = [textView.text substringToIndex:20];
            NSLog(@"标题最多输入20个字");
        }
        //如果什么都没有输入,结束编辑后默认还原
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"请输入文章标题";
            textView.textColor = RGB(191, 191, 191);
            textView.font = [UIFont systemFontOfSize:13];
        }
    }else{
        //如果什么都没有输入,结束编辑后默认还原
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"请输入文章内容";
            textView.textColor = RGB(191, 191, 191);
            textView.font = [UIFont systemFontOfSize:13];
        }
    }
}

// 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

#pragma mark - 监听键盘通知方法 -
-(void)keyboardWillAppear:(NSNotification *)notification
{
    
    NSDictionary *info = [notification userInfo];
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //取出键盘位置大小信息
    CGRect keyboardBounds = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //记录Y轴变化
    CGFloat keyboardHeight = keyboardBounds.size.height;
    //上移动画options
    UIViewAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    
    
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{
        //根据选择的编辑框来决定键盘上的view上移距离
        if (self.choosetype == titleType) {
            self.chooseView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
        }else{
            self.chooseView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);

        }
        

    } completion:nil];
}


-(void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //取出动画时长
    CGFloat animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //下移动画options
    UIViewAnimationOptions options = (UIViewAnimationOptions)[[info valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    //回复动画
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:options animations:^{

        self.chooseView.transform = CGAffineTransformIdentity;
        self.detailTextView.frame = CGRectMake(17, 115, kScreen_Width-17, kScreen_Height-115-130);

    } completion:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self.titieTextLab resignFirstResponder];
//    [self.detailTextView resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注销通知用
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
