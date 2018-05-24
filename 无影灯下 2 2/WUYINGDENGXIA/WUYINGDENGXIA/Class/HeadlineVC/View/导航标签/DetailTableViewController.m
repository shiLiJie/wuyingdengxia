//
//  ViewController1.m
//  Linkage
//
//  Created by administrator on 2017/9/1.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import "DetailTableViewController.h"
#import "UIColor+Tools.h"
#import "DetailTableViewCell.h"

#import "UserInfoModel.h"

@interface DetailTableViewController ()<UITableViewDataSource,UITableViewDelegate,DetailTableViewCellDelegate>


@property (nonatomic, strong) DetailTableViewCell * cell;

@property (nonatomic, strong) NSArray *pageArr;
@property (nonatomic, strong) NSArray *userArr;

@property(nonatomic, assign) NSInteger countt;


@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countt = 5;
    
    self.userArr = [[NSArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 300;//估算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
//    //刷新
//    __weak typeof(self) weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
//        [weakSelf loadNewData];
//    }];
//
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
//        [weakSelf loadNoreData];
//    }];
    
}


/**
 请求获取最新的数据
 */
- (void)loadNewData {
    NSLog(@"请求获取最新的数据");
    //这里假设2秒之后获取到了最新的数据，刷新tableview，并且结束刷新控件的刷新状态
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新列表
        [weakSelf.tableView reloadData];
        //拿到当前的刷新控件，结束刷新状态
        [weakSelf.tableView.mj_header endRefreshing];

    });
}

/**
 请求获取更多的数据
 */
- (void)loadNoreData {
    NSLog(@"请求获取更多的数据");

    //这里假设2秒之后获取到了更多的数据，刷新tableview，并且结束刷新控件的刷新状态
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新列表
        [weakSelf.tableView reloadData];
        //拿到当前的刷新控件，结束刷新状态
        [weakSelf.tableView.mj_footer endRefreshing];
    });
}



//查看别人主页时吊用此方法,获取文章列表
-(void)getPersonVcPageWithPersonId:(NSString *)userid{
    __weak typeof(self) weakSelf = self;
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myarticle?userid=%@",userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[pageModel pageWithDict:dict]];
                                                       }
                                                       
                                                       weakSelf.pageArr= arrayM;
                                                       [weakSelf.tableView reloadData];
                                                       
                                                       
                                                       
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
}

//我的收藏文章列表
-(void)getMyshoucangPage{
    __weak typeof(self) weakSelf = self;
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_mycollection?userid=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
//                                                       NSLog(@"%@",obj);
                                                       NSDictionary *dictObj = obj[@"data"];
                                                       NSArray *wenzhangArr = dictObj[@"article"];
                                                       if (IS_NULL_CLASS(wenzhangArr)) {
                                                           return;
                                                       }

                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < wenzhangArr.count; i ++) {
                                                           NSDictionary *dict = wenzhangArr[i];
                                                           [arrayM addObject:[pageModel pageWithDict:dict]];
                                                       }
                                                       
                                                       weakSelf.pageArr= arrayM;
                                                       [weakSelf.tableView reloadData];
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
}

//获取标签下的文章列表
-(void)setLable:(NSString *)lable{
    self.pageArr = [[NSArray alloc] init];
    __weak typeof(self) weakSelf = self;
    
    NSString  *url = [[NSString stringWithFormat:@"get_article_bylabel?label=%@&sortby=1",lable] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:url]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[pageModel pageWithDict:dict]];
                                                       }
                                                       
                                                       weakSelf.pageArr= arrayM;
                                                       [weakSelf.tableView reloadData];
                                                       
                                                       
                                                       
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return self.pageArr.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.pageArr.count;
//    return self.countt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    pageModel *page = [[pageModel alloc] init];
    page = self.pageArr[indexPath.section];

//    NSLog(@"%@",page.article_img_path);

    NSArray *array = [page.article_img_path componentsSeparatedByString:@","]; //字符串按照【分隔成数组
    if (array.count == 0) {
        return 200;
    }else{
        return 300;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
//    if (indexPath.row == 0) {
        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][0];
//    }
//
//    if (indexPath.row == 1) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][1];
//    }
//
//    if (indexPath.row == 2) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][2];
//    }
//
//    if (indexPath.row == 3) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][1];
//    }
//    if (indexPath.row == 4) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][2];
//    }
//    if (indexPath.row == 5) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][0];
//    }
//    if (indexPath.row == 6) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][1];
//    }
//    if (indexPath.row == 7) {
//        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][1];
//    }
//
//    self.cell.image1.clipsToBounds = YES;
//    self.cell.image1.contentMode = UIViewContentModeScaleAspectFill;
//    self.cell.image31.clipsToBounds = YES;
//    self.cell.image31.contentMode = UIViewContentModeScaleAspectFill;
//    self.cell.image32.clipsToBounds = YES;
//    self.cell.image32.contentMode = UIViewContentModeScaleAspectFill;
//    self.cell.image33.clipsToBounds = YES;
//    self.cell.image33.contentMode = UIViewContentModeScaleAspectFill;

    self.cell.delegate = self;

    pageModel *page = [[pageModel alloc] init];
    page = self.pageArr[indexPath.row];
    self.cell.mainTitle.text = page.article_title;
    self.cell.pageDetail.text = page.article_content;
    self.cell.pinglunLab.text = page.recom_num;
    self.cell.liulanLab.text = page.overlook_num;
    self.cell.dianzanLab.text = page.support_num;
    if (kStringIsEmpty(page.user_name)) {
        self.cell.userName.text = @"";
    }else{
        self.cell.userName.text = page.user_name;
    }
    if (kStringIsEmpty(page.headimg)) {
        [self.cell.headImage setBackgroundImage:GetImage(@"tx") forState:UIControlStateNormal];
    }else{
        [self.cell.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:page.headimg] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
    }
    //设置按钮索引找到对应的数据
    self.cell.headTag = indexPath.row;



    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 160, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    pageModel *page = [[pageModel alloc] init];
    page = self.pageArr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(tableviewDidSelectPageWithIndex:article_id:user_id:pageModle:)]) {
        [self.delegate tableviewDidSelectPageWithIndex:indexPath article_id:page.article_id user_id:page.user_id pageModle:page];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.DidScrollBlock) {
        self.DidScrollBlock(scrollView.contentOffset.y);
    }
}

#pragma mark - cell点击头像和用户名代理方法 -
-(void)pushPublishPersonVc:(NSInteger)tag{
    if ([self.delegate respondsToSelector:@selector(clickUserNamePushPublishVcWithUserid:)]) {
        
        pageModel *page = [[pageModel alloc] init];
        page = self.pageArr[tag];
        
        [self.delegate clickUserNamePushPublishVcWithUserid:page.user_id];
    }
}

@end
