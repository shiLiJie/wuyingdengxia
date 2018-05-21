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
#import "MDMultipleSegmentView1.h"
#import "MDFlipCollectionView.h"
#import "ZZNewsSheetMenu.h"
#import "PageDetailViewController.h"
#import "PublicPageViewController.h"
#import "DiscussCollectionView.h"
#import "PersonViewController.h"
#import "PYSearch.h"
#import "SearchResultVcViewController.h"
#import "MMScanViewController.h"
#import "DiscussVc.h"
#import "bannermodel.h"
#import "lableModel.h"
#import "bannerResultvc.h"
#import "hotKeyModel.h"


@interface HeadlineViewController ()<UISearchBarDelegate,
                                    SearchBarDelegate,
                                    MDMultipleSegmentView1Deletegate,
                                    MDFlipCollectionViewDelegate,
                                    JohnScrollViewDelegate,
                                    PYSearchViewControllerDelegate,
                                    DiscussCollectionDelegate
                                    >

{
    MDMultipleSegmentView1 *_segView;    //标签视图
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
//添加加号➕按钮
@property (nonatomic, strong) UIButton *addMenuBtn;
//获取标签数组
@property (nonatomic, strong) NSArray *labelArr;



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
    //加载数组
    [self addArr];
}

//初始化数组
-(void)addArr{
    self.labelArr = [[NSArray alloc] init];
}

-(DetailTableViewController *)tablecontroller:(NSString *)lable{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    vc.lable = lable;
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
    UIButton *left = [[UIButton alloc] init];
    left.frame = CGRectMake(0, 0, 44, 60);
    [left setImage:GetImage(@"saoma") forState:UIControlStateNormal];
    [left setFont: [UIFont systemFontOfSize:14]];
    left.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    return left;
}

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    right.frame = CGRectMake(kScreen_Width-44, 0, 44, 60);
    [right setTitle:@"投稿" forState:UIControlStateNormal];
    [right setTitleColor:RGB(30, 150, 255) forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:17]];
    right.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    return right;
}

//搜索bar上边的按钮,实际点击的是他
-(UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
//        _searchBtn.frame = _searchBar.frame;
        if (kDevice_Is_iPhoneX) {
            _searchBtn.frame = CGRectMake(50, 48, Main_Screen_Width-105, 36);
        }else{
            _searchBtn.frame = CGRectMake(50, 25, Main_Screen_Width-105, 36);
        }
        [_searchBtn addTarget:self action:@selector(setUpSearch) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setBackgroundColor:RGB(245, 245, 245)];
        [_searchBtn setImage:GetImage(@"Fill 1") forState:UIControlStateNormal];
        [_searchBtn setTitle:@"输入想要搜索的关键词" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = SYSTEMFONT(12);
        [_searchBtn setTitleColor:RGB(181, 181, 181) forState:UIControlStateNormal];
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchBtn.layer.cornerRadius = 18;//半径大小
        _searchBtn.layer.masksToBounds = YES;//是否切割

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
    _scrollView.imageRadius = 4; // 设置卡片圆角
    _scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    // 设置要加载的图片
    
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_allbanner"]
                                                parameters:nil
                                                   success:^(id obj) {
        NSMutableArray *bannermodelarr = [[NSMutableArray alloc] init];
        NSArray *arr = obj[@"data"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *dict = arr[i];
            [arrayM addObject:[bannermodel bannerWithDict:dict]];
        }
        bannermodel *model = [[bannermodel alloc] init];
        for (model in arrayM) {
            [ bannermodelarr addObject:model.banner_imgpath];
        }
        weakSelf.scrollView.data = bannermodelarr;
        _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
        [weakSelf.view addSubview:weakSelf.scrollView];
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
            bannermodel *model1 = [[bannermodel alloc] init];
            model1 = arrayM[currentIndex];
            //当前banner的链接,点的时候直接加载就ok
            NSLog(@"%@",model1.banner_link);
            bannerResultvc *vc = [[bannerResultvc alloc] init];
            vc.url = model1.banner_link;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            weakSelf.searchBar.hidden = YES;
            weakSelf.searchBtn.hidden = YES;
        };
    } fail:^(NSError *error) {
        
    }];
}

