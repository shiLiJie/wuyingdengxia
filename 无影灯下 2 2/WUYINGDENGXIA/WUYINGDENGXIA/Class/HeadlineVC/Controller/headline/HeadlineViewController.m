//
//  HeadlineViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#define segViewHigh     44
#define bannerHigh      150

#import "HeadlineViewController.h"
#import "SearchBarEffectController.h"
#import "HW3DBannerView.h"
#import "DetailTableViewController.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "ZZNewsSheetMenu.h"
#import "PageDetailViewController.h"
#import "PublicPageViewController.h"
#import "DiscussCollectionView.h"
#import "PersonViewController.h"

@interface HeadlineViewController ()<UISearchBarDelegate,
                                    SearchBarDelegate,
                                    MDMultipleSegmentViewDeletegate,
                                    MDFlipCollectionViewDelegate,
                                    JohnScrollViewDelegate
                                    >

{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

//顶部navbar搜索栏
@property(nonatomic, strong) UISearchBar * searchBar;
//搜索上边隐藏的btn,其实点击的是他
@property(nonatomic, strong) UIButton *searchBtn;
//轮播图
@property(nonatomic,strong) HW3DBannerView *scrollView;
//兴趣标签编辑界面
@property(nonatomic, strong) ZZNewsSheetMenu *newsMenu;
//讨论collection
@property (nonatomic, strong) DiscussCollectionView *discuss;




@end

@implementation HeadlineViewController

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
    self.searchBar.hidden = NO;
    self.searchBtn.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加UI控件
    [self addUI];
    
}

-(DetailTableViewController *)tablecontroller{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    vc.delegate = self;
    __weak typeof(self) weakSelf = self;
    vc.DidScrollBlock = ^(CGFloat scrollY) {
        [weakSelf johnScrollViewDidScroll:scrollY];
    };
    return vc;
}


#pragma mark - UI设置 -
//添加各种试图
-(void)addUI{
    [self.navigationController.view addSubview:self.searchBar];
    [self.navigationController.view addSubview:self.searchBtn];
    //添加banner
    [self addBannerView];
    //添加标签控制器
    [self addSegView];
    //添加讨论collection
    [self addDiscussUI];
   
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

-(UIButton *)set_leftButton{
    UIButton *right = [[UIButton alloc] init];

    [right setImage:GetImage(@"saoma") forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:14]];
    return right;
}

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    [right setTitle:@"投稿" forState:UIControlStateNormal];
    [right setTitleColor:RGB(30, 150, 255) forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:17]];
    return right;
}
//搜索searchbar 禁用
//- (UISearchBar *)searchBar
//{
//    if (_searchBar == nil) {
//        _searchBar = [[UISearchBar alloc]init];
//        if (kDevice_Is_iPhoneX) {
//            _searchBar.frame = CGRectMake(45, 40, Main_Screen_Width-100, 44);
//        }else{
//            _searchBar.frame = CGRectMake(45, 15, Main_Screen_Width-100, 44);
//        }
//        _searchBar.userInteractionEnabled = NO;
//        // 去除searchbar上下两条黑线及设置背景
//        _searchBar.barTintColor = [UIColor whiteColor];
//        _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
//        _searchBar.layer.borderWidth = 1;
//        [_searchBar sizeToFit];
//        [_searchBar setPlaceholder:@"输入想要搜索的关键词"];
//        [_searchBar setDelegate:self];
//        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
//        [_searchBar setTranslucent:NO];//设置是否透明
//        [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
//        _searchBar.tintColor = [UIColor blackColor];
//        //设置searchbar背景颜色
//        for (UIView *subView in _searchBar.subviews) {
//            if ([subView isKindOfClass:[UIView  class]]) {
//                [[subView.subviews objectAtIndex:0] removeFromSuperview];
//                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
//                    UITextField *textField = [subView.subviews objectAtIndex:0];
//                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//                    if (kDevice_Is_iPhone5) {
//                        textField.font = [UIFont systemFontOfSize:11];
//                    }else{
//                        textField.font = [UIFont systemFontOfSize:12];
//                    }
//                }
//            }
//        }
//    }
//    return _searchBar;
//}

