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
#import "DFSegmentView.h"

#import "DetailTableViewCell.h"
#import "searchResultModel.h"
#import "AnswerViewController.h"
#import "QusetionModel.h"
#import "QATableVIewCell.h"

@interface HeadlineViewController ()<UISearchBarDelegate,
                                    SearchBarDelegate,
                                    JohnScrollViewDelegate,
                                    PYSearchViewControllerDelegate,
                                    PYSearchViewControllerDataSource,
                                    DiscussCollectionDelegate,
                                    DFSegmentViewDelegate
                                    >

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
//获取标签模型数组
@property (nonatomic, strong) NSArray *labelArr;
//获取搜索模型数组
@property (nonatomic, strong) NSMutableArray *searchArr;
//获取标签名称数组
@property (nonatomic, strong) NSMutableArray *labelnameArr;

@property (nonatomic, strong) DFSegmentView *segment;
//二维码扫描后返回字符串
@property (nonatomic,copy) NSString *scanStr;


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
    if (isIOS10) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    [self.navigationController.view addSubview:self.searchBar];
    [self.navigationController.view addSubview:self.searchBtn];
    
    //添加UI控件
    [self addUI];
    //加载数组
    [self addArr];
    //监听网络情况
    [self netWorkStatus];
}

//初始化数组
-(void)addArr{
    self.labelArr = [[NSArray alloc] init];
    self.labelnameArr = [[NSMutableArray alloc] init];
    self.searchArr = [[NSMutableArray alloc] init];
}

-(DetailTableViewController *)tablecontroller:(NSString *)lable{
    DetailTableViewController *vc = [[DetailTableViewController alloc] init];
    vc.lable = lable;
    vc.choosetype = labelType;
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
    left.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    return left;
}

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    right.frame = CGRectMake(kScreen_Width-44, 0, 44, 60);
    [right setTitle:@"投稿" forState:UIControlStateNormal];
    [right setTitleColor:RGB(30, 150, 255) forState:UIControlStateNormal];
    [right setFont: [UIFont systemFontOfSize:17]];
    right.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
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
            _searchBtn.frame = CGRectMake(60, 25, Main_Screen_Width-120, 36);
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
        if (isIOS10) {
            _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 10, Main_Screen_Width, bannerHigh) imageSpacing:10 imageWidth:Main_Screen_Width - 50];
        }else{
            _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 75, Main_Screen_Width, bannerHigh) imageSpacing:10 imageWidth:Main_Screen_Width - 50];
        }
        
    }
    
    _scrollView.initAlpha = 0.5; // 设置两边卡片的透明度
    _scrollView.imageRadius = 4; // 设置卡片圆角
    _scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    // 设置要加载的图片
    [self getBannerNetData];
}

//banner网络请求
-(void)getBannerNetData{
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
                                                           UserInfoModel *user = [UserInfoModel shareUserModel];
                                                           [user loadUserInfoFromSanbox];
                                                           model1.banner_link = [model1.banner_link stringByAppendingString:[NSString stringWithFormat:@"&user_id=%@",user.userid]];
                                                           //当前banner的链接,点的时候直接加载就ok
                                                           //            NSLog(@"%@",model1.banner_link);
                                                           bannerResultvc *vc = [[bannerResultvc alloc] init];
                                                           
                                                           if ([model1.banner_link hasPrefix:@"http://"] || [model1.banner_link hasPrefix:@"https://"]) {
                                                               
                                                           } else {
                                                               model1.banner_link = [NSString stringWithFormat:@"http://%@", model1.banner_link];
                                                           }
                                                           vc.url = model1.banner_link;
                                                           [weakSelf.navigationController pushViewController:vc animated:YES];
                                                           weakSelf.searchBar.hidden = YES;
                                                           weakSelf.searchBtn.hidden = YES;
                                                       };
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
}


#pragma mark - segement代理 -
- (UIViewController *)superViewController {
    return self;
}


- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    
//    lableModel *model = [[lableModel alloc] init];
//    NSMutableArray *muArr = [[NSMutableArray alloc] init];
//    for (model in self.labelArr) {
//        [muArr addObject:model.key_name];
//    }

    DetailTableViewController * baseVC = [self tablecontroller:self.segment.reloadTitleArr[index]];
    baseVC.lableName = self.segment.reloadTitleArr[index];
    
    return baseVC;
}


