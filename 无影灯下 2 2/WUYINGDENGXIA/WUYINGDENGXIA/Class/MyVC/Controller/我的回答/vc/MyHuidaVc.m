//
//  MyHuidaVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyHuidaVc.h"
#import "MyHuidaCell.h"
#import "AnswerViewController.h"
#import "MyhuidaModel.h"
#import "QusetionModel.h"

@interface MyHuidaVc ()

@property (nonatomic, strong) NSArray *huidaArr;

@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation MyHuidaVc

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.huidaArr = [[NSArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        //获取我的回答接口数据
        [self getMyhuida];
    }
    
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"我的回答"];
}

//获取我的回答接口数据
-(void)getMyhuida{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myanswer?userid=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[MyhuidaModel MyhuidaWithDict:dict]];
                                                           
                                                       }
                                                       weakSelf.huidaArr= [[arrayM reverseObjectEnumerator] allObjects];
                                                       [weakSelf.tableView reloadData];
    }
                                                      fail:^(NSError *error) {
        
    }];
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

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.huidaArr.count == 0) {
        
        self.imageview.image = GetImage(@"wuhuida");
        self.imageview.hidden = NO;
        return 0;
    }else{
        self.imageview.hidden = YES;
        return self.huidaArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MyHuidaCell";
    MyHuidaCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHuidaCell" owner:nil options:nil] firstObject];
    }
    MyhuidaModel *model = self.huidaArr[indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",model.question_title];
    cell.detailLab.text = [NSString stringWithFormat:@"%@",model.question_content];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyhuidaModel *model = self.huidaArr[indexPath.row];
    AnswerViewController *vc = [[AnswerViewController alloc] init];
    vc.questionModel = [[QusetionModel alloc] init];
    vc.questionModel.question_title = [NSString stringWithFormat:@"%@",model.question_title];
    vc.questionModel.question_id = [NSString stringWithFormat:@"%@",model.question_id];
    vc.questionModel.user_id = [NSString stringWithFormat:@"%@",model.user_id];
    vc.choosetype = questionType;
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
