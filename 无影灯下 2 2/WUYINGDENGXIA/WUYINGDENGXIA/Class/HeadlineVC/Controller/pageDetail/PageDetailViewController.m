//
//  PageDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PageDetailViewController.h"
#import "PersonViewController.h"
#import "inputView.h"
#import "IQKeyboardManager.h"



@interface PageDetailViewController ()<inputViewDelegate,WKUIDelegate,WKNavigationDelegate,WKWebViewDelegate,UIGestureRecognizerDelegate>
{
    WKUserContentController * userContentController;
}

@property(strong,nonatomic)WKWebView *webView;

//输入框
@property (nonatomic, strong) inputView *input;
//评论按钮
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
//点赞
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
//收藏
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
//底部评论view
@property (weak, nonatomic) IBOutlet UIView *pinglunView;
//评论内容
@property (nonatomic,copy) NSString *inputStr;
//评论id
@property (nonatomic,copy) NSString *comentId;
//评论还是回复
@property (nonatomic,assign) BOOL isPinglun;

//是否收藏,是否点赞标记
@property (nonatomic, assign) BOOL isShoucang;
@property (nonatomic, assign) BOOL isZan;

@end

@implementation PageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pinglunBtn.layer.cornerRadius = CGRectGetHeight(self.pinglunBtn.frame)/2;//半径大小
    self.pinglunBtn.layer.masksToBounds = YES;//是否切割
    //设置网页
    [self setWeb];
    //把评论放在最上层
//    [self.view bringSubviewToFront:self.pinglunView];
    // 接收分享回调通知
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXShare" object:nil];
    // 检查是否装了微信
    if ([WXApi isWXAppInstalled]) {
        
    }
    //获取文章详情
    [self getPageDetail];
    
    self.isPinglun = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [self.navigationController.navigationBar setHidden:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}


/**
 获取文章详情
 */
-(void)getPageDetail{
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_articleinfo_byid?articleid=%@&userid=%@",self.articleid,user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                           
                                                           NSDictionary *dict = obj[@"data"];
                                                           if ([dict[@"is_support"] isEqualToString:@"1"]) {
                                                               [self.zanBtn setImage:GetImage(@"xiaodianzan2") forState:UIControlStateNormal];
                                                               self.isZan = YES;
                                                           }else{
                                                               [self.zanBtn setImage:GetImage(@"dadianzan") forState:UIControlStateNormal];
                                                               self.isZan = NO;
                                                           }
                                                           
                                                           if ([dict[@"is_collection"] isEqualToString:@"1"]) {
                                                               [self.shoucangBtn setImage:GetImage(@"yishoucang") forState:UIControlStateNormal];
                                                               self.isShoucang = YES;
                                                           }else{
                                                               [self.shoucangBtn setImage:GetImage(@"shoucang") forState:UIControlStateNormal];
                                                               self.isShoucang = NO;
                                                           }
                                                       }else{
                                                           [MBProgressHUD showError:obj[@"msg"]];
                                                       }
                                                       
        
    }
                                                      fail:^(NSError *error) {
        
    }];
}

