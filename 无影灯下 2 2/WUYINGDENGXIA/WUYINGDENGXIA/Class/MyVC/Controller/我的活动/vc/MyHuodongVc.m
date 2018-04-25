//
//  MyHuodongVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyHuodongVc.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "WeikaishiVc.h"
#import "YijieshuVc.h"
#import "MeetDetailViewController.h"
#import "PassMeetViewController.h"

@interface MyHuodongVc ()<MDMultipleSegmentViewDeletegate,
                            MDFlipCollectionViewDelegate,
                            WeikaishitDelegate,
                            YijieshuDelegate
>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

@end

@implementation MyHuodongVc

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
        _segView.frame = CGRectMake(50,98, kScreen_Width-100, 44);
    }else{
        _segView.frame = CGRectMake(50,64, kScreen_Width-100, 44);
    }
    
    _segView.items = @[@"文章",@"回答"];
    _segView.titleFont = BOLDSYSTEMFONT(17);
    [self.view addSubview:_segView];
    //    UILabel *lab = [[UILabel alloc] init];
    //    lab.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame)-1, kScreen_Width, 1);
    //    lab.backgroundColor = RGBline;
    //    [self.view addSubview:lab];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller1]
                     ];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_segView.frame),
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - CGRectGetMaxY(_segView.frame))
                                                     withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

-(WeikaishiVc *)tablecontroller{
    WeikaishiVc *vc = [[WeikaishiVc alloc] init];
    vc.delegate = self;
    
    return vc;
}
-(YijieshuVc *)tablecontroller1{
    YijieshuVc *vc = [[YijieshuVc alloc] init];
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
    return [self changeTitle:@"我的活动"];
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

#pragma mark - 底部两个tableview点击代理方法 -
-(void)tableviewDidSelectPageWithIndex3:(NSIndexPath *)indexPath{
    MeetDetailViewController *vc = [[MeetDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tableviewDidSelectPageWithIndex4:(NSIndexPath *)indexPath{
    PassMeetViewController *vc = [[PassMeetViewController alloc] init];
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