- (void)headTitleSelectWithIndex:(NSInteger)index {
    
    //  在这里可以获取到当前的baseViewController
    NSLog(@"%ld",(long)index);

}

//添加segview标签控制器
-(void)addSegView{


    self.segment = [DFSegmentView new];
    
//    self.segment.frame = CGRectMake(0,CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -CGRectGetMaxY(self.scrollView.frame)-50);
    self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22 -TopBarHeight);
    
    [self.view addSubview:self.segment];

    self.segment.delegate = self;

    [self getSegViewData];

    //添加加号➕按钮
    self.addMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh)];
//    [addMenuBtn setTitle:@"╋" forState:UIControlStateNormal];
    [self.addMenuBtn setImage:GetImage(@"Group 2") forState:UIControlStateNormal];
    [self.addMenuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addMenuBtn addTarget:self action:@selector(addMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addMenuBtn];
    
}

//标签控制器网络请求
-(void)getSegViewData{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_labels?userid=%@&type=1",user.userid]]
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
                                                               [muArr addObject:model.name];
                                                           }
                                                           
                                                           self.segment.reloadTitleArr = muArr;
                                                           [self.segment reloadData];
                                                           
                                                       }else{
                                                           [MBProgressHUD showSuccess:obj[@"msg"]];
                                                       }
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
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
    self.discuss = [[DiscussCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+44, kScreen_Width, 78) collectionViewLayout:layout];
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
        LoginVc *loginVc = [LoginVc loginControllerWithBlock:^(BOOL result, NSString *message) {

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
    
    __weak typeof(self) weakSelf = self;
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
        
        
        weakSelf.scanStr = result;
    //        if (error) {
    //
    //        } else {
            UserInfoModel *user = [UserInfoModel shareUserModel];
            [user loadUserInfoFromSanbox];
        
            if ([weakSelf.scanStr containsString:@"type=2"]) {
                
                //会议签到
                NSArray *array = [weakSelf.scanStr componentsSeparatedByString:@"toid="];
                NSDictionary *dict = @{
                                       @"userid" : user.userid,
                                       @"type" : @"2",
                                       @"toid" : array[1]
                                       };
                
                [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_sign.html"] parameters:dict success:^(id obj) {
                    if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                        
                        [MBProgressHUD showSuccess:obj[@"msg"]];
                    }else{
                        [MBProgressHUD showError:obj[@"msg"]];
                    }
                } fail:^(NSError *error) {
                    [MBProgressHUD showError:@"签到失败"];
                }];
                
            }else{
                
                //扫码登录
                weakSelf.scanStr = [weakSelf.scanStr stringByAppendingString:[NSString stringWithFormat:@"&user_token=%@&user_id=%@",user.user_token,user.userid]];
                
                NSURL *url;
                if ([weakSelf.scanStr containsString:@"http://"] || [weakSelf.scanStr containsString:@"https://"]) {
                    url = [NSURL URLWithString:weakSelf.scanStr];
                } else {
                    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", weakSelf.scanStr]];
                }
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager GET:[url absoluteString] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                    
                    if (responseObject)
                    {
                        
                    }
                } failure:^(NSURLSessionTask *operation, NSError *error) {
                }];
            }
            
            
//        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
    self.searchBar.hidden = YES;
    self.searchBtn.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}

#pragma mark - 私有方法 -
/**
 网络监听
 */
-(void)netWorkStatus{
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            
            return ;
        }
        if(status == AFNetworkReachabilityStatusReachableViaWiFi){
            
            [weakSelf getSegViewData];
            [weakSelf getBannerNetData];
            [weakSelf.discuss getDisNetData];
            return ;
        }
        if(status == AFNetworkReachabilityStatusReachableViaWWAN){
            
            [weakSelf getSegViewData];
            [weakSelf getBannerNetData];
            [weakSelf.discuss getDisNetData];
            return ;
        }
    }];
}

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
                                                           
                                                       }];
                                                       
                                                       searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
                                                       searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
                                                       
                                                       searchViewController.delegate = self;
                                                       searchViewController.dataSource = self;
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
            NSArray *arr = obj[@"data"];
            NSMutableArray *arrayM = [NSMutableArray array];
            for (int i = 0; i < arr.count; i ++) {
                NSDictionary *dict = arr[i];
                searchResultModel *model = [searchResultModel searchResultWithDict:dict];
                if ([model.type isEqualToString:@"1"]) {
                    [arrayM addObject:model];
                }
                if ([model.type isEqualToString:@"2"]) {
                    [arrayM addObject:model];
                }
                
                
            }
            self.searchArr= arrayM;

        }else{

        } 
    }
                                                      fail:^(NSError *error) {  
    }];
}