//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView1 alloc] init];
    _segView.delegate =  self;
    _segView.frame = CGRectMake(0,CGRectGetMaxY(self.scrollView.frame), Main_Screen_Width-segViewHigh, segViewHigh);
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_labelList?user_id=%@&type=1",user.userid]]
                                                parameters:nil 
                                                   success:^(id obj) {
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {

            NSArray *arr = obj[@"data"];
            NSMutableArray *arrayM = [NSMutableArray array];
            for (int i = 0; i < arr.count; i ++) {
                NSDictionary *dict = arr[i];
                [arrayM addObject:[lableModel lableWithDict:dict]];
                
            }
            self.labelArr= arrayM;
            lableModel *model = [[lableModel alloc] init];
            NSMutableArray *muArr = [[NSMutableArray alloc] init];
            for (model in self.labelArr) {
                [muArr addObject:model.key_name];
            }
            _segView.items = muArr;

            //创建标签下table控制器
            NSMutableArray *tableArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < muArr.count; i++) {
                [tableArr addObject:[self tablecontroller:muArr[i]]];
            }
            NSArray *tablearr = tableArr;
            if (kDevice_Is_iPhoneX) {
                _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                      CGRectGetMaxY(_segView.frame)+78,
                                                                                      Main_Screen_Width,
                                                                                      Main_Screen_Height - CGRectGetMaxY(_segView.frame)+33 - 34)
                                                                 withArray:tablearr];
            }else{
                _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                      CGRectGetMaxY(_segView.frame)+78,
                                                                                      Main_Screen_Width,
                                                                                      Main_Screen_Height - CGRectGetMaxY(_segView.frame)+33)
                                                                 withArray:tablearr];
            }
            
            _collectView.delegate = self;
            [self.view addSubview:_collectView];
            
        }else{
            [MBProgressHUD showSuccess:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        
    }];
    [self.view addSubview:_segView];
    
    //添加加号➕按钮
    self.addMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh)];
//    [addMenuBtn setTitle:@"╋" forState:UIControlStateNormal];
    [self.addMenuBtn setImage:GetImage(@"Group 2") forState:UIControlStateNormal];
    [self.addMenuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addMenuBtn addTarget:self action:@selector(addMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addMenuBtn];
    
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
    self.discuss.delegate1 = self;
    [self.view addSubview:self.discuss];
}


#pragma mark - 按钮action -
//发表文章
-(void)right_button_event:(UIButton*)sender{
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    //判断用户登录状态
    if (user.loginStatus) {
        //登录过了已经
        PublicPageViewController *publicPage = [[PublicPageViewController alloc] init];
        [self.navigationController pushViewController:publicPage animated:YES];
    }else{
        __weak typeof(self) weakSelf = self;
        LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {
//            if (result) {
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//                PublicPageViewController *publicPage = [[PublicPageViewController alloc] init];
//                [weakSelf.navigationController pushViewController:publicPage animated:YES];
//            }
        }];
        [self.navigationController pushViewController:loginVc animated:YES];
    }

    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}
//二维码扫一扫
-(void)left_button_event:(UIButton *)sender{
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
        if (error) {

        } else {
            UserInfoModel *user = [UserInfoModel shareUserModel];
            [user loadUserInfoFromSanbox];
            result = [result stringByAppendingString:[NSString stringWithFormat:@"&user_token=%@&user_id=%@",user.user_token,user.userid]];
            
            NSURL *url;
            if ([result hasPrefix:@"http://"] || [result hasPrefix:@"https://"]) {
                url = [NSURL URLWithString:result];
            } else {
                url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", result]];
            }
            
            NSLog(@"%@",result);
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:[url absoluteString] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                
                if (responseObject)
                {

                }
            } failure:^(NSURLSessionTask *operation, NSError *error) {
            }];
        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}

#pragma mark - 私有方法 -
//扫一扫方法
- (void)showInfo:(NSString*)str {
    [self showInfo:str andTitle:@"提示"];
}
//弹框提示二维码
- (void)showInfo:(NSString*)str andTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
        action;
    });
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:NULL];
}
//弹出搜索视图
- (void)setUpSearch
{
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
//    [self.newsMenu setRecommentSubject];
    
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_hotWords"]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                
                                                       NSMutableArray *arrayy = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           hotKeyModel *model = [hotKeyModel hotKeyWithDict:dict];
                                                           [arrayy addObject:model.search_content];
                                                       }
                                                       
//                                                       self.modelArr= arrayM;
                                                       //数据数组
                                                       NSArray *hotSeaches = arrayy;
                                                       //创建搜索控制器
                                                       PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"输入想要搜索的关键词" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
                                                           
                                                           [weakSelf searchWithKey:searchText];
                                                           
                                                           //创建搜索后的控制器
