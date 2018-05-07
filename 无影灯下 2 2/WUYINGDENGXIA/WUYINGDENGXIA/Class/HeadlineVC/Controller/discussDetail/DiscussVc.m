//
//  DiscussVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DiscussVc.h"
#import "inputView.h"
#import "IQKeyboardManager.h"

@interface DiscussVc ()<inputViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;//评论按钮

@property (nonatomic, strong) inputView *input;//输入框

@property (nonatomic,copy) NSString *inputStr;

@end

@implementation DiscussVc

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
    self.pinglunBtn.layer.cornerRadius = CGRectGetHeight(self.pinglunBtn.frame)/2;//半径大小
    self.pinglunBtn.layer.masksToBounds = YES;//是否切割
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
    return [self changeTitle:@"讨论详情"];
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

//评论按钮点击
- (IBAction)pinglunBtnClick:(UIButton *)sender {
    
    self.input = [[inputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen] .bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.input];
    if (self.inputStr.length > 0) {
        self.input.inputTextView.text = self.inputStr;
    }
    self.input.delegate = self;
    [self.input inputViewShow];
}

#pragma mark - textinput代理 -
-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{
    
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"key_dis_id":self.model.key_id,
                           @"user_id":user.userid,
                           @"key_dis_content":text
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_key_dis"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            [MBProgressHUD showSuccess:obj[@"msg"]];
                                                        }else{
                                                            [MBProgressHUD showError:obj[@"msg"]];
                                                        }
    } fail:^(NSError *error) {
        
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
