//
//  MyViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyViewController.h"
#import "MyDetailViewController.h"
#import "MyTableCell.h"
#import "MyQiandaoVc.h"
#import "MyDuihuanVc.h"
#import "XuyuanchiVc.h"
#import "MyKeshiVc.h"
#import "XiaoxiVC.h"
#import "SettingVc.h"
#import "MyTougaoVc.h"
#import "MyTiwenVc.h"
#import "MyHuidaVc.h"
#import "MyGuanzhuVc.h"
#import "MyFensiVc.h"
#import "MyShoucangVc.h"
#import "MyHuodongVc.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//用户名
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;//vip图
@property (weak, nonatomic) IBOutlet UIButton *yueliangbiNum;//月亮币数量
@property (weak, nonatomic) IBOutlet UILabel *fensiLab;//粉丝lab
@property (weak, nonatomic) IBOutlet UILabel *fensiNum;//粉丝数
@property (weak, nonatomic) IBOutlet UILabel *zanNum;//点赞数
@property (weak, nonatomic) IBOutlet UIButton *xiaoxiBtn;//消息按钮

@property (weak, nonatomic) IBOutlet UIView *buttonView;//中间按钮view
@property (weak, nonatomic) IBOutlet UITableView *tableview;//table
@property (nonatomic, strong) NSArray *tableViewAyy;//tabledata
@property (nonatomic, strong) NSArray *tableViewImageAyy;



@end

@implementation MyViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    //个人信息设置
    [self userInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //cell内容初始化
    self.tableViewAyy = @[@"我的提问",@"我的回答",@"我的兑换记录",@"我的关注",@"我的活动",@"我的收藏"];
    self.tableViewImageAyy = @[@"wodetiwen",@"wodehuida",@"wodeduihuan",@"wodeguanzhu",@"wodehuodong",@"wodeshoucang"];
    //添加按钮
    [self addBtn];
    self.buttonView.layer.cornerRadius = 10.0f;
    [self.buttonView.layer setMasksToBounds:YES];
    
    // 1. 创建一个点击事件，点击时触发labelClick方法
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    // 2. 将点击事件添加到label上
    [self.fensiLab addGestureRecognizer:labelTapGestureRecognizer];
    [self.fensiNum addGestureRecognizer:labelTapGestureRecognizer];
    // 可以理解为设置label可被点击
    self.fensiLab .userInteractionEnabled = YES;
    self.fensiNum .userInteractionEnabled = YES;
    
}



#pragma mark - UI -
-(BOOL)hideNavigationBottomLine
{
    return YES;
}
//个人信息设置
-(void)userInfo{
    
    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:user.headimg] placeholderImage:GetImage(@"tx")];
        self.userName.text = ![user.userName isEqualToString:@""] ? user.userName : @"您的昵称";
        self.fensiNum.text = ![user.fansnum isEqualToString:@""] ? user.fansnum : @"0";
        self.zanNum.text = ![user.supportnum isEqualToString:@""] ? user.supportnum : @"0";
        [self.yueliangbiNum setTitle:![user.moon_cash isEqualToString:@""] ? user.moon_cash : @" 0" forState:UIControlStateNormal];
        if ([user.isV isEqualToString:@"1"]) {
            self.vipImage.image = GetImage(@"v");
        }
    }else{
        self.headImage.image = GetImage(@"tx");
        self.userName.text = @"您的昵称";
        self.fensiNum.text = @"0";
        self.zanNum.text = @"0";
        [self.yueliangbiNum setTitle:@" 0" forState:UIControlStateNormal];
        self.vipImage.image = GetImage(@"v1");
    }
}

