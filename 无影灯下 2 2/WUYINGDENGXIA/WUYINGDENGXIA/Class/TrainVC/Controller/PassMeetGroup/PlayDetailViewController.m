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

@end

@implementation PlayDetailViewController

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
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXShare" object:nil];
    // 检查是否装了微信
    if ([WXApi isWXAppInstalled]) {
        
    }
}

#pragma mark - UI -
-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:self.huifuerModel.meeting_title.length>0 ?self.huifuerModel.meeting_title : @""];
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
    [self.navigationController popViewControllerAnimated:YES];
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
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48)configuration:configuration];
    _webView.UIDelegate = self;
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cloud.yszg.org/Wuyingdengxia/VideoPlay.html?user_id=%@&replay_sub_id=%@",user.userid,self.huifuerModel.replay_sub_id]]]];
    
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
        [self pushToPersonViewWithUserid:message.body];
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
        NSLog(@"分享成功");
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
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
    
}

#pragma mark - textinput代理 -

-(void)giveText:(NSString *)text{
    self.inputStr = text;
}

- (void)sendText:(NSString *)text{

    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"userid":user.userid,
                           @"toid":self.huifuerModel.replay_sub_id,
                           @"comType":@"0",
                           @"comContent":text,
                           @"comment_to_type":@"4"
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_comment"] parameters:dict success:^(id obj) {
        
        NSLog(@"%@",obj);
    } fail:^(NSError *error) {
        //
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
