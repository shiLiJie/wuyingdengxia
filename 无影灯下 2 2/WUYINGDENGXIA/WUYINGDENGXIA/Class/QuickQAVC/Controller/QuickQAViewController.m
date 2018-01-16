//
//  QuickQAViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#define segViewHigh     44

#import "QuickQAViewController.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "SearchBarEffectController.h"
#import "ZZNewsSheetMenu.h"
#import "QATableVIewController.h"
#import "PersonViewController.h"
#import "PageDetailViewController.h"

@interface QuickQAViewController ()<SearchBarDelegate,MDMultipleSegmentViewDeletegate,MDFlipCollectionViewDelegate,QATableVIewDelegate>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

//搜索上边隐藏的btn,其实点击的是他
@property(nonatomic, strong) UIButton *searchBtn;
//兴趣标签编辑界面
@property(nonatomic, strong) ZZNewsSheetMenu *newsMenu;

@end

@implementation QuickQAViewController

-(void)viewWillAppear:(BOOL)animated{
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
    self.searchBtn.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
}

#pragma mark - UI -


//添加各种试图
-(void)addUI{
    
    [self.navigationController.view addSubview:self.searchBtn];

    //添加标签控制器
    [self addSegView];
    
}

//搜索bar上边的按钮,实际点击的是他
-(UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.frame = CGRectMake(20, 20, Main_Screen_Width-120, 44);
        [_searchBtn addTarget:self action:@selector(setUpSearch) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setTitle:@"输入想要搜索的关键词" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _searchBtn;
}

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    [right setTitle:@"提问" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:14]];
    return right;
}

//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    _segView.frame = CGRectMake(0,66, Main_Screen_Width, segViewHigh);
    _segView.items = @[@"头条",@"热门", @"制标", @"动态", @"课题"];
    [self.view addSubview:_segView];
    
    //添加加号➕按钮
    UIButton *addMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-segViewHigh, 0, segViewHigh, segViewHigh)];
    [addMenuBtn setTitle:@"╋" forState:UIControlStateNormal];
    [addMenuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addMenuBtn addTarget:self action:@selector(addMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_segView addSubview:addMenuBtn];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller],
                     ];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_segView.frame),
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - 75 - CGRectGetMaxY(_segView.frame))
                                                     withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

//设置导航栏背景色
- (UIColor *)set_colorBackground
{
    return [UIColor whiteColor];
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

#pragma mark - 按钮action -
//发表文章
-(void)right_button_event:(UIButton*)sender{
//    PublicPageViewController *publicPage = [[PublicPageViewController alloc] init];
//    [self.navigationController pushViewController:publicPage animated:YES];
    self.searchBtn.hidden = YES;
}

#pragma mark - 私有方法 -

-(QATableVIewController *)tablecontroller{
    QATableVIewController *vc = [[QATableVIewController alloc] init];
    vc.delegate = self;
    return vc;
}

//弹出搜索视图
- (void)setUpSearch
{
    SearchBarEffectController * searchView = [[SearchBarEffectController alloc]init];
    searchView.delegate = self;
    
    [searchView show];
}

//弹出标签管理视图
-(void)addMenuBtnClick{
    
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu];
    self.newsMenu = sheetMenu;
    sheetMenu.mySubjectArray = @[@"科技1",@"科技2",@"科技3",@"科技4",@"科技5"].mutableCopy;
    sheetMenu.recommendSubjectArray = @[@"体育",@"军事",@"音乐",@"电影",@"中国风",@"摇滚",@"小说",@"梦想",@"机器",@"电脑"].mutableCopy;
    
    //设置视图界面,从新设置的时候 recommendSubjectArray 数组从新定义,然后在调用次方法
    [self.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
        cofig.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    }];
    
    [self.newsMenu showNewsMenu];
    //回调编辑好的兴趣标签
    [self.newsMenu updataItmeArray:^(NSMutableArray *itemArray) {
        //给segeview标签数组赋值
        _segView.items = itemArray;
    }];
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

#pragma mark - 搜索页代理方法 -
- (void)didSelectKey:(NSString *)key{
    
}

#pragma mark - DetailTableViewController代理方法 -
//监听table点击方法传来索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath{
    
    PageDetailViewController *pageDetail = [[PageDetailViewController alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
    
}

-(void)clickHeadImageJumpToPersonDetailPage:(NSInteger)indexPath{
    //推出个人展示页
    PersonViewController *vc = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.searchBtn.hidden = YES;
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
