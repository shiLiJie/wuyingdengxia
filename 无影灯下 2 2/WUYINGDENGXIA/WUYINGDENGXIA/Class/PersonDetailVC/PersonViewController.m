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
#import "userModel.h"


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

-(void)viewDidAppear:(BOOL)animated{
    self.headImageView.layer.cornerRadius = CGRectGetHeight(self.headImageView.frame)/2;//半径大小
    self.headImageView.layer.masksToBounds = YES;//是否切割
}

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
    
    self.headImageView.layer.cornerRadius = CGRectGetHeight(self.headImageView.frame)/2;//半径大小
    self.headImageView.layer.masksToBounds = YES;//是否切割
    
    //添加segeview
    [self addSegView];
    
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[NSString stringWithFormat:@"%@get_myinfo?userid=%@",BaseUrl,self.userid]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSDictionary *ditc = obj[@"data"];
                                                       userModel *user = [userModel userWithDict:ditc];
                                                       if (!kStringIsEmpty(user.headimg)) {
                                                           [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.headimg] placeholderImage:GetImage(@"tx")];
                                                       }
                                                       if (!kStringIsEmpty(user.username)) {
                                                            self.userNameLab.text = user.username !=nil ? user.username : @"";
                                                       }
                                                       if (!kStringIsEmpty(user.fansnum)) {
                                                            self.funsLab.text = user.fansnum !=nil ? [NSString stringWithFormat:@"粉丝数  %@",user.fansnum] : @"粉丝数  0";
                                                       }
                                                       if (!kStringIsEmpty(user.supportnum)) {
                                                            self.zanLab.text = user.supportnum !=nil ? [NSString stringWithFormat:@"点赞数  %@",user.fansnum] : @"点赞数  0";
                                                       }
                                                       if (!kStringIsEmpty(user.isV)) {
                                                           if ([user.isV isEqualToString:@"1"]) {
                                                               self.vipImageView.image = GetImage(@"v");
                                                           }
                                                       }

    } fail:^(NSError *error) {
        //
    }];
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
                                                                          Main_Screen_Height - Main_Screen_Height*0.215-segViewHigh-20)
                    
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
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    NSDictionary *dict = @{
                           @"userid":user.userid,
                           @"befollid":self.userid
                           };
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_follow"]
                                                 parameters:dict
                                                    success:^(id obj) {
                                                        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                            
                                                            [self.guanzhuBtn setBackgroundColor:[UIColor grayColor]];
                                                            [self.guanzhuBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
                                                            [self.guanzhuBtn setTitle:@"已关注" forState:UIControlStateNormal];
                                                            [MBProgressHUD showSuccess:obj[@"msg"]];
                                                        }else{
                                                            
                                                        }
    } fail:^(NSError *error) {
        
    }];

}

-(DetailTableViewController *)tablecontroller{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    [vc getPersonVcPageWithPersonId:self.userid];
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

//监听table点击方法传来索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath article_id:(NSString *)articleid user_id:(NSString *)userid pageModle:(pageModel *)model{
    
    PageDetailViewController *pageDetail = [[PageDetailViewController alloc] init];
    pageDetail.articleid = articleid;
    pageDetail.userid = userid;
    pageDetail.model = [[pageModel alloc] init];;
    pageDetail.model = model;
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