//设置网页
-(void)setWeb{
    //配置环境
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    userContentController =[[WKUserContentController alloc]init];
    configuration.userContentController = userContentController;
    //wkweb
    if (kDevice_Is_iPhoneX) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48-34)configuration:configuration];
    }else{
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48)configuration:configuration];
    }
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;

    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (self.MyPage) {
        //我的投稿详情
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/DetailsArticleMy.html?articleid=%@&userid=%@",self.articleid,user.userid]]]];
    }else{
        //普通文章详情
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/article_details.html?articleid=%@&userid=%@",self.articleid,user.userid]]]];
    }
    
    

    [self.view addSubview:_webView];
    
    //注册方法
    WKWebViewDelegate * delegateController = [[WKWebViewDelegate alloc]init];
    delegateController.delegate = self;
    
    [userContentController addScriptMessageHandler:delegateController  name:@"asd"];
    [userContentController addScriptMessageHandler:delegateController  name:@"refreshcomment"];
    [userContentController addScriptMessageHandler:delegateController  name:@"comment_id"];
    [userContentController addScriptMessageHandler:delegateController  name:@"postReplyComment"];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60); 
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    if (self.webView.canGoBack==YES) {
        
        [self.webView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}
//参与评论按钮点击事件
- (IBAction)clickToComment:(UIButton *)sender {
    
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
//点赞
- (IBAction)dianzan:(UIButton *)sender {
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    __weak typeof(self) weakSelf = self;

    //判断用户登录状态
    if (user.loginStatus) {
        
        if (!self.isZan) {
            //点赞
            [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_support?userid=%@&toid=%@&supType=1",user.userid,self.articleid]]
                                                        parameters:nil
                                                           success:^(id obj) {
                                                               if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                   weakSelf.isZan = YES;
                                                                   [weakSelf.zanBtn setImage:GetImage(@"xiaodianzan2") forState:UIControlStateNormal];
                                                               }else{
                                                                   
                                                               }
                                                           }
                                                              fail:^(NSError *error) {
                                                                  
                                                              }];
        }else{
            //取消点赞
            NSDictionary *dic = @{
                                  @"userid":user.userid,
                                  @"toid":self.articleid,
                                  @"supType":@"1"
                                  };
            [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_cel_support"]
                                                        parameters:dic
                                                           success:^(id obj) {
                                                               if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                   weakSelf.isZan = NO;
                                                                   [weakSelf.zanBtn setImage:GetImage(@"dadianzan") forState:UIControlStateNormal];
                                                               }else{
                                                                   
                                                               }
                                                           }
                                                              fail:^(NSError *error) {
                                                                  
                                                              }];
        }
        
    }else{
        LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {
            
        }];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}
//收藏
- (IBAction)shoucang:(UIButton *)sender {
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    //判断用户登录状态
    if (user.loginStatus) {
        //收藏
        if (!self.isShoucang) {
            NSDictionary *dic = @{
                                  @"userid":user.userid,
                                  @"toid":self.articleid,
                                  @"type":@"1"
                                  };
            
            __weak typeof(self) weakSelf = self;
            [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_collection"]
                                                         parameters:dic
                                                            success:^(id obj) {
                                                                if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                    weakSelf.isShoucang = YES;
                                                                    [weakSelf.shoucangBtn setImage:GetImage(@"yishoucang") forState:UIControlStateNormal];
                                                                }else{
                                                                    
                                                                }
                                                            }
                                                               fail:^(NSError *error) {
                                                                   
                                                               }];
        }else{
            //取消收藏
            NSDictionary *dic = @{
                                  @"userid":user.userid,
                                  @"toid":self.articleid,
                                  @"type":@"1"
                                  };
            
            __weak typeof(self) weakSelf = self;
            [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_cel_collect"]
                                                         parameters:dic
                                                            success:^(id obj) {
                                                                if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                    weakSelf.isShoucang = NO;
                                                                    [weakSelf.shoucangBtn setImage:GetImage(@"shoucang") forState:UIControlStateNormal];
                                                                }else{
                                                                    
                                                                }
                                                            }
                                                               fail:^(NSError *error) {
                                                                   
                                                               }];
        }
        
    }else{
        LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {
            
        }];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

#pragma mark - 私有action -
- (void)getOrderPayResult:(NSNotification *)notification
{
    // 注意通知内容类型的匹配
    if (notification.object == 0)
    {
//        NSLog(@"分享成功");
    }
}

