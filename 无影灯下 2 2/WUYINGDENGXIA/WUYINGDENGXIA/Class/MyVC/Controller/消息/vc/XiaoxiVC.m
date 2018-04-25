//
//  XiaoxiVC.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XiaoxiVC.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "TongzhiVc.h"
#import "XitongVc.h"
#import "XiaoxiDetailVc.h"

#define segViewHigh     44

@interface XiaoxiVC ()<MDMultipleSegmentViewDeletegate,MDFlipCollectionViewDelegate,TongzhiVcDelegate,XitongVcDelegate>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

@end

@implementation XiaoxiVC

-(void)viewWillDisappear:(BOOL)animated{
    _segView.hidden = YES;
}

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
    _segView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSegView];
//    [self.navigationController.view bringSubviewToFront:_segView];
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@""];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    _segView.hidden = YES;//返回隐藏顶部view
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    if (kDevice_Is_iPhoneX) {
        _segView.frame = CGRectMake(Main_Screen_Width/5*1.5, 35, Main_Screen_Width/5*2, segViewHigh);
    }else{
        _segView.frame = CGRectMake(Main_Screen_Width/5*1.5, 20, Main_Screen_Width/5*2, segViewHigh);
    }
    _segView.items = @[@"通知",@"系统"];
    _segView.titleFont = BOLDSYSTEMFONT(17);
    [self.navigationController.view addSubview:_segView];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller1]
                     ];
    if (kDevice_Is_iPhoneX) {
        _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              99,
                                                                              Main_Screen_Width,
                                                                              Main_Screen_Height - 99)
                                                         withArray:arr];
    }else{
        _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              64,
                                                                              Main_Screen_Width,
                                                                              Main_Screen_Height - 64)
                                                         withArray:arr];
    }
    
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

#pragma mark - 私有action -
-(TongzhiVc *)tablecontroller{
    TongzhiVc *vc = [[TongzhiVc alloc] init];
    vc.delegate = self;

    return vc;
}

-(XitongVc *)tablecontroller1{
    XitongVc *vc = [[XitongVc alloc] init];
    vc.delegate = self;

    return vc;
}

#pragma mark - 消息列表代理方法 -
-(void)transIndex:(NSIndexPath *)index{
    
    _segView.hidden = YES;//返回隐藏顶部view
    //通知消息
    XiaoxiDetailVc *vc = [[XiaoxiDetailVc alloc] init];
    vc.titleStriing = @"通知消息";
    if (index.row == 0) {
        vc.xiaoxiType = tuigaoType;
    }else if(index.row == 1){
        vc.xiaoxiType = canhuiType;
    }else{
        vc.xiaoxiType = wenjuanType;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)transIndex1:(NSIndexPath *)index{
//    _segView.hidden = YES;//返回隐藏顶部view
//    //系统消息
//    XiaoxiDetailVc *vc = [[XiaoxiDetailVc alloc] init];
//    vc.titleStriing = @"系统消息";
//    [self.navigationController pushViewController:vc animated:YES];
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
