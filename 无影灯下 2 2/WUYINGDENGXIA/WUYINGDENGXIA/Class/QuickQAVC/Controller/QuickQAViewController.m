//
//  QuickQAViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#define segViewHigh     44

#import "QuickQAViewController.h"
#import "ZZNewsSheetMenu.h"
#import "QATableVIewController.h"
#import "PersonViewController.h"
#import "AnswerViewController.h"
#import "QuestionsViewController.h"
#import "PYSearch.h"
#import "SearchResultVcViewController.h"
#import "MyTiwenVc.h"
#import "lableModel.h"
#import "QusetionModel.h"

#import "DFSegmentView1.h"

#import "hotKeyModel.h"
#import "searchResultModel.h"
#import "PageDetailViewController.h"
#import "AnswerViewController.h"
#import "DetailTableViewCell.h"
#import "QATableVIewCell.h"

@interface QuickQAViewController ()<
                                    QATableVIewDelegate,
                                    PYSearchViewControllerDelegate,
                                    DFSegmentViewDelegate,
                                    PYSearchViewControllerDelegate,
                                    PYSearchViewControllerDataSource>

//搜索上边隐藏的btn,其实点击的是他
@property(nonatomic, strong) UIButton *searchBtn;
//提问按钮
@property(nonatomic, strong) UIButton *tiwenBtn;
//提问按钮边上竖线
@property(nonatomic, strong) UIView *shuView;
//兴趣标签编辑界面
@property(nonatomic, strong) ZZNewsSheetMenu *newsMenu;
//获取标签数组
@property (nonatomic, strong) NSArray *labelArr;
//获取标签名字数组
@property (nonatomic, strong) NSMutableArray *labelnameArr;

@property (nonatomic, strong) DFSegmentView1 *segment;
//获取搜索模型数组
@property (nonatomic, strong) NSMutableArray *searchArr;

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
    self.shuView.hidden = NO;

    self.right_button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (isIOS10) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self addUI];
    
    self.labelnameArr = [[NSMutableArray alloc] init];
    //搜索数组初始化
    self.searchArr = [[NSMutableArray alloc] init];
}

#pragma mark - UI -


//添加各种试图
-(void)addUI{
    
    [self.navigationController.view addSubview:self.tiwenBtn];
    [self.navigationController.view addSubview:self.searchBtn];
    [self.navigationController.view addSubview:self.shuView];

    //添加标签控制器
    [self addSegView];
    
}

//搜索bar上边的按钮,实际点击的是他
-(UIButton *)searchBtn{
    if (_searchBtn == nil) {
        _searchBtn = [[UIButton alloc] init];
        if (kDevice_Is_iPhoneX) {
            _searchBtn.frame = CGRectMake(10, 50, Main_Screen_Width-160, 33);
        }else{
            _searchBtn.frame = CGRectMake(10, 25, Main_Screen_Width-160, 33);
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
        _searchBtn.layer.cornerRadius = 16.5;//半径大小
        _searchBtn.layer.masksToBounds = YES;//是否切割
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

-(UIView *)shuView{
    if (_shuView == nil) {
        _shuView = [[UIView alloc] init];
        _shuView.backgroundColor = RGB(235, 235, 235);
        if (kDevice_Is_iPhoneX) {
            _shuView.frame = CGRectMake(CGRectGetMaxX(self.tiwenBtn.frame)+7, 44+11, 0.5, 44/2);
        }else{
            _shuView.frame = CGRectMake(CGRectGetMaxX(self.tiwenBtn.frame)+7, 20+11, 0.5, 44/2);
            
        }
    }
        return _shuView;
}

-(UIButton *)set_rightButton{
    UIButton *right = [[UIButton alloc] init];
    [right setTitle:@"我的提问" forState:UIControlStateNormal];
    [right setTitleColor:RGB(19, 151, 255) forState:UIControlStateNormal];
    right.frame = CGRectMake(kScreen_Width-60, 0, 44, 60);
    [right setFont: [UIFont systemFontOfSize:17]];
    return right;
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
    
    QATableVIewController * baseVC = [self tablecontroller:self.segment.reloadTitleArr[index]];
    
    return baseVC;
}


- (void)headTitleSelectWithIndex:(NSInteger)index {
    
    //  在这里可以获取到当前的baseViewController
    
}

//添加segview标签控制器
-(void)addSegView{
    
    self.segment = [DFSegmentView1 new];
    if (kDevice_Is_iPhoneX) {
        self.segment.frame = CGRectMake(0,90, Main_Screen_Width, kScreen_Height-90-56 - 24);
    }else{
        if (isIOS10) {
            self.segment.frame = CGRectMake(0,0, Main_Screen_Width, kScreen_Height-66-56);
        }else{
            self.segment.frame = CGRectMake(0,66, Main_Screen_Width, kScreen_Height-66-56);
        }
        
    }

    [self.view addSubview:self.segment];
    self.segment.delegate = self;
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_labels?userid=%@&type=3",user.userid]]
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
    
    
    //标签下边的灰色横线
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.segment.frame)+43, Main_Screen_Width, 0.5)];
    view.backgroundColor = RGB(232, 232, 232);
    [self.view addSubview: view];
    
    //添加加号➕按钮
    UIButton *addMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-segViewHigh, CGRectGetMinY(self.segment.frame), segViewHigh, segViewHigh)];
    [addMenuBtn setImage:GetImage(@"Group 2") forState:UIControlStateNormal];
    [addMenuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addMenuBtn addTarget:self action:@selector(addMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addMenuBtn];
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
    self.shuView.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}

