//
//  AnswerViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AnswerViewController.h"
#import "inputView.h"
#import "IQKeyboardManager.h"

@interface AnswerViewController ()<inputViewDelegate>
//输入框
@property (nonatomic, strong) inputView *input;
//圆角view
@property (weak, nonatomic) IBOutlet UIView *yuanjiaoview;

@property (nonatomic,copy) NSString *inputStr;

@end

@implementation AnswerViewController

#pragma mark - UI -
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //view切圆角
    self.yuanjiaoview.layer.cornerRadius = 17;
    self.yuanjiaoview.layer.masksToBounds = YES;//是否切割
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:self.questionModel.question_title.length >0 ? self.questionModel.question_title : @"问题详情"];
//    return [self changeTitle:@"问题详情"];
}

-(UIColor*)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - 私有方法 -
//弹出问答评论导航控制器
- (IBAction)AnswerQuestionClick:(UIButton *)sender {
    
    self.input = [[inputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen] .bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.input];
    if (self.inputStr.length > 0) {
        self.input.inputTextView.text = self.inputStr;
    }
    self.input.delegate = self;
    [self.input inputViewShow];
}
- (IBAction)shoucang:(UIButton *)sender {
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSLog(@"%@",self.questionModel);
    NSDictionary *dic = @{
                          @"userid":user.userid,
                          @"toid":self.questionModel.question_id,
                          @"type":@"4"
                          };
    
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_collection"]
                                                 parameters:dic
                                                    success:^(id obj) {
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            [sender setImage:GetImage(@"yishoucang") forState:UIControlStateNormal];
                                                        }else{
                                                            
                                                        }
                                                    }
                                                       fail:^(NSError *error) {
                                                           
                                                       }];
}
- (IBAction)zhuanfa:(UIButton *)sender {
}

#pragma mark - textinput代理 -
-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"quesid":self.questionModel.question_id,
                           @"userid":user.userid,
                           @"anwContent":text
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_anwser"] parameters:dict success:^(id obj) {
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            
            [MBProgressHUD showSuccess:obj[@"msg"]];
        }else{
            [MBProgressHUD showError:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"评论失败"];
    }];
    
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
