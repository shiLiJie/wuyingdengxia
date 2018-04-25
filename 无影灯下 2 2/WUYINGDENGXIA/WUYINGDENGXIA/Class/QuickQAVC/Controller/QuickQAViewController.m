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
#import "ZZNewsSheetMenu.h"
#import "QATableVIewController.h"
#import "PersonViewController.h"
#import "AnswerViewController.h"
#import "QuestionsViewController.h"
#import "PYSearch.h"
#import "SearchResultVcViewController.h"
#import "MyTiwenVc.h"

@interface QuickQAViewController ()<MDMultipleSegmentViewDeletegate,
                                    MDFlipCollectionViewDelegate,
                                    QATableVIewDelegate,
                                    PYSearchViewControllerDelegate>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

//搜索上边隐藏的btn,其实点击的是他
@property(nonatomic, strong) UIButton *searchBtn;
//提问按钮
@property(nonatomic, strong) UIButton *tiwenBtn;
//兴趣标签编辑界面
@property(nonatomic, strong) ZZNewsSheetMenu *newsMenu;

@end

@implementation QuickQAViewController

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
    self.searchBtn.hidden = NO;
    self.tiwenBtn.hidden = NO;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
}

#pragma mark - UI -


//添加各种试图
-(void)addUI{
    
    [self.navigationController.view addSubview:self.tiwenBtn];
    [self.navigationController.view addSubview:self.searchBtn];

    //添加标签控制器
    [self addSegView];
    
}

//搜索bar上边的按钮,实际点击的是他
-(UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        if (kDevice_Is_iPhoneX) {
            _searchBtn.frame = CGRectMake(-20, 50, Main_Screen_Width-95, 33);
        }else{
            _searchBtn.frame = CGRectMake(-40, 25, Main_Screen_Width-95, 33);
        }
//        _searchBtn.frame = CGRectMake(25, 20, Main_Screen_Width-180, 50);
        [_searchBtn addTarget:self action:@selector(setUpSearch) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setImage:GetImage(@"wendasousuo") forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _searchBtn;
}
//提问按钮
-(UIButton *)tiwenBtn{
    if (_tiwenBtn == nil) {
        _tiwenBtn = [[UIButton alloc] init];
        if (kDevice_Is_iPhoneX) {
            _tiwenBtn.frame = CGRectMake(kScreen_Width-140, 44, 44, 44);
        }else{
            _tiwenBtn.frame = CGRectMake(kScreen_Width-140, 20, 44, 44);
        }
        
        [_tiwenBtn addTarget:self action:@selector(tiwenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_tiwenBtn setTitle:@"提问" forState:UIControlStateNormal];
        [_tiwenBtn setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
        [_tiwenBtn setFont: [UIFont systemFontOfSize:17]];
    }
    return _tiwenBtn;
}

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    [right setTitle:@"我的提问" forState:UIControlStateNormal];
    [right setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:17]];
    return right;
}

//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    if (kDevice_Is_iPhoneX) {
        _segView.frame = CGRectMake(0,90, Main_Screen_Width-44, segViewHigh);
    }else{
        _segView.frame = CGRectMake(0,66, Main_Screen_Width-44, segViewHigh);
    }
    
    _segView.items = @[@"问题1",@"问题2",@"问题3",@"问题4",@"问题5"];
    [self.view addSubview:_segView];
    //标签下边的灰色横线
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segView.frame)+1, Main_Screen_Width, 1)];
    lab.backgroundColor = RGB(232, 232, 232);
    [self.view addSubview: lab];
    
    //添加加号➕按钮
    UIButton *addMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(_segView.frame)-44, segViewHigh, segViewHigh)];
    [addMenuBtn setImage:GetImage(@"Group 2") forState:UIControlStateNormal];
    [addMenuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addMenuBtn addTarget:self action:@selector(addMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addMenuBtn];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller],
                     [self tablecontroller],
                     ];
    if (kDevice_Is_iPhoneX) {
        _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              CGRectGetMaxY(_segView.frame)+2,
                                                                              Main_Screen_Width,
                                                                              Main_Screen_Height - 49 - CGRectGetMaxY(_segView.frame)-34)
                                                         withArray:arr];
    }else{
        _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              CGRectGetMaxY(_segView.frame)+2,
                                                                              Main_Screen_Width,
                                                                              Main_Screen_Height - 49 - CGRectGetMaxY(_segView.frame))
                                                         withArray:arr];
    }
    
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


#pragma mark - 私有方法 -
//我的提问按钮点击
-(void)right_button_event:(UIButton*)sender{
    MyTiwenVc *vc = [[MyTiwenVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    self.searchBtn.hidden = YES;
    self.tiwenBtn.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}

//点击提问按钮
-(void)tiwenBtnClick{
    QuestionsViewController *publicPage = [[QuestionsViewController alloc] init];
    [self.navigationController pushViewController:publicPage animated:YES];
    self.searchBtn.hidden = YES;
    self.tiwenBtn.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}

-(QATableVIewController *)tablecontroller{
    QATableVIewController *vc = [[QATableVIewController alloc] init];
    vc.delegate = self;
    return vc;
}

//弹出搜索视图
- (void)setUpSearch
{
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
    //数据数组
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    //创建搜索控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"输入想要搜索的关键词" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        //创建搜索后的控制器
        [searchViewController.navigationController pushViewController:[[SearchResultVcViewController alloc] init] animated:YES];
    }];

    searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;

    searchViewController.delegate = self;
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
    
}


//弹出标签管理视图
-(void)addMenuBtnClick{
    
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu];
    self.newsMenu = sheetMenu;
    sheetMenu.mySubjectArray = @[@"问题1",@"问题2",@"问题3",@"问题4",@"问题5"].mutableCopy;
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

#pragma mark - 搜索控制器Delegate -
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        //发起网络请求,请求联想的内容
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                
                [searchSuggestionsM addObject:searchSuggestion];
            }
            //联想数组复制
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark - DetailTableViewController代理方法 -
//监听table点击方法传来索引
-(void)QAtableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath{
    
    AnswerViewController *pageDetail = [[AnswerViewController alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
    self.searchBtn.hidden = YES;
    self.tiwenBtn.hidden = YES;
    
}

-(void)clickHeadImageJumpToPersonDetailPage:(NSInteger)indexPath{
    //推出个人展示页
    PersonViewController *vc = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.searchBtn.hidden = YES;
    self.tiwenBtn.hidden = YES;
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
