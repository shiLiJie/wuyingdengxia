//
//  PersonViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PersonViewController.h"
#import "DetailTableViewController.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"

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
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
    //添加segeview
    [self addSegView];
}

#pragma mark - UI -
-(UIColor*)set_colorBackground{
    
    return [UIColor clearColor];
}


//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    _segView.frame = CGRectMake(0,CGRectGetMaxY(self.backView.frame), Main_Screen_Width, segViewHigh);
    _segView.items = @[@"发表",@"提问", @"制回答"];
    [self.view addSubview:_segView];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller]
                     ];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_segView.frame),
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - 75)
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
}

#pragma mark - 私有action -
-(DetailTableViewController *)tablecontroller{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    vc.delegate = self;

    return vc;
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