//转发
- (IBAction)zhuanfa:(UIButton *)sender {

    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];

    //判断用户登录状态
    if (user.loginStatus) {
        
        WXMediaMessage * message = [WXMediaMessage message];
        message.title = self.model.article_title;
        message.description = self.model.article_content;
        [message setThumbImage:[UIImage imageNamed:self.model.article_img_path]];
//        [message setThumbImage:GetImage(@"tx")];
        
        WXWebpageObject * webpageObject = [WXWebpageObject object];
        
        if (self.MyPage) {
            //加载我的投稿详情
            webpageObject.webpageUrl = [NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/DetailsArticleMy.html?articleid=%@&userid=%@",self.articleid,user.userid];
        }else{
            //普通文章详情
            webpageObject.webpageUrl = [NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/article_details.html?articleid=%@&userid=%@",self.articleid,user.userid];
        }
        
        message.mediaObject = webpageObject;
        
        SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        

        NSArray *titles = @[@"发送给朋友",@"分享到朋友圈"];
        NSArray *imageNames = @[@"wxfx",@"pyqfx"];
        HLActionSheet *sheet = [[HLActionSheet alloc] initWithTitles:titles iconNames:imageNames];
        [sheet showActionSheetWithClickBlock:^(int btnIndex) {
            if (btnIndex == 0) {
                req.scene = WXSceneSession;
                [WXApi sendReq:req];
            }else{
                req.scene = WXSceneTimeline;
                [WXApi sendReq:req];
            }
        } cancelBlock:^{
            
        }];
 
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

//发送评论
- (void)sendText:(NSString *)text{
    
    if (self.webView.canGoBack) {
        self.isPinglun = NO;
    }else{
        self.isPinglun = YES;
    }
    
    if (self.isPinglun) {
        //评论
        [self postPinglunWithText:text];
    }else{
        //回复
        [self postCommentWithText:text];
    }
}


/**
 文章评论

 @param text 评论内容
 */
-(void)postPinglunWithText:(NSString *)text{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"userid":user.userid,
                           @"toid":self.articleid,
                           @"comType":@"0",
                           @"comContent":text,
                           @"comment_to_type":@"0"
                           };
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"]
                                                 parameters:dict
                                                    success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            
//            [MBProgressHUD showSuccess:obj[@"msg"]];
            NSString *jsStr = [NSString stringWithFormat:@"refreshcomment('%@')",text];
            
            [_webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                
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
-(void)postCommentWithText:(NSString *)text{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"userid": user.userid,
                           @"toid" : self.comentId,
                           @"comType":@"1",
                           @"comContent":text,
                           @"comment_to_type":@"3"
                           };
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            NSString *jsStr = [NSString stringWithFormat:@"postReplyComment('%@')",text];
                                                            
                                                            [_webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                                                                
                                                            }];
                                                            
                                                        }else{
                                                            [MBProgressHUD showError:obj[@"msg"]];
                                                        }
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//        NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //点头像
    if ([message.name isEqualToString:@"asd"]) {
        self.isPinglun = YES;
        //做处理
        [self pushToPersonViewWithUserid:message.body];
    }
    
    //回复
    if ([message.name isEqualToString:@"comment_id"]) {
        self.isPinglun = NO;
        //做处理
        self.comentId = message.body;
    }
}


// oc调用JS方法   页面加载完成之后调用
- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{
//refreshcomment

    
    if (_webView.title.length > 0) {
        self.title = _webView.title;
    }
    
}

//跳转到个人页
-(void)pushToPersonViewWithUserid:(NSString *)userid{
    PersonViewController *publishPerson = [[PersonViewController alloc] init];
    publishPerson.userid = userid;
    [self.navigationController pushViewController:publishPerson animated:YES];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    //    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    //    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //    decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    // 接口的作用是打开新窗口委托
    return [[WKWebView alloc]init]; //OBJC_SWIFT_UNAVAILABLE("use object initializers instead")
    
    //    [self createNewWebViewWithURL:webView.URL.absoluteString config:configuration];
    //
    //    return currentSubView.webView;
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    //    NSLog(@"%@",message);
    completionHandler();
}
#pragma mark - WebViewJavascriptBridgeBaseDelegate
//代理方法
- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand{
    return nil;
}


- (void)dealloc{
    //这里需要注意，前面增加过的方法一定要remove掉。
    [userContentController removeScriptMessageHandlerForName:@"asd"];
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
