//
//  MyTiwenVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyTiwenVc.h"
#import "MyTiwenCell.h"
#import "AnswerViewController.h"
#import "QusetionModel.h"
#import "MytiwenModel.h"

@interface MyTiwenVc ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *tiwenArr;;

@property (nonatomic, strong) UIImageView *imageview;

@end

@implementation MyTiwenVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tiwenArr = [[NSArray alloc] init];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;//期望高度
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
    
    //获取提问列表
    [self getUserTiWenList];
}
#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"我的提问"];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

//获取提问列表
-(void)getUserTiWenList{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    __weak typeof(self) weakSelf = self;

    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_question_byuserid?userid=%@",user.userid]] parameters:nil success:^(id obj) {
        NSArray *arr = obj[@"data"];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *dict = arr[i];
            [arrayM addObject:[QusetionModel QusetionWithDict:dict]];
            
        }
        weakSelf.tiwenArr= [[arrayM reverseObjectEnumerator] allObjects];
        
        
        [self.tableView reloadData];
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


#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tiwenArr.count == 0) {
        
        self.imageview.image = GetImage(@"wutiwen");
        self.imageview.hidden = NO;
        return 0;
    }else{
        self.imageview.hidden = YES;
        return self.tiwenArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MyTiwenCell";
    MyTiwenCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTiwenCell" owner:nil options:nil] firstObject];
    }

    QusetionModel *model = [[QusetionModel alloc] init];
    model = self.tiwenArr[indexPath.row];
    if ([model.is_solve isEqualToString:@"0"]) {
        cell.choosetype = waitType;
        [cell setUIWithchooseType:cell.choosetype];
    }
    if ([model.is_solve isEqualToString:@"1"]) {
        cell.choosetype = susscessType;
        [cell setUIWithchooseType:cell.choosetype];
    }
    cell.titleLab.text = model.question_title;
    cell.detailLab.text = model.question_content;
    cell.huidaLab.text = [NSString stringWithFormat:@"已回答 %@",model.answer_num];
    cell.timeLab.text = [self getBeforeTimeWithTime:model.ctime];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController *vc = [[AnswerViewController alloc] init];
    vc.questionModel = [[QusetionModel alloc] init];
    vc.questionModel = self.tiwenArr[indexPath.row];
    vc.choosetype = myquestionType;
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
