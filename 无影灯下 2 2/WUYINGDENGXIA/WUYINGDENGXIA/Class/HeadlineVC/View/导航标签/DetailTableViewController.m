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


@property (nonatomic, strong) UIImageView *imageview;


@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.userArr = [[NSArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.bounces = NO;
    
    self.tableView.estimatedRowHeight = 300;//估算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
    
    self.imageview.hidden = YES;
    
    if (self.choosetype == labelType) {
        //刷新
        __weak typeof(self) weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
            [weakSelf loadNewData];
        }];
    }
   

//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
//        [weakSelf loadNoreData];
//    }];

}


/**
 请求获取最新的数据
 */
- (void)loadNewData {
    
    __weak typeof(self) weakSelf = self;
    //刷新列表
    weakSelf.imageview.hidden = YES;
    NSString  *url = [[NSString stringWithFormat:@"get_article_bylabel?label=%@&sortby=1",weakSelf.lableName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
                                                        
                                                        //拿到当前的刷新控件，结束刷新状态
                                                        [weakSelf.tableView.mj_header endRefreshing];
                                                           
                                                    } fail:^(NSError *error) {
                                                           
                                                        //拿到当前的刷新控件，结束刷新状态
                                                        [weakSelf.tableView.mj_header endRefreshing];
                                                           
                                                    }];

}

/**
 请求获取更多的数据
 */
- (void)loadNoreData {
//    NSLog(@"请求获取更多的数据");

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
-(void)getPersonVcPageWithPersonId:(NSString *)userid userName:(NSString *)username userHeadimg:(NSString *)userheadimg{
    __weak typeof(self) weakSelf = self;
    self.imageview.hidden = YES;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myarticle?userid=%@",userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           pageModel *model = [pageModel pageWithDict:dict];
                                                           model.user_name = username;
                                                           model.headimg = userheadimg;
                                                           [arrayM addObject:model];
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

                                                       NSDictionary *dictObj = obj[@"data"];
                                                       NSArray *wenzhangArr = dictObj[@"article"];
                                                       if (IS_NULL_CLASS(wenzhangArr)) {
                                                           return;
                                                       }

                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < wenzhangArr.count; i ++) {
                                                           
                                                           NSDictionary *dict = wenzhangArr[i];
                                                           if (!kStringIsEmpty(dict[@"article_id"])) {
                                                               [arrayM addObject:[pageModel pageWithDict:dict]];
                                                           }
                                                           
                                                       }
                                                       
                                                       weakSelf.pageArr= [[arrayM reverseObjectEnumerator] allObjects];
                                                       if (weakSelf.pageArr.count == 0) {
                                                           weakSelf.imageview.hidden = NO;
                                                           weakSelf.imageview.image = GetImage(@"wushoucang");
                                                       }
                                                       
                                                       [weakSelf.tableView reloadData];
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
}

//获取标签下的文章列表
-(void)setLable:(NSString *)lable{
    self.pageArr = [[NSArray alloc] init];
    __weak typeof(self) weakSelf = self;
    self.imageview.hidden = YES;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.pageArr.count == 0) {

        return 0;
    }else{
        
        return self.pageArr.count;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    self.cell.delegate = self;
    
    pageModel *page = [[pageModel alloc] init];
    page = self.pageArr[indexPath.row];
    


    NSArray *array = [page.article_img_path componentsSeparatedByString:@","]; //字符串按照【分隔成数组
    
    
    
    if (array.count == 1) {
        if (kStringIsEmpty(array[0])) {
            //纯文字
            self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][0];
            self.cell.mainTitle.text = page.article_title;
            self.cell.pageDetail.text = page.article_content;
            self.cell.pinglunLab.text = page.recom_num;
            self.cell.liulanLab.text = page.overlook_num;
            self.cell.dianzanLab.text = page.support_num;
            if (kStringIsEmpty(page.user_name)) {
                self.cell.userName.text = @" ";
            }else{
                self.cell.userName.text = page.user_name;
            }
            
            if (kStringIsEmpty(page.headimg)) {
                [self.cell.headImage setBackgroundImage:GetImage(@"tx") forState:UIControlStateNormal];
            }else{
                [self.cell.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:page.headimg] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];

            }
        }else{
            //一张图
            self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][1];
            [self.cell.image1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:GetImage(@"")];
            self.cell.mainTitle1.text = page.article_title;
//            self.cell.pageDetail1.text = page.article_content;
            self.cell.pinglunLab1.text = page.recom_num;
            self.cell.liulanLab1.text = page.overlook_num;
            self.cell.dianzanLab1.text = page.support_num;
            if (kStringIsEmpty(page.user_name)) {
                self.cell.userName1.text = @" ";
            }else{
                self.cell.userName1.text = page.user_name;
            }
            if (kStringIsEmpty(page.headimg)) {
                
                [self.cell.headImage1 setBackgroundImage:GetImage(@"tx") forState:UIControlStateNormal];
            }else{
                [self.cell.headImage1 sd_setBackgroundImageWithURL:[NSURL URLWithString:page.headimg] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
            }
        }
        
        
        
    }else if (array.count == 2){
        //一张图
        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][1];
//        [self.cell.image1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:GetImage(@"")]
        
        self.cell.mainTitle1.text = page.article_title;
//        self.cell.pageDetail1.text = page.article_content;
        self.cell.pinglunLab1.text = page.recom_num;
        self.cell.liulanLab1.text = page.overlook_num;
        self.cell.dianzanLab1.text = page.support_num;
        if (kStringIsEmpty(page.user_name)) {
            self.cell.userName1.text = @" ";
        }else{
            self.cell.userName1.text = page.user_name;
        }
        if (kStringIsEmpty(page.headimg)) {
            
            [self.cell.headImage1 setBackgroundImage:GetImage(@"tx") forState:UIControlStateNormal];
        }else{
            [self.cell.headImage1 sd_setBackgroundImageWithURL:[NSURL URLWithString:page.headimg] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        }
        
    }else if (array.count >= 3){
        //三张图
        self.cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil][2];
        [self.cell.image31 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:GetImage(@"")];
        [self.cell.image32 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:GetImage(@"")];
        [self.cell.image33 sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:GetImage(@"")];
        
        self.cell.mainTitle3.text = page.article_title;
        self.cell.pageDetail3.text = page.article_content;
        self.cell.pinglunLab3.text = page.recom_num;
        self.cell.liulanLab3.text = page.overlook_num;
        self.cell.dianzanLab3.text = page.support_num;
        if (kStringIsEmpty(page.user_name)) {
            self.cell.userName3.text = @" ";
        }else{
            self.cell.userName3.text = page.user_name;
        }
        if (kStringIsEmpty(page.headimg)) {
            
            [self.cell.headImage3 setBackgroundImage:GetImage(@"tx") forState:UIControlStateNormal];
        }else{
            [self.cell.headImage3 sd_setBackgroundImageWithURL:[NSURL URLWithString:page.headimg] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        }
    }
    //设置内容行间距
    [self.cell setWordSpace];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
