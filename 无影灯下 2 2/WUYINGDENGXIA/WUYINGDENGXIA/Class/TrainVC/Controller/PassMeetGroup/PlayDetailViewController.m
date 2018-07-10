//
//  PlayDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/12.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PlayDetailViewController.h"
#import "inputView.h"
#import "IQKeyboardManager.h"


@interface PlayDetailViewController ()<inputViewDelegate,WKUIDelegate,WKNavigationDelegate,WKWebViewDelegate>
{
    WKUserContentController * userContentController;
}

@property(strong,nonatomic)WKWebView *webView;
//输入框
@property (nonatomic, strong) inputView *input;

@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;

@property (nonatomic,copy) NSString *inputStr;
//评论id
@property (nonatomic,copy) NSString *comentId;
//评论还是回复
@property (nonatomic,assign) BOOL isPinglun;

@end

@implementation PlayDetailViewController

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
    if (isIOS10) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //设置网页
    [self setWeb];
    
    self.pinglunBtn.layer.cornerRadius = CGRectGetHeight(self.pinglunBtn.frame)/2;//半径大小
    self.pinglunBtn.layer.masksToBounds = YES;//是否切割
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXShare" object:nil];

    self.isPinglun = YES;
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{

    return [self changeTitle:!kStringIsEmpty(self.huifuerModel.meeting_title) ? self.huifuerModel.meeting_title : @"收藏视频"];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
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


- (IBAction)pinglunBtn:(UIButton *)sender {
    
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
        if (isIOS10) {
            _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 65, kScreen_Width, kScreen_Height-48-65 )configuration:configuration];
        }else{
            _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48)configuration:configuration];
        }
    }
    
    _webView.UIDelegate = self;
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/VideoPlay.html?user_id=%@&replay_sub_id=%@",user.userid,self.huifuerModel.replay_sub_id]]]];
    
    [self.view addSubview:_webView];
    
    //注册方法
    WKWebViewDelegate * delegateController = [[WKWebViewDelegate alloc]init];
    delegateController.delegate = self;
    
    [userContentController addScriptMessageHandler:delegateController  name:@"asd"];
    [userContentController addScriptMessageHandler:delegateController  name:@"share"];
    [userContentController addScriptMessageHandler:delegateController  name:@"refreshcomment"];
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
    
    //评论的回复
    if ([message.name isEqualToString:@"comment_id"]) {
        self.isPinglun = NO;
        //做处理
        self.comentId = message.body;
    }
    
    //分享
    if ([message.name isEqualToString:@"share"]) {
        //做处理
        [self zhuanfa];
    }
}
// oc调用JS方法   页面加载完成之后调用
- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{

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


- (void)getOrderPayResult:(NSNotification *)notification
{
    // 注意通知内容类型的匹配
    if (notification.object == 0)
    {
//        NSLog(@"分享成功");
    }
}

//转发
-(void)zhuanfa {
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    WXMediaMessage * message = [WXMediaMessage message];
    message.title = self.huifuerModel.meeting_title;
    message.description = self.self.huifuerModel.meeting_content;
    //    [message setThumbImage:[UIImage imageNamed:self.model.article_img_path]];
    
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = [NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/VideoPlay.html?user_id=%@&replay_sub_id=%@",user.userid,self.huifuerModel.replay_sub_id];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    
    req.message = message;
    NSArray *titles = @[@"发送给朋友",@"分享到朋友圈"];
    NSArray *imageNames = @[@"wxfx",@"pyqfx"];
    HLActionSheet *sheet = [[HLActionSheet alloc] initWithTitles:titles iconNames:imageNames];
    [sheet showActionSheetWithClickBlock:^(int btnIndex) {
        
        // 检查是否装了微信
        if ([WXApi isWXAppInstalled]) {
            
        }else{
            [MBProgressHUD showOneSecond:@"未安装微信客户端"];
            
            return;
        }
        
        if (btnIndex == 0) {
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
        }else{
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        }
    } cancelBlock:^{
        
    }];
}

#pragma mark - textinput代理 -

-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{

    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    if (self.webView.canGoBack) {
        self.isPinglun = NO;
    }else{
        self.isPinglun = YES;
    }

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
                           @"userid":userid,
                           @"toid":self.huifuerModel.replay_sub_id,
                           @"comType":@"0",
                           @"comContent":text,
                           @"comment_to_type":@"4"
                           };
    
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            
                                                            NSString *jsStr = [NSString stringWithFormat:@"refreshcomment()"];
                                                            
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
                           @"comment_to_type":@"3"
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
