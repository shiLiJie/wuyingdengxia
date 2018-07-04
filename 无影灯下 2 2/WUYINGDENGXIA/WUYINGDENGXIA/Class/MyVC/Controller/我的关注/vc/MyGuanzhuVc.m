//
//  MyGuanzhuVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyGuanzhuVc.h"
#import "MyGuanzhuCell.h"
#import "PersonViewController.h"
#import "MyGuanzhuModel.h"

@interface MyGuanzhuVc ()

@property (nonatomic, strong) NSArray *guanzhuArr;

@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation MyGuanzhuVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.guanzhuArr = [[NSArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height)];
    self.imageview.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageview];
    
}
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
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        //获取我的关注列表
        [self getGuanzhuList];
    }
}

//获取我的关注列表
-(void)getGuanzhuList{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myfollow?userid=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSArray *arr = obj[@"data"];
                                                       NSMutableArray *arrayM = [NSMutableArray array];
                                                       for (int i = 0; i < arr.count; i ++) {
                                                           NSDictionary *dict = arr[i];
                                                           [arrayM addObject:[MyGuanzhuModel guanzhuWithDict:dict]];
                                                           
                                                       }
                                                       weakSelf.guanzhuArr= arrayM;
                                                       [weakSelf.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"我的关注"];
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
    if (self.guanzhuArr.count == 0) {
        
        self.imageview.image = GetImage(@"wuguanzhu");
        self.imageview.hidden = NO;
        return 0;
    }else{
        self.imageview.hidden = YES;
        return self.guanzhuArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 69;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"MyGuanzhuCell";
    MyGuanzhuCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGuanzhuCell" owner:nil options:nil] firstObject];
    }
    cell.choosetype = guanzhuType;
    [cell setUIWithchooseType:cell.choosetype];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MyGuanzhuModel *model = [[MyGuanzhuModel alloc] init];
    model = self.guanzhuArr[indexPath.row];
    if (!kStringIsEmpty(model.followname)) {
        cell.userName.text = [NSString stringWithFormat:@"%@",model.followname];
    }
    if (!kStringIsEmpty(model.user_post)) {
        cell.zhiwuLab.text = [NSString stringWithFormat:@"职务:%@",model.user_post];
    }
    if (!kStringIsEmpty(model.fans_num)) {
        cell.fensiLab.text = [NSString stringWithFormat:@"粉丝  %@",model.fans_num];
    }
    if (!kStringIsEmpty(model.followhead)) {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.followhead] placeholderImage:GetImage(@"tx")];
        
    }
    if (!kStringIsEmpty(model.isfinish_cert)) {
        if ([model.isfinish_cert isEqualToString:@"1"]) {
            cell.vipImage.image = GetImage(@"v");
        }else{
            cell.vipImage.image = GetImage(@"v1");
        }
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击跳转到个人信息页,传入个人信息id
    PersonViewController *vc = [[PersonViewController alloc] init];
    MyGuanzhuModel *model = [[MyGuanzhuModel alloc] init];
    model = self.guanzhuArr[indexPath.row];
    vc.userid = model.followid;
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
