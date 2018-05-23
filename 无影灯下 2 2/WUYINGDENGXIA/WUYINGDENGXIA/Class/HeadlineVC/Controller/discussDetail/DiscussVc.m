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

@interface DiscussVc ()<inputViewDelegate,WKUIDelegate,WKNavigationDelegate,WKWebViewDelegate>
{
    WKUserContentController * userContentController;
}

@property(strong,nonatomic)WKWebView *webView;

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
    
    //设置网页
    [self setWeb];
}

//设置网页
-(void)setWeb{
    //配置环境
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    userContentController =[[WKUserContentController alloc]init];
    configuration.userContentController = userContentController;
    //wkweb
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48)configuration:configuration];
    _webView.UIDelegate = self;
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://39.106.2.216/Wuyingdengxia/DiscussDetails.html?key_dis_id=%@&Userid=%@",self.model.key_dis_id ,user.userid]]]];
    
    [self.view addSubview:_webView];
    
    //注册方法
    WKWebViewDelegate * delegateController = [[WKWebViewDelegate alloc]init];
    delegateController.delegate = self;
    
    [userContentController addScriptMessageHandler:delegateController  name:@"asd"];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    if ([message.name isEqualToString:@"asd"]) {
        //做处理
    }
}
// oc调用JS方法   页面加载完成之后调用
- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{
    
    //say()是JS方法名，completionHandler是异步回调block
    [_webView evaluateJavaScript:@"asd()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //        NSLog(@"%@",result);
        
    }];
    
    if (_webView.title.length > 0) {
        self.title = _webView.title;
    }
    
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
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    //判断用户登录状态
    if (user.loginStatus) {
        self.input = [[inputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen] .bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self.view addSubview:self.input];
        if (self.inputStr.length > 0) {
            self.input.inputTextView.text = self.inputStr;
        }
        self.input.delegate = self;
        [self.input inputViewShow];
    }else{
        LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {
            
        }];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

#pragma mark - textinput代理 -
-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{
    
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"key_dis_id":self.model.key_dis_id,
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
