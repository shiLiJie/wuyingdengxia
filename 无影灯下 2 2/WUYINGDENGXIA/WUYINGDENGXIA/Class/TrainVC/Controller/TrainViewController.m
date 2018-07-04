//
//  TrainViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "TrainViewController.h"
#import "MDMultipleSegmentView.h"
#import "MDFlipCollectionView.h"
#import "MeetingNewViewController.h"
#import "PastViewController.h"
#import "MeetDetailViewController.h"
#import "PassMeetViewController.h"
#import "PYSearch.h"
#import "SearchResultVcViewController.h"
#import "meetingModel.h"
#import "huiguModel.h"

#import "hotKeyModel.h"
#import "searchResultModel.h"
#import "PageDetailViewController.h"
#import "AnswerViewController.h"
#import "DetailTableViewCell.h"
#import "MeetingNewCell.h"

#define segViewHigh     44

@interface TrainViewController ()<MDMultipleSegmentViewDeletegate,
                                MDFlipCollectionViewDelegate,
                                MeetNewDelegate,
                                PassDelegate,
                                PYSearchViewControllerDelegate,
                                PYSearchViewControllerDataSource>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

@property (nonatomic, strong) UIButton *searchBtn;
//获取搜索模型数组
@property (nonatomic, strong) NSMutableArray *searchArr;

@end

@implementation TrainViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSegView];
    
    self.searchArr = [[NSMutableArray alloc] init];
}
#pragma mark - UI -
//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    if (kDevice_Is_iPhoneX) {
        _segView.frame = CGRectMake(0,45, Main_Screen_Width, segViewHigh);
    }else{
        _segView.frame = CGRectMake(0,20, Main_Screen_Width, segViewHigh);
    }
    _segView.items = @[@"会议资讯",@"往期回顾"];
    _segView.titleFont = BOLDSYSTEMFONT(18);
    [self.view addSubview:_segView];
    
    self.searchBtn = [[UIButton alloc] init];

    self.searchBtn.frame = CGRectMake(30, CGRectGetMaxY(_segView.frame)+6, kScreen_Width-60, 33);
    [_searchBtn setBackgroundColor:RGB(245, 245, 245)];
    [_searchBtn setImage:GetImage(@"Fill 1") forState:UIControlStateNormal];
    [_searchBtn setTitle:@" 输入想要搜索的关键词" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = SYSTEMFONT(12);
    [_searchBtn setTitleColor:RGB(181, 181, 181) forState:UIControlStateNormal];
    _searchBtn.layer.cornerRadius = 16.5;//半径大小
    _searchBtn.layer.masksToBounds = YES;//是否切割
    [self.searchBtn addTarget:self action:@selector(gotoSearchKey) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchBtn];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller1]
                     ];
    
    if (kDevice_Is_iPhoneX) {
        _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              CGRectGetMaxY(self.searchBtn.frame)+5,
                                                                              Main_Screen_Width,
                                                                              Main_Screen_Height - 64 - self.searchBtn.frame.size.height-5)
                                                         withArray:arr];
    }else
    {
        _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              CGRectGetMaxY(self.searchBtn.frame)+5,
                                                                              Main_Screen_Width,
                                                                              Main_Screen_Height - 49 - self.searchBtn.frame.size.height-5)
                                                         withArray:arr];
    }
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