//搜索bar上边的按钮,实际点击的是他
-(UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
//        _searchBtn.frame = _searchBar.frame;
        if (kDevice_Is_iPhoneX) {
            _searchBtn.frame = CGRectMake(45, 40, Main_Screen_Width-110, 33);
        }else{
            _searchBtn.frame = CGRectMake(45, 25, Main_Screen_Width-110, 33);
        }
        [_searchBtn addTarget:self action:@selector(setUpSearch) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setImage:GetImage(@"shouye") forState:UIControlStateNormal];
        [_searchBtn setImage:GetImage(@"shouye") forState:UIControlStateHighlighted];
    }
    return _searchBtn;
}

//添加banner
-(void)addBannerView{
    if (kDevice_Is_iPhoneX) {
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 90, Main_Screen_Width, bannerHigh) imageSpacing:10 imageWidth:Main_Screen_Width - 50];
    }else{
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 75, Main_Screen_Width, bannerHigh) imageSpacing:10 imageWidth:Main_Screen_Width - 50];
    }
    
    _scrollView.initAlpha = 0.5; // 设置两边卡片的透明度
    _scrollView.imageRadius = 10; // 设置卡片圆角
    _scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    // 设置要加载的图片
    self.scrollView.data = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",
                             @"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",
                             @"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",
                             @"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",
                             @"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];
    _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
    [self.view addSubview:self.scrollView];
    _scrollView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调

    };
}

//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    _segView.frame = CGRectMake(0,CGRectGetMaxY(self.scrollView.frame), Main_Screen_Width-segViewHigh, segViewHigh);
    _segView.items = @[@"头条",@"热门", @"制标", @"动态", @"课题"];
    [self.view addSubview:_segView];
    
    //添加加号➕按钮
    UIButton *addMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh)];
//    [addMenuBtn setTitle:@"╋" forState:UIControlStateNormal];
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
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_segView.frame)+78,
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - 75)
                                                     withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

//添加讨论collection
-(void)addDiscussUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.sectionInset = UIEdgeInsetsMake(0 , 0, 0, 0 );
    
    layout.itemSize = CGSizeMake(kScreen_Width/5*3, 68);
    
    // 设置最小行间距
    layout.minimumLineSpacing = 15 ;
    // 设置最小列间距
    
    self.discuss = [[DiscussCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segView.frame), kScreen_Width, 78) collectionViewLayout:layout];
    self.discuss.backgroundColor = RGB(248, 248, 248);
    [self.view addSubview:self.discuss];
}

#pragma mark - 按钮action -
//发表文章
-(void)right_button_event:(UIButton*)sender{
    PublicPageViewController *publicPage = [[PublicPageViewController alloc] init];
    [self.navigationController pushViewController:publicPage animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
}
//二维码扫一扫
-(void)left_button_event:(UIButton *)sender{
    
}

#pragma mark - 私有方法 -
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

#pragma mark - 搜索页代理方法 -
- (void)didSelectKey:(NSString *)key{
    
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

#pragma mark - DetailTableViewController代理方法 -
- (void)johnScrollViewDidScroll:(CGFloat)scrollY{
    CGFloat headerViewY;
    if (scrollY > 0) {
        
        [self.scrollView.timer invalidate];//滚动过程中banner定时器停止
        self.scrollView.timer = nil;
        if (kDevice_Is_iPhoneX) {
            headerViewY = -scrollY + 90;
        }else{
            headerViewY = -scrollY + 75;
        }
        
        if (scrollY > bannerHigh) {
            if (kDevice_Is_iPhoneX) {
                headerViewY = -bannerHigh + 80;
            }else{
                headerViewY = -bannerHigh + 64;
            }
            
        }
    }else{
        if (kDevice_Is_iPhoneX) {
            headerViewY = 90;
        }else{
            headerViewY = 75;
        }
        
        if (self.scrollView.timer == nil) {
            [self.scrollView createTimer];//滚回来banner定时器再次启动
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrollView.frame = CGRectMake(0,headerViewY, Main_Screen_Width, bannerHigh);
        _segView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), Main_Screen_Width, segViewHigh);
        _discuss.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame), Main_Screen_Width, 78);
        _collectView.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame)+78, Main_Screen_Width, Main_Screen_Height - CGRectGetMaxY(self.scrollView.frame));
        [self.scrollView updateViewFrameSetting];
        
    });
}

//监听table点击方法传来索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath{
    
    PageDetailViewController *pageDetail = [[PageDetailViewController alloc] init];
    [self.navigationController pushViewController:pageDetail animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
}

//点击用户名和头像跳入个人发表的文章页
-(void)clickUserNamePushPublishVc{
    PersonViewController *publishPerson = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:publishPerson animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