//弹出标签管理视图
-(void)addMenuBtnClick{
    
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu];
    self.newsMenu = sheetMenu;
    self.newsMenu.pageOrqa = @"1";

    if (kObjectIsEmpty(self.labelnameArr)) {
        lableModel *model = [[lableModel alloc] init];
        for (model in self.labelArr) {
            [self.labelnameArr addObject:model.name];
        }
    }
    __weak typeof(self) weakSelf = self;
    sheetMenu.mySubjectArray = self.labelnameArr;
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [self.newsMenu showNewsMenu];
    });
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_labels_rand?limit=10&type=1"]
                                                 parameters:nil
                                                    success:^(id obj) {

                                                        NSMutableArray *labArr = [[NSMutableArray alloc] init];
                                                        NSArray *arr = obj[@"data"];
                                                        NSDictionary *dict = @{
                                                                               @"label_name":@""
                                                                               };
                                                        for (dict in arr) {
                                                            if (![sheetMenu.mySubjectArray containsObject:dict[@"label_name"]]) {
                                                                [labArr addObject:dict[@"label_name"]];
                                                            }
                                                        }
                                                        sheetMenu.recommendSubjectArray = labArr;
                                                        [weakSelf.newsMenu layoutSubviews];

                                                    }
                                                       fail:^(NSError *error) {

                                                       }];

    [self.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
        //        cofig.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    }];


    //回调编辑好的兴趣标签
    [self.newsMenu updataItmeArray:^(NSMutableArray *itemArray) {
        //给segeview标签数组赋值

        self.segment.reloadTitleArr = itemArray;
        [self.segment reloadData];
        self.labelnameArr = itemArray;

        //自定义标签
        UserInfoModel *user = [UserInfoModel shareUserModel];
        [user loadUserInfoFromSanbox];
        NSString *string = [itemArray componentsJoinedByString:@","];
        NSDictionary *dict = @{
                               @"userId":user.userid,
                               @"labelname":string,
                               @"type":@"1",
                               };
        [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_addMyLabel"]
                                                     parameters:dict
                                                        success:^(id obj) {
                                                            if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                
//                                                                [MBProgressHUD showSuccess:obj[@"msg"]];
                                                            }else{
//                                                                [MBProgressHUD showError:obj[@"msg"]];
                                                            }
                                                            
        } fail:^(NSError *error) {
            
        }];
    }];
 
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
- (void)searchViewController:(PYSearchViewController *)searchViewController
         searchTextDidChange:(UISearchBar *)seachBar
                  searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
            // Refresh and display the search suggustions
            
            [self searchWithKey:searchText];
            
//            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)indexPath
                   searchBar:(UISearchBar *)searchBar{
    searchResultModel *model = [[searchResultModel alloc] init];
    model = self.searchArr[indexPath.row];
    if ([model.type isEqualToString:@"1"]) {
        PageDetailViewController *vc = [[PageDetailViewController alloc] init];
        vc.articleid = model.type_id;
        [searchViewController.navigationController pushViewController:vc animated:YES];
    }
    if ([model.type isEqualToString:@"2"]) {
        AnswerViewController *vc = [[AnswerViewController alloc] init];
        QusetionModel *qmodel = [[QusetionModel alloc] init];
        qmodel.question_id = model.type_id;
        vc.questionModel = qmodel;
        vc.choosetype = questionType;
        [searchViewController.navigationController pushViewController:vc animated:YES];
    }
}


- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView
                    cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    searchResultModel *model = self.searchArr[indexPath.row];
    static NSString * reuseID = @"cell";
    if ([model.type isEqualToString:@"1"]) {
        DetailTableViewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:reuseID];
        cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][0];
        cell.mainTitle.text = model.title;
