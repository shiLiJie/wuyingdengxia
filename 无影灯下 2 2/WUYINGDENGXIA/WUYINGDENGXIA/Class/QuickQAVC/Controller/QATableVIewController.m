//
//  QATableVIewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "QATableVIewController.h"
#import "QATableVIewCell.h"


@interface QATableVIewController ()<UITableViewDelegate,UITableViewDataSource,QATableVIewCellDelegate>

@property (nonatomic, strong) QATableVIewCell * cell;

@property (nonatomic, strong) NSArray *qusetionArr;

@property (nonatomic, strong) UIImageView *imageview;

@end

@implementation QATableVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.qusetionArr = [[NSArray alloc] init];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
    
    self.imageview.hidden = YES;
    
}

//获取标签下对应问答
-(void)getQusetionWithLabel{
    self.imageview.hidden = YES;
    NSString  *url = [[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_question_bylabel?label=%@",self.lableName]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [[HttpRequest shardWebUtil] getNetworkRequestURLString:url
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                       
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[QusetionModel QusetionWithDict:dict]];
                                                           
                                                       }
                                                       self.qusetionArr= arrayM;
                                                       [self.tableview reloadData];
    }
                                                      fail:^(NSError *error) {
        
    }];
}

//我的收藏问题列表
-(void)getMyshoucangQusetion{
    __weak typeof(self) weakSelf = self;
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_mycollection?userid=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {

                                                       
                                                       NSDictionary *dictObj = obj[@"data"];
                                                       if (IS_NULL_CLASS(dictObj[@"question"])) {
                                                           return;
                                                       }
                                                       NSArray *wenzhangArr = dictObj[@"question"];
                                                       
                                                       if (IS_NULL_CLASS(wenzhangArr)) {
                                                           return;
                                                       }
                                                       
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < wenzhangArr.count; i ++) {
                                                           NSDictionary *dict = wenzhangArr[i];
                                                           [arrayM addObject:[QusetionModel QusetionWithDict:dict]];
                                                       }
                                                       
                                                       weakSelf.qusetionArr= [[arrayM reverseObjectEnumerator] allObjects];
                                                       if (weakSelf.qusetionArr.count == 0) {
                                                           self.imageview.image = GetImage(@"wushoucangewq");
                                                           self.imageview.hidden = NO;
                                                       }
                                                       [weakSelf.tableview reloadData];
                                                       
                                                       
                                                   } fail:^(NSError *error) {
                                                       
                                                   }];
}

//获取多长时间之前
-(NSString *)getBeforeTimeWithTime:(NSString *)str{
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return result;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.qusetionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"QATableVIewCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    
    if (!self.cell) {
        
        self.cell = [[[NSBundle mainBundle] loadNibNamed:@"QATableVIewCell" owner:nil options:nil] firstObject];
        self.cell.headImage.tag = indexPath.row;
        self.cell.delegate = self;
        QusetionModel *model = self.qusetionArr[indexPath.row];

        self.cell.userName.text = [NSString stringWithFormat:@"%@",model.user_name];
        [self.cell.headImage sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headimg]] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        self.cell.mainTitle.text = [NSString stringWithFormat:@"%@",model.question_title];
        self.cell.detailPage.text = [NSString stringWithFormat:@"%@",model.question_content];
        self.cell.answerNum.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
        self.cell.mooncash.text = [NSString stringWithFormat:@"%@",model.moon_cash];
        self.cell.answerTime.text = [NSString stringWithFormat:@"%@",[self getBeforeTimeWithTime:model.last_answer_time]];
 
    }
    
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(QAtableviewDidSelectPageWithIndex:QusetionModel:)]) {
        QusetionModel *model = [[QusetionModel alloc] init];
        model = self.qusetionArr[indexPath.row];
        
        [self.delegate QAtableviewDidSelectPageWithIndex:indexPath QusetionModel:model];
    }
    
}

#pragma mark - cell代理方法 -
//监听点击table点击的索引
-(void)tableviewDidSelectUserHeadImage:(NSInteger)indexPath{
    //推出个人展示页
    [self.delegate clickHeadImageJumpToPersonDetailPage:indexPath];
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