#pragma mark - 私有action -
-(MeetingNewViewController *)tablecontroller{
    MeetingNewViewController *vc = [[MeetingNewViewController alloc] init];
    vc.delegate = self;
    
    return vc;
}
-(PastViewController *)tablecontroller1{
    PastViewController *vc = [[PastViewController alloc] init];
    vc.delegate = self;
    
    return vc;
}
//搜索按钮点击
-(void)gotoSearchKey{
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
                                                           
                                                           [weakSelf searchWithKey:searchText searchViewController:searchViewController];
                                                           
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
-(void)searchWithKey:(NSString *)key searchViewController:(PYSearchViewController *)searchViewController{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
//    NSString  *url = [[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"searchall?user_id=%@&key=%@",user.userid,key]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//    [[HttpRequest shardWebUtil] getNetworkRequestURLString:url
//                                                parameters:nil
//                                                   success:^(id obj) {
//
//                                                       if ([obj[@"code"] isEqualToString:SucceedCoder]) {
//                                                           NSArray *arr = obj[@"data"];
//                                                           NSMutableArray *arrayM = [NSMutableArray array];
//                                                           for (int i = 0; i < arr.count; i ++) {
//                                                               NSDictionary *dict = arr[i];
//                                                               [arrayM addObject:[searchResultModel searchResultWithDict:dict]];
//
//                                                           }
//                                                           self.searchArr= arrayM;
//
//                                                       }else{
//
//                                                       }
//
//                                                   }
//                                                      fail:^(NSError *error) {
//                                                      }];
    
    NSString  *url = [[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_search_meeting?key=%@",key]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:url
                                                parameters:nil
                                                   success:^(id obj) {
                                                       
                                                       if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                           NSArray *arr = obj[@"data"];
                                                           NSMutableArray *arrayM = [NSMutableArray array];
                                                           for (int i = 0; i < arr.count; i ++) {
                                                               NSDictionary *dict = arr[i];
                                                               [arrayM addObject:[meetingModel meetWithDict:dict]];
                                                               
                                                           }
                                                           self.searchArr = arrayM;
                                                           searchViewController.searchSuggestions = self.searchArr;
                                                           
                                                       }else{
                                                           [self.searchArr removeAllObjects];
                                                           searchViewController.searchSuggestions = self.searchArr;
                                                       }
                                                       
                                                   }
                                                      fail:^(NSError *error) {
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
            
            [self searchWithKey:searchText searchViewController:searchViewController];
            
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
    if ([model.type isEqualToString:@"3"]) {
        AnswerViewController *vc = [[AnswerViewController alloc] init];
        QusetionModel *qmodel = [[QusetionModel alloc] init];
        qmodel.question_id = model.type_id;
        vc.questionModel = qmodel;
        vc.choosetype = questionType;
        [searchViewController.navigationController pushViewController:vc animated:YES];
    }
    
    
}


- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MeetingNewCell";
    MeetingNewCell * cell = [searchSuggestionView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeetingNewCell" owner:nil options:nil] firstObject];
        cell.baomingBtn.layer.cornerRadius = CGRectGetHeight(cell.baomingBtn.frame)/2;//2.0是圆角的弧度，根据需求自己更改
        cell.baomingBtn.layer.masksToBounds = YES;
        cell.baomingBtn.layer.borderColor = RGB(245, 166, 35).CGColor;//设置边框颜色
        [cell.baomingBtn setTitleColor:RGB(245, 166, 35) forState:UIControlStateNormal];
        cell.baomingBtn.layer.borderWidth = 0.5f;//设置边框颜色
        
        meetingModel *model = [[meetingModel alloc] init];
        model = self.searchArr[indexPath.row];
        [cell.meetImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.meeting_image]] placeholderImage:GetImage(@"")];
        cell.meetName.text = model.meet_title;
        cell.meetTime.text = model.begin_time;
        if ([model.isfinish isEqualToString:@"0"]) {
            cell.baomingBtn.layer.borderColor = RGB(198, 198, 198).CGColor;//设置边框颜色
            [cell.baomingBtn setTitle:@"未开始" forState:UIControlStateNormal];
            [cell.baomingBtn setTitleColor:RGB(198, 198, 198) forState:UIControlStateNormal];
        }
        //        if ([model.isfinish isEqualToString:@"1"]) {
        //            cell.baomingBtn.layer.borderColor = RGB(198, 198, 198).CGColor;//设置边框颜色
        //            [cell.baomingBtn setTitle:@"未开始" forState:UIControlStateNormal];
        //            [cell.baomingBtn setTitleColor:RGB(198, 198, 198) forState:UIControlStateNormal];
        //        }
        if ([model.isfinish isEqualToString:@"2"]) {
            cell.baomingBtn.layer.borderColor = RGB(198, 198, 198).CGColor;//设置边框颜色
            [cell.baomingBtn setTitle:@"已结束" forState:UIControlStateNormal];
            [cell.baomingBtn setTitleColor:RGB(198, 198, 198) forState:UIControlStateNormal];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section{
    
    return self.searchArr.count;
}


- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView{
    return 1;
}


- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreen_Height * 0.3;
}

#pragma mark - 会议资讯和往期回顾点击代理方法 -
-(void)meetTbleviewDidSelectPageWithIndex:(NSIndexPath *)indexPath meetingModel:(meetingModel *)meetmodel{
    
    MeetDetailViewController *vc = [[MeetDetailViewController alloc] init];
    vc.meetId = meetmodel.meet_id;
    vc.weikaishiOrBaomingzhong = meetmodel.isfinish;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)passTableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath huiguModel:(huiguModel *)huiyiModel{
 
    PassMeetViewController *vc = [[PassMeetViewController alloc] init];
    vc.huiguModel = [[huiguModel alloc] init];
    vc.huiguModel = huiyiModel;
    [vc getVideoList];
    [self.navigationController pushViewController:vc animated:YES];
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
