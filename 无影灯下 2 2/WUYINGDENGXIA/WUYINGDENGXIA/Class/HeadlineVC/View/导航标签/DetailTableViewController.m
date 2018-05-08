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



@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageArr = [[NSArray alloc] init];
    self.userArr = [[NSArray alloc] init];
    
    //获取标签下的文章列表
    [self getLablePage];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//获取标签下的文章列表
-(void)getLablePage{
    
    __weak typeof(self) weakSelf = self;
    NSLog(@"%@",self.lable);
    NSString  *url = [[NSString stringWithFormat:@"get_article_bylabel?label=%@&sortby=1",self.lable] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
    
    return self.pageArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    
    
    if (self.cell == nil) {
    
        self.cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil] firstObject];
    }
    
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
        [self.cell.headImage setImage:GetImage(page.headimg) forState:UIControlStateNormal];
    }
    
//    [self.cell.headImage.imageView sd_setImageWithURL:[NSURL URLWithString:page.headimg] placeholderImage:GetImage(@"tx")];
//    [self.cell.headImage setImage:GetImage(@"tx") forState:UIControlStateNormal];
    
//    userModel *user = self.userArr[indexPath.row];
//    if (![user.userReal_name  isKindOfClass:[NSNull class]]) {
//        self.cell.userName.text = user.userReal_name;
//    }
//    if (![user.headimg  isKindOfClass:[NSNull class]]) {
//        [self.cell.headImage.imageView sd_setImageWithURL:[NSURL URLWithString:user.headimg] placeholderImage:GetImage(@"tx")];
//    }else{
//        [self.cell.headImage setImage:GetImage(@"tx") forState:UIControlStateNormal];
//    }
    
    
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 160, 0);
    
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
-(void)pushPublishPersonVc{
    if ([self.delegate respondsToSelector:@selector(clickUserNamePushPublishVc)]) {
        [self.delegate clickUserNamePushPublishVc];
    }
    
}

@end
