//
//  MyShoucangVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyShoucangVc.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "DetailTableViewController.h"
#import "PageDetailViewController.h"
#import "QATableVIewController.h"
#import "AnswerViewController.h"
#import "PersonViewController.h"
#import "PassMeetViewController.h"
#import "PlayDetailViewController.h"

@interface MyShoucangVc ()<MDMultipleSegmentViewDeletegate,
                            MDFlipCollectionViewDelegate,
                            JohnScrollViewDelegate,
                            QATableVIewDelegate,
                            PassMeetDelegate>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

@end

@implementation MyShoucangVc

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:NO];
    
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSegView];
}
#pragma mark - UI -
//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    if (kDevice_Is_iPhoneX) {
        _segView.frame = CGRectMake(0,98, kScreen_Width, 44);
    }else{
        _segView.frame = CGRectMake(0,64, kScreen_Width, 44);
    }
    
    _segView.items = @[@"文章",@"问答",@"视频"];
    _segView.titleFont = BOLDSYSTEMFONT(17);
    [self.view addSubview:_segView];
//    UILabel *lab = [[UILabel alloc] init];
//    lab.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame)-1, kScreen_Width, 1);
//    lab.backgroundColor = RGBline;
//    [self.view addSubview:lab];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller1],
                     [self tablecontroller2]
                     ];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_segView.frame),
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - CGRectGetMaxY(_segView.frame))
                                                     withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

-(DetailTableViewController *)tablecontroller{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    vc.choosetype = shoucangType;
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        [vc getMyshoucangPage];
    }
    vc.delegate = self;
    
    return vc;
}
-(QATableVIewController *)tablecontroller1{
    QATableVIewController *vc = [[QATableVIewController alloc] init];
    vc.choosetype = QAshoucangType;
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        [vc getMyshoucangQusetion];
    }
    
    vc.delegate = self;
    return vc;
}
-(PassMeetViewController *)tablecontroller2{
    PassMeetViewController *vc = [[PassMeetViewController alloc] init];
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        [vc getMyshoucangQusetion];
    }
    
    vc.delegate = self;
    return vc;
}

-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"我的收藏"];
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

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - DetailTableViewController代理方法 -
//文章点击索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath article_id:(NSString *)articleid user_id:(NSString *)userid pageModle:(pageModel *)model{
    PageDetailViewController *pageDetail = [[PageDetailViewController alloc] init];
    pageDetail.articleid = articleid;
    pageDetail.userid = userid;
    pageDetail.model = [[pageModel alloc] init];;
    pageDetail.model = model;
    [self.navigationController pushViewController:pageDetail animated:YES];
}

-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath{
  
}
//文章头像点击
-(void)clickUserNamePushPublishVc{
    PersonViewController *publishPerson = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:publishPerson animated:YES];
}

//问答点击索引
-(void)QAtableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath QusetionModel:(QusetionModel *)Qusetionmodel{
    
    AnswerViewController *pageDetail = [[AnswerViewController alloc] init];
    pageDetail.questionModel = [[QusetionModel alloc] init];
    pageDetail.questionModel = Qusetionmodel;
    pageDetail.choosetype = questionType;
    [self.navigationController pushViewController:pageDetail animated:YES];
}
//问答头像点击
-(void)clickHeadImageJumpToPersonDetailPage:(NSInteger)indexPath{
    //推出个人展示页
    PersonViewController *vc = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//视频点击索引
-(void)tableviewDidSelectPageWithIndex2:(NSIndexPath *)indexPath huiguErModel:(huiguErModel *)model{
    PlayDetailViewController *vc = [[PlayDetailViewController alloc] init];
    vc.huifuerModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - segement代理方法 -
- (void)changeSegmentAtIndex:(NSInteger)index
{
    [_collectView selectIndex:index];
}

- (void)flipToIndex:(NSInteger)index
{
    [_segView selectIndex:index];
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
