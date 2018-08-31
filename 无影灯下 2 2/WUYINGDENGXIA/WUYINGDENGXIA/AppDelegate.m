//
//  AppDelegate.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "AppDelegate.h"
#import "PlusButton.h"
#import "TabBarControllerConfig.h"
#import "AppDelegate+YCLaunchAd.h"
#import "IQKeyboardManager.h"
#import "WXApi.h"


@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic, strong) TabBarControllerConfig *tabBarControllerConfig;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // window初始化
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    
    //添加跟控制器
    [self addTabbarVc];
    
    [WXApi registerApp:AppID enableMTA:false];

    
    //键盘上弹配置
//    [self keyboardManager];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}
//新的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark 微信回调方法
- (void)onResp:(BaseResp *)resp
{
    
    /*
     WXSuccess           = 0,   成功
     WXErrCodeCommon     = -1,   普通错误类型
     WXErrCodeUserCancel = -2,   用户点击取消并返回
     WXErrCodeSentFail   = -3,    发送失败
     WXErrCodeAuthDeny   = -4,   授权失败
     WXErrCodeUnsupport  = -5,    微信不支持
     */
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        // 判断errCode 进行回调处理
        if (resp.errCode == 0)
        {
            strTitle = [NSString stringWithFormat:@"分享成功"];
            
            //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
            NSNotification * notification = [NSNotification notificationWithName:@"WXShare" object:resp.errStr];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    }
    //判断微信登录回调
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        //判断errCode 进行回调处理
        if (resp.errCode == 0) {
            //成功
            SendAuthResp *temp = (SendAuthResp *)resp;
            
            [[HttpRequest shardWebUtil] getNetworkRequestURLString:[NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, AppID, AppSecret, temp.code] parameters:nil success:^(id obj) {
                NSLog(@"请求access的response = %@", obj);
                NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:obj];
                NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
                NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
                NSString *refreshToken = [accessDict objectForKey:WX_REFRESH_TOKEN];
                // 本地持久化，以便access_token的使用、刷新或者持续
                if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
                    [[NSUserDefaults standardUserDefaults] setObject:openID forKey:WX_OPEN_ID];
                    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
                    [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
                }
                [self wechatLoginByRequestForUserInfo];
            } fail:^(NSError *error) {
                NSLog(@"获取access_token时出错 = %@", error);
            }];
            
        }
    }
}

//授权成功,获取用户信息
- (void)wechatLoginByRequestForUserInfo {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID] parameters:nil success:^(id obj) {
//        NSLog(@"请求用户信息的response = %@", obj);
        UserInfoModel *user = [UserInfoModel shareUserModel];
        user.userName = obj[@"nickname"];
        user.headimg = obj[@"headimgurl"];
        user.usercity = obj[@"city"];
        user.we_chat_id = openID;
        user.we_chat_id = obj[@"unionid"];
        NSString *sex = [NSString stringWithFormat:@"%@",obj[@"sex"]];
        if ([sex isEqualToString:@"1"]) {
            user.usersex = @"男";
        }else{
            user.usersex = @"女";
        }
        [MBProgressHUD showSuccess:@"登录成功"];
        [user saveUserInfoToSanbox];
        
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        NSNotification * notification = [NSNotification notificationWithName:@"WXLogin" object:obj[@"unionid"]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } fail:^(NSError *error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}

//添加跟控制器
-(void)addTabbarVc{
    
    // 中间按钮
//    [PlusButton registerPlusButton];
    
    // 添加根控制器
    self.tabBarControllerConfig = [[TabBarControllerConfig alloc]init];
    _window.rootViewController = self.tabBarControllerConfig.tabBarController;
    
    [_window makeKeyAndVisible];
}

-(void)chaninde2
{
    self.tabBarControllerConfig.tabBarController.selectedIndex = 1;
    
}

//键盘第三方库设置全局属性
-(void)keyboardManager{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
