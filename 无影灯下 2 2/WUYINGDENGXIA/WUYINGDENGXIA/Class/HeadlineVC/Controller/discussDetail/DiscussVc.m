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
//评论id
@property (nonatomic,copy) NSString *comentId;
//评论还是回复
@property (nonatomic,assign) BOOL isPinglun;

@end

@implementation DiscussVc

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [self.navigationController.navigationBar setHidden:NO];
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
    
    self.isPinglun = YES;
}

//设置网页
-(void)setWeb{
    //配置环境
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    userContentController =[[WKUserContentController alloc]init];
    configuration.userContentController = userContentController;
    //wkweb
    if (isIOS10) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 65, kScreen_Width, kScreen_Height-48-65)configuration:configuration];
    }else{
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48)configuration:configuration];
    }
    
    _webView.UIDelegate = self;
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://39.106.2.216/Wuyingdengxia/DiscussDetails.html?key_dis_id=%@&userid=%@&type=%@",self.model.key_dis_id ,user.userid,self.model.type]]]];
    
    
    [self.view addSubview:_webView];
    
    //注册方法
    WKWebViewDelegate * delegateController = [[WKWebViewDelegate alloc]init];
    delegateController.delegate = self;
    
    [userContentController addScriptMessageHandler:delegateController  name:@"asd"];
    [userContentController addScriptMessageHandler:delegateController  name:@"refreshDiscussList"];
    [userContentController addScriptMessageHandler:delegateController  name:@"comment_id"];
    [userContentController addScriptMessageHandler:delegateController  name:@"postReplyComment"];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //点用户头像
    if ([message.name isEqualToString:@"asd"]) {
        self.isPinglun = YES;
        //做处理
        [self pushToPersonViewWithUserid:message.body];
    }
    
    //点用户头像
    if ([message.name isEqualToString:@"comment_id"]) {
        self.isPinglun = NO;
        //做处理
        self.comentId = message.body;
    }
}
// oc调用JS方法   页面加载完成之后调用
- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{
    
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


//跳转到个人页
-(void)pushToPersonViewWithUserid:(NSString *)userid{
    PersonViewController *publishPerson = [[PersonViewController alloc] init];
    publishPerson.userid = userid;
    [self.navigationController pushViewController:publishPerson animated:YES];
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
    
    if (self.isPinglun) {
        //评论
        [self postPinglunWithText:text userId:user.userid];
    }else{
        //回复
        [self postCommentWithText:text userId:user.userid];
    }

}


/**
 文章评论
 
 @param text 评论内容
 */
-(void)postPinglunWithText:(NSString *)text userId:(NSString *)userid{
    NSDictionary *dict = @{
                           @"key_dis_id":self.model.key_dis_id,
                           @"user_id":userid,
                           @"key_dis_content":text
                           };
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_key_dis"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {

                                                            NSString *jsStr = [NSString stringWithFormat:@"refreshDiscussList('%@')",text];
//                                                            NSString *jsStr = [NSString stringWithFormat:@"refreshDiscussList()"];
                                                            
                                                            [_webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                                                                NSLog(@"%@",error);
                                                            }];
                                                            
                                                        }else{
                                                            [MBProgressHUD showError:obj[@"msg"]];
                                                        }
                                                        
                                                        
                                                    } fail:^(NSError *error) {
                                                        //
                                                    }];
}

/**
 评论回复
 
 @param text 评论内容
 */
-(void)postCommentWithText:(NSString *)text userId:(NSString *)userid{
    
    NSDictionary *dict = @{
                           @"userid": userid,
                           @"toid" : self.comentId,
                           @"comType":@"1",
                           @"comContent":text,
                           @"comment_to_type":@"2"
                           };
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            NSString *jsStr = [NSString stringWithFormat:@"postReplyComment()"];
                                                            
                                                            [_webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                                                                
                                                            }];
                                                            
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
