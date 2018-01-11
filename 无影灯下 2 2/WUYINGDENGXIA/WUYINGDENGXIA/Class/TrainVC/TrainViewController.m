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
#import "SearchBarEffectController.h"


#define segViewHigh     44

@interface TrainViewController ()<MDMultipleSegmentViewDeletegate,
                                MDFlipCollectionViewDelegate,
                                SearchBarDelegate>
{
    MDMultipleSegmentView *_segView;    //标签视图
    MDFlipCollectionView *_collectView; //标签视图内容
}

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

@implementation TrainViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSegView];
}
#pragma mark - UI -
//添加segview标签控制器
-(void)addSegView{
    
    _segView = [[MDMultipleSegmentView alloc] init];
    _segView.delegate =  self;
    _segView.frame = CGRectMake(0,20, Main_Screen_Width, segViewHigh);
    _segView.items = @[@"会议资讯",@"往期回顾"];
    _segView.titleFont = [UIFont systemFontOfSize:18];
    [self.view addSubview:_segView];
    
    NSArray *arr = @[
                     [self tablecontroller],
                     [self tablecontroller]
                     ];
    
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(self.searchBtn.frame),
                                                                          Main_Screen_Width,
                                                                          Main_Screen_Height - 75 - self.searchBtn.frame.size.height)
                                                     withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}

#pragma mark - 私有action -
-(MeetingNewViewController *)tablecontroller{
    MeetingNewViewController *vc = [[MeetingNewViewController alloc] init];
//    vc.delegate = self;
    
    return vc;
}
- (IBAction)gotoSearchKey:(UIButton *)sender {
    
    SearchBarEffectController * searchView = [[SearchBarEffectController alloc]init];
    searchView.delegate = self;
    
    [searchView show];
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
