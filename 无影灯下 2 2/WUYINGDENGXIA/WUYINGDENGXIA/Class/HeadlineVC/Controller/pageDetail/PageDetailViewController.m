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



@interface PageDetailViewController ()<inputViewDelegate,WKUIDelegate,WKNavigationDelegate,WKWebViewDelegate>
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

@property (nonatomic,copy) NSString *inputStr;

@end

@implementation PageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.pinglunBtn.layer.cornerRadius = CGRectGetHeight(self.pinglunBtn.frame)/2;//半径大小
    self.pinglunBtn.layer.masksToBounds = YES;//是否切割
    //设置网页
    [self setWeb];
    
    // 接收分享回调通知
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXShare" object:nil];
    // 检查是否装了微信
    if ([WXApi isWXAppInstalled]) {
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
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

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.0.0.43/Wuyingdengxia/article_details.html?articleid=%@&userid=%@",self.articleid,user.userid]]]];

    [self.view addSubview:_webView];
    
    //注册方法
    WKWebViewDelegate * delegateController = [[WKWebViewDelegate alloc]init];
    delegateController.delegate = self;
    
    [userContentController addScriptMessageHandler:delegateController  name:@"helloWorld"];
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
    
    self.input = [[inputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen] .bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.input];
    if (self.inputStr.length > 0) {
        self.input.inputTextView.text = self.inputStr;
    }
    self.input.delegate = self;
    [self.input inputViewShow];

}
//点赞
- (IBAction)dianzan:(UIButton *)sender {
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
 
    __weak typeof(self) weakSelf = self;
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_support?userid=%@&toid=%@&supType=1",user.userid,self.articleid]] parameters:nil success:^(id obj) {
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            
            [weakSelf.zanBtn setImage:GetImage(@"xiaodianzan2") forState:UIControlStateNormal];
        }else{
            
        }
    } fail:^(NSError *error) {
        //
    }];
    

}
//收藏
- (IBAction)shoucang:(UIButton *)sender {
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
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
                                                            
                                                            [weakSelf.shoucangBtn setImage:GetImage(@"yishoucang") forState:UIControlStateNormal];
                                                        }else{
                                                            
                                                        }
                                                    }
                                                       fail:^(NSError *error) {
                                                           
                                                       }];
}

#pragma mark - 私有action -
- (void)getOrderPayResult:(NSNotification *)notification
{
    // 注意通知内容类型的匹配
    if (notification.object == 0)
    {
        NSLog(@"分享成功");
    }
}

//转发
- (IBAction)zhuanfa:(UIButton *)sender {
    
    WXMediaMessage * message = [WXMediaMessage message];
    message.title = self.model.article_title;
    message.description = self.model.article_content;
    [message setThumbImage:[UIImage imageNamed:self.model.article_img_path]];
    
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = @"http://www.yszg.org";
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];

}

#pragma mark - textinput代理 -
-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{
    
    NSDictionary *dict = @{
                           @"userid":self.userid,
                           @"toid":self.articleid,
                           @"comType":@"0",
                           @"comContent":text,
                           @"comment_to_type":@"0"
                           };
    NSLog(@"%@",dict);
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"] parameters:dict success:^(id obj) {
        
        NSLog(@"%@",obj);
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
        NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}
// oc调用JS方法   页面加载完成之后调用
- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{
    
    //say()是JS方法名，completionHandler是异步回调block
    [_webView evaluateJavaScript:@"h5()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //        NSLog(@"%@",result);
    }];
    
    if (_webView.title.length > 0) {
        self.title = _webView.title;
    }
    
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
    [userContentController removeScriptMessageHandlerForName:@"helloWorld"];
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
