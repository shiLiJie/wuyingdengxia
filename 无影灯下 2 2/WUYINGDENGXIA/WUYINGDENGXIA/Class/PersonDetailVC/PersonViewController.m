//
//  PersonViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonDetailVC.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "AnswerTableVC.h"
#import "DetailTableViewController.h"
#import "PageDetailViewController.h"

#import "WXApi.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"

#define segViewHigh     44

@interface PersonViewController ()<MDMultipleSegmentViewDeletegate,
                                    MDFlipCollectionViewDelegate,
                                    JohnScrollViewDelegate>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}
//背景
@property (weak, nonatomic) IBOutlet UIView *backView;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
//用户等级
@property (weak, nonatomic) IBOutlet UILabel *userLvLab;
//会员
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
//粉丝数
@property (weak, nonatomic) IBOutlet UILabel *funsLab;
//获赞
@property (weak, nonatomic) IBOutlet UILabel *zanLab;
//关注
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    if ([self respondsToSelector:@selector(set_colorBackground)]) {
        UIColor *backgroundColor =  [self set_colorBackground];
        UIImage *bgimage = [UIImage imageWithColor:backgroundColor];
        
        [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    }
    
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //默认显示黑线
    blackLineImageView.hidden = NO;
    if ([self respondsToSelector:@selector(hideNavigationBottomLine)]) {
        if ([self hideNavigationBottomLine]) {
            //隐藏黑线
            blackLineImageView.hidden = YES;
        }
    }
    
//    // 接收分享回调通知
//    //监听通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXShare" object:nil];
//    // 检查是否装了微信
//    if ([WXApi isWXAppInstalled])
//    {
//
//    }
    
//    [super viewWillAppear:nil];
    //添加segeview
    [self addSegView];
    
//    self.guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //切圆角和设置弧度
//    self.guanzhuBtn.layer.cornerRadius = 5.0;//半径大小
//    self.guanzhuBtn.layer.masksToBounds = YES;//是否切割
}

#pragma mark - UI -
-(UIColor*)set_colorBackground{
    
    return [UIColor clearColor];
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}

-(UIButton *)set_leftButton{
    return nil;
}


//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    _segView.frame = CGRectMake(0,CGRectGetMaxY(self.backView.frame), 90, segViewHigh);
    _segView.items = @[@"文章"];
    _segView.titleFont = BOLDSYSTEMFONT(17);
    [self.view addSubview:_segView];
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame)-1, kScreen_Width, 1);
    lab.backgroundColor = RGBline;
    [self.view addSubview:lab];
    
    NSArray *arr = @[
                     [self tablecontroller]
//                     [self tablecontroller1]
                     ];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_segView.frame)-0.5,
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - Main_Screen_Height*0.168)
                                                     withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}
#pragma mark - action -
//返回
- (IBAction)leftBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//关注
- (IBAction)guanzhu:(UIButton *)sender {

//    WXMediaMessage * message = [WXMediaMessage message];
//    message.title = @"无影灯下";
//    message.description = @"测试";
//    [message setThumbImage:[UIImage imageNamed:@"Icon-Small@2x"]];
//
//    WXWebpageObject * webpageObject = [WXWebpageObject object];
//    webpageObject.webpageUrl = @"http://www.yszg.org";
//    message.mediaObject = webpageObject;
//
//    SendMessageToWXReq * req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//
//    req.message = message;
//    req.scene = WXSceneSession;
//
//    [WXApi sendReq:req];
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

-(DetailTableViewController *)tablecontroller{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    vc.delegate = self;

    return vc;
}

-(AnswerTableVC *)tablecontroller1{
    AnswerTableVC *vc = [[AnswerTableVC alloc] init];
    //    vc.delegate = self;
    
    return vc;
}

#pragma mark - DetailTableViewController代理方法 -
//监听点击table点击的索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath{
    
    PageDetailViewController *pageDetail = [[PageDetailViewController alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
}
////点击用户名和头像跳入个人发表的文章页
//-(void)clickUserNamePushPublishVc{
//    PersonViewController *publishPerson = [[PersonViewController alloc] init];
//    [self.navigationController pushViewController:publishPerson animated:YES];
//}

#pragma mark - segement代理方法 -
- (void)changeSegmentAtIndex:(NSInteger)index
{
    [_collectView selectIndex:index];
}

- (void)flipToIndex:(NSInteger)index
{
    [_segView selectIndex:index];
}


////左侧按钮设置点击
//-(UIButton *)set_leftButton{
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    return btn;
//}
//
//-(void)left_button_event:(UIButton*)sender{
//
//    [self.navigationController popViewControllerAnimated:YES];
//}

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