//点击提问按钮
-(void)tiwenBtnClick{
    QuestionsViewController *publicPage = [[QuestionsViewController alloc] init];
    [self.navigationController pushViewController:publicPage animated:YES];
    self.searchBtn.hidden = YES;
    self.tiwenBtn.hidden = YES;
    self.shuView.hidden = YES;
    //先隐藏标签视图
    [self.newsMenu dismissNewsMenu];
}


-(QATableVIewController *)tablecontroller:(NSString *)lable{
    QATableVIewController *vc = [[QATableVIewController alloc] init];
    vc.choosetype = QAlabelType;
    vc.lablemodel = [[lableModel alloc] init];
//    vc.lablemodel = lable;
    vc.lableName = lable;
    [vc getQusetionWithLabel];
    vc.delegate = self;

    return vc;
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
    self.newsMenu.pageOrqa = @"3";
    
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
    [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"get_labels_rand?limit=10&type=3"]
                                                 parameters:nil
                                                    success:^(id obj) {
                                                        
                                                        NSMutableArray *labArr = [[NSMutableArray alloc] init];
                                                        NSArray *arr = obj[@"data"];
                                                        NSDictionary *dict = @{
                                                                               @"label_name":@""
                                                                               };
                                                        for (dict in arr) {
                                                            [labArr addObject:dict[@"label_name"]];
                                                        }
                                                        sheetMenu.recommendSubjectArray = labArr;
                                                        [weakSelf.newsMenu layoutSubviews];


                                                    }
                                                       fail:^(NSError *error) {
                                                           
                                                       }];
    [weakSelf.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
        //        cofig.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    }];
    
    //回调编辑好的兴趣标签
    [weakSelf.newsMenu updataItmeArray:^(NSMutableArray *itemArray) {
        //给segeview标签数组赋值
        
        weakSelf.segment.reloadTitleArr = itemArray;
        [weakSelf.segment reloadData];
        self.labelnameArr = itemArray;
        
        //自定义标签
        UserInfoModel *user = [UserInfoModel shareUserModel];
        [user loadUserInfoFromSanbox];

        NSString *string = [itemArray componentsJoinedByString:@","];
        NSDictionary *dict = @{
                               @"userId":user.userid,
                               @"labelname":string,
                               @"type":@"3",
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

#pragma mark - 搜索控制器Delegate -
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
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
    
//    if ([model.type isEqualToString:@"1"]) {
//        PageDetailViewController *vc = [[PageDetailViewController alloc] init];
//        vc.articleid = model.type_id;
//        [searchViewController.navigationController pushViewController:vc animated:YES];
//    }
    
    if ([model.type isEqualToString:@"2"]) {
        AnswerViewController *vc = [[AnswerViewController alloc] init];
        QusetionModel *qmodel = [[QusetionModel alloc] init];
        qmodel.question_id = model.type_id;
        vc.questionModel = qmodel;
        vc.choosetype = questionType;
        [searchViewController.navigationController pushViewController:vc animated:YES];
    }
}


- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    searchResultModel *model = self.searchArr[indexPath.row];
    static NSString * reuseID = @"cell";
    QATableVIewCell *cell = [searchSuggestionView dequeueReusableCellWithIdentifier:reuseID];
    cell = [[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil][0];
    cell.mainTitle.text = model.title;
//    cell.detailPage.text = model.content;
    
    return cell;
}


- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section{
    
    return self.searchArr.count;
}


- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView{
    return 1;
}


- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

#pragma mark - DetailTableViewController代理方法 -
//监听table点击方法传来索引
-(void)QAtableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath QusetionModel:(QusetionModel *)Qusetionmodel{
    
    AnswerViewController *pageDetail = [[AnswerViewController alloc] init];
    pageDetail.questionModel = [[QusetionModel alloc] init];
    pageDetail.questionModel = Qusetionmodel;
    pageDetail.choosetype = questionType;
    [self.navigationController pushViewController:pageDetail animated:YES];
    self.searchBtn.hidden = YES;
    self.tiwenBtn.hidden = YES;
    self.shuView.hidden = YES;
    
}

-(void)clickHeadImageJumpToPersonDetailPage:(NSInteger)indexPath{
    
//    //推出个人展示页
//    PersonViewController *vc = [[PersonViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    self.searchBtn.hidden = YES;
//    self.tiwenBtn.hidden = YES;
//    self.shuView.hidden = YES;
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