//四个大按钮
-(void)addBtn{
    
    UIButton *tougao = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width-42*4)/5, 13, 42, 42)];
    [tougao setImage:GetImage(@"wodetougaoicon") forState:UIControlStateNormal];
    [tougao addTarget:self action:@selector(tougaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:tougao];
    UILabel *tougaolab = [[UILabel alloc] initWithFrame:CGRectMake(0, 61, 61, 20)];
    tougaolab.textAlignment = NSTextAlignmentCenter;
    tougaolab.textColor = RGB51;
    tougaolab.font = [UIFont systemFontOfSize:13];
    tougaolab.center = CGPointMake(tougao.center.x, 73);
    tougaolab.text = @"我的投稿";
    [self.buttonView addSubview:tougaolab];
    
    UIButton *xuyuan = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width-42*4)/5 * 2 + 42, 13, 42, 42)];
    [xuyuan setImage:GetImage(@"xuyuanchiicon") forState:UIControlStateNormal];
    [xuyuan addTarget:self action:@selector(xuyuanClick) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:xuyuan];
    UILabel *xuyuanlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 61, 61, 20)];
    xuyuanlab.textAlignment = NSTextAlignmentCenter;
    xuyuanlab.textColor = RGB51;
    xuyuanlab.font = [UIFont systemFontOfSize:13];
    xuyuanlab.center = CGPointMake(xuyuan.center.x, 73);
    xuyuanlab.text = @"许愿池";
    [self.buttonView addSubview:xuyuanlab];
    
    UIButton *shujia = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width-42*4)/5 * 3 + 84, 13, 42, 42)];
    [shujia setImage:GetImage(@"keshishujiaicon") forState:UIControlStateNormal];
    [shujia addTarget:self action:@selector(shujiaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:shujia];
    UILabel *shujialab = [[UILabel alloc] initWithFrame:CGRectMake(0, 61, 61, 20)];
    shujialab.textAlignment = NSTextAlignmentCenter;
    shujialab.textColor = RGB51;
    shujialab.font = [UIFont systemFontOfSize:13];
    shujialab.center = CGPointMake(shujia.center.x, 73);
    shujialab.text = @"我的科室";
    [self.buttonView addSubview:shujialab];
    
    UIButton *qiandao = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width-42*4)/5 * 4 + 126, 13, 42, 42)];
    [qiandao setImage:GetImage(@"每日签到") forState:UIControlStateNormal];
    [qiandao addTarget:self action:@selector(qiandaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:qiandao];
    UILabel *qiandaolab = [[UILabel alloc] initWithFrame:CGRectMake(0, 61, 61, 20)];
    qiandaolab.textAlignment = NSTextAlignmentCenter;
    qiandaolab.textColor = RGB51;
    qiandaolab.font = [UIFont systemFontOfSize:13];
    qiandaolab.center = CGPointMake(qiandao.center.x, 73);
    qiandaolab.text = @"每日签到";
    [self.buttonView addSubview:qiandaolab];
    
    
}

#pragma mark - 私有方法 -
//邀请按钮点击
- (IBAction)yaoqingBtnClick:(UIButton *)sender {
    
}
//消息按钮点击
- (IBAction)xiaoxiBtnClick:(UIButton *)sender {
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    XiaoxiVC *vc = [[XiaoxiVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//资料设置按钮点击
- (IBAction)ziliaoBtnClick:(UIButton *)sender {
    MyDetailViewController *pageDetail = [[MyDetailViewController alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
}
//点击透明头像,效果和上边一样
- (IBAction)headImageClick:(UIButton *)sender {
    MyDetailViewController *pageDetail = [[MyDetailViewController alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
}
//设置按钮点击
- (IBAction)settingClick:(UIButton *)sender {
    SettingVc *vc = [[SettingVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//我的投稿
-(void)tougaoClick{
    MyTougaoVc *vc = [[MyTougaoVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//签到
-(void)qiandaoClick{
    MyQiandaoVc *vc = [[MyQiandaoVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//许愿
-(void)xuyuanClick{
    XuyuanchiVc *vc = [[XuyuanchiVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//我的科室
-(void)shujiaClick{
    MyKeshiVc *vc = [[MyKeshiVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//点击粉丝
-(void)labelClick{
    MyFensiVc *vc = [[MyFensiVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MyTableCell";
    MyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];

    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:nil options:nil] firstObject];
    }
    NSString *imageStr = self.tableViewImageAyy[indexPath.row];
    cell.cellImage.image = GetImage(imageStr);
    cell.cellTitle.text = self.tableViewAyy[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //提问
    if (indexPath.row == 0) {
        MyTiwenVc *vc = [[MyTiwenVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //回答
    if (indexPath.row == 1) {
        MyHuidaVc *vc = [[MyHuidaVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //兑换记录
    if (indexPath.row == 2) {
        MyDuihuanVc *duihuan = [[MyDuihuanVc alloc] init];
        [self.navigationController pushViewController:duihuan animated:YES];
    }
    //关注
    if (indexPath.row == 3) {
        MyGuanzhuVc *vc = [[MyGuanzhuVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //活动
    if (indexPath.row == 4) {
        MyHuodongVc *vc = [[MyHuodongVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //收藏
    if (indexPath.row == 5) {
        MyShoucangVc *vc = [[MyShoucangVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
