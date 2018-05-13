//
//  XuyuanJiluVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XuyuanJiluVc.h"
#import "XuyuanJiluCell.h"
#import "XuyuanDetailVc.h"
#import "xuyuanModel.h"

@interface XuyuanJiluVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;//许愿记录列表

@property (nonatomic, strong) NSArray *xuyuanArr;


@end

@implementation XuyuanJiluVc

-(void)viewWillAppear:(BOOL)animated{
    //获取许愿记录
    [self getxuyuanInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.xuyuanArr = [[NSArray alloc] init];
    

    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"许愿记录"];
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

//获取许愿记录
-(void)getxuyuanInfo{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myalldesire?user_id=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[xuyuanModel xuyuanWithDict:dict]];
                                                           
                                                       }
                                                       self.xuyuanArr= arrayM;
                                                       [self.tableview reloadData];
    }
                                                      fail:^(NSError *error) {
        
    }];
}

#pragma mark - tableviewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.xuyuanArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"XuyuanJiluCell";
    XuyuanJiluCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XuyuanJiluCell" owner:nil options:nil] firstObject];
    }
    //设置背景色,切圆角,点击不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    xuyuanModel *model = [[xuyuanModel alloc] init];
    model = self.xuyuanArr[indexPath.row];
    cell.titleLab.text = model.wish_content;
    cell.timeLab.text = model.ctime;
    if (!kStringIsEmpty(model.moon_cash)) {
        cell.jiageLab.text = model.moon_cash;
    }
    if ([model.status isEqualToString:@"1"]) {
        cell.choosetype = susscessType;
        [cell setUIWithchooseType:susscessType];
    }else{
        cell.choosetype = waitType;
        [cell setUIWithchooseType:waitType];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XuyuanDetailVc *vc = [[XuyuanDetailVc alloc] init];
    xuyuanModel *model = [[xuyuanModel alloc] init];
    model = self.xuyuanArr[indexPath.row];
//    vc.xuyuan = [[xuyuanModel alloc] init];
//    vc.xuyuan = model;
    
    vc.wishid = model.wish_id;
    vc.detail = model.wish_content;
    vc.mooncash = model.moon_cash;
    vc.ctime = model.ctime;
    
    
    
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