//                                                           [searchViewController.navigationController pushViewController:[[SearchResultVcViewController alloc] init] animated:YES];
                                                       }];
                                                       
                                                       searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
                                                       searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
                                                       
                                                       searchViewController.delegate = self;
                                                       // 5. Present a navigation controller
                                                       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
                                                       [self presentViewController:nav animated:NO completion:nil];
    }
                                                      fail:^(NSError *error) {
        
    }];

}


/**
 搜索请求方法

 @param key 搜索关键词
 */
-(void)searchWithKey:(NSString *)key{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
        NSString  *url = [[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"searchall?user_id=%@&key=%@",user.userid,key]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:url
                                                parameters:nil
                                                   success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:SucceedCoder]) {
            
            [MBProgressHUD showSuccess:obj[@"msg"]];
        }else{
            [MBProgressHUD showError:obj[@"msg"]];
        }
        
    }
                                                      fail:^(NSError *error) {
        
    }];
}


//弹出标签管理视图
-(void)addMenuBtnClick{
    
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu];
    self.newsMenu = sheetMenu;
    
    lableModel *model = [[lableModel alloc] init];
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (model in self.labelArr) {
        [muArr addObject:model.key_name];
    }
    
    sheetMenu.mySubjectArray = muArr;
    sheetMenu.recommendSubjectArray = @[@"体育科技科技",@"军事",@"音乐科技科技",@"电影",@"中国风科技",@"摇滚",@"小说",@"梦想",@"机器科技",@"电脑"].mutableCopy;
    
//    sheetMenu.mySubjectArray = @[@"科技1",@"科技2",@"科技3",@"科技4",@"科技5"].mutableCopy;
//    sheetMenu.recommendSubjectArray = @[@"体育科技科技",@"军事",@"音乐科技科技",@"电影",@"中国风科技",@"摇滚",@"小说",@"梦想",@"机器科技",@"电脑"].mutableCopy;
//    sheetMenu.recommentBlock = ^{
//        sheetMenu.recommendSubjectArray = @[@"摇滚",@"小说",@"梦想",@"机器科技",@"电脑"].mutableCopy;
//    };
    
//    [sheetMenu setRecommentSubject];
    //设置视图界面,从新设置的时候 recommendSubjectArray 数组从新定义,然后在调用次方法
    [self.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
//        cofig.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    }];
    
    [self.newsMenu showNewsMenu];
    //回调编辑好的兴趣标签
    [self.newsMenu updataItmeArray:^(NSMutableArray *itemArray) {
        //给segeview标签数组赋值
        _segView.items = itemArray;
    }];
    
    
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));
//    
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        sheetMenu.recommendSubjectArray = @[@"666",@"军事",@"音乐科技科技",@"电影",@"中国风科技",@"摇滚",@"小说",@"梦想",@"机器科技",@"电脑"].mutableCopy;
//        [sheetMenu setRecommentSubject];
//    });
    
}

#pragma mark - 讨论视图代理方法 -
-(void)clickDiscussToIndex:(NSInteger)index discussModel:(discussModel *)model{
    DiscussVc *vc = [[DiscussVc alloc] init];
    vc.model = [[discussModel alloc] init];
    vc.model = model;
    
    [self.navigationController pushViewController:vc animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
}


#pragma mark - 搜索页代理方法 -
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark - segement代理方法 -
- (void)changeSegmentAtIndex1:(NSInteger)index
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
        self.addMenuBtn.frame = CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh);
        _discuss.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame), Main_Screen_Width, 78);
        _collectView.frame = CGRectMake(0, CGRectGetMaxY(_segView.frame)+78, Main_Screen_Width, Main_Screen_Height - CGRectGetMaxY(self.scrollView.frame));
        [self.scrollView updateViewFrameSetting];
        
    });
}

//监听table点击方法传来索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath article_id:(NSString *)articleid user_id:(NSString *)userid pageModle:(pageModel *)model{
    
    PageDetailViewController *pageDetail = [[PageDetailViewController alloc] init];
    pageDetail.articleid = articleid;
    pageDetail.userid = userid;
    pageDetail.model = [[pageModel alloc] init];;
    pageDetail.model = model;
    [self.navigationController pushViewController:pageDetail animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
}

//点击用户名和头像跳入个人发表的文章页
-(void)clickUserNamePushPublishVcWithUserid:(NSString *)userid{
//    PersonViewController *publishPerson = [[PersonViewController alloc] init];
//    publishPerson.userid = userid;
//    [self.navigationController pushViewController:publishPerson animated:YES];
//    self.searchBar.hidden = YES;
//    self.searchBtn.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