//        cell.pageDetail.text = model.content;
        
        return cell;
    }else{
        QATableVIewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:reuseID];
        cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][0];
        cell.mainTitle.text = model.title;
//        cell.detailPage.text = model.content;
        
        return cell;
    }

}


- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView
            numberOfRowsInSection:(NSInteger)section{
    
    return self.searchArr.count;
}


- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView{
    return 1;
}


- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView
        heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}


#pragma mark - DetailTableViewController代理方法 -
- (void)johnScrollViewDidScroll:(CGFloat)scrollY{

    
//    NSLog(@"%f",scrollY);
    __block CGFloat headerViewY;
    
    
    //上滑
    if (scrollY > 0) {
        
        [self.scrollView.timer invalidate];//滚动过程中banner定时器停止
        self.scrollView.timer = nil;
        
        
        //推到顶部了
        if (scrollY > bannerHigh +12) {
            if (kDevice_Is_iPhoneX) {
                headerViewY = -bannerHigh + 78;
            }else{
                headerViewY = -bannerHigh + 64;
            }
        }else{
            //没推到顶部,少判断
            if (kDevice_Is_iPhoneX) {
                headerViewY = -scrollY + 90;
            }else{
                headerViewY = -scrollY + 76;
            }
        }
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            if (isIOS10) {
                self.scrollView.frame = CGRectMake(0,-bannerHigh, Main_Screen_Width, bannerHigh);
                //        self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -44-headerViewY-bannerHigh);
                self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -44 -TopBarHeight);
                self.addMenuBtn.frame = CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh);
                self.discuss.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+44, Main_Screen_Width, 78);
            }else{
                if (kDevice_Is_iPhoneX) {
                    self.scrollView.frame = CGRectMake(0,-bannerHigh + 88, Main_Screen_Width, bannerHigh);
                }else{
                    self.scrollView.frame = CGRectMake(0,-bannerHigh + 64, Main_Screen_Width, bannerHigh);
                }
                
                //        self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -44-headerViewY-bannerHigh);
                if (kDevice_Is_iPhoneX){
                    self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22 -TopBarHeight - 78);
                }else{
                    self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22 -TopBarHeight);
                }
                
                self.addMenuBtn.frame = CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh);
                self.discuss.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+44, Main_Screen_Width, 78);
            }
            
        } completion:^(BOOL finished) {
            
        }];

        
//        dispatch_async(dispatch_get_main_queue(), ^{
//                self.scrollView.frame = CGRectMake(0, headerViewY, Main_Screen_Width, bannerHigh);
//                self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22-headerViewY-bannerHigh);
////                self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22 -TopBarHeight);
//                self.addMenuBtn.frame = CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh);
//                self.discuss.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+44, Main_Screen_Width, 78);
//
//        });
        
    }else if (scrollY < 0){
        //下滑
        if (kDevice_Is_iPhoneX) {
            headerViewY = 90;
        }else{
            if (isIOS10) {
                headerViewY = 10;
            }else{
                headerViewY = 76;
            }
            
        }

        if (self.scrollView.timer == nil) {
            [self.scrollView createTimer];//滚回来banner定时器再次启动
        }
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.scrollView.frame = CGRectMake(0,headerViewY, Main_Screen_Width, bannerHigh);
            //        self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -44-headerViewY-bannerHigh);
            self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22 -TopBarHeight);
            self.addMenuBtn.frame = CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh);
            self.discuss.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+44, Main_Screen_Width, 78);
        } completion:^(BOOL finished) {
            
        }];


//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            self.scrollView.frame = CGRectMake(0,headerViewY, Main_Screen_Width, bannerHigh);
//                    self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22-headerViewY-bannerHigh);
////            self.segment.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+1, Main_Screen_Width, kScreen_Height -22-TopBarHeight);
//            self.addMenuBtn.frame = CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMaxY(self.scrollView.frame), segViewHigh, segViewHigh);
//            self.discuss.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)+44, Main_Screen_Width, 78);
//
//        });
    }

}

//监听table点击方法传来索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath
                            article_id:(NSString *)articleid
                               user_id:(NSString *)userid
                             pageModle:(pageModel *)model{
    
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
