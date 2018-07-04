//
//  MyFensiVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyFensiVc.h"
#import "MyGuanzhuCell.h"
#import "PersonViewController.h"
#import "MyfensiModel.h"

@interface MyFensiVc ()

//我的粉丝数组
@property (nonatomic, strong) NSArray *fensiArr;
@property (nonatomic, strong) UIImageView *imageview;



@end

@implementation MyFensiVc

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.fensiArr = [[NSArray alloc] init];

    
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
        //调取粉丝
        [self getMyfensiInfo];
    }
}


/**
 获取我的粉丝
 */
-(void)getMyfensiInfo{
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    __weak typeof(self) weakSelf = self;
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"get_myfans?userid=%@",user.userid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                           
                                                           NSArray *arr = obj[@"data"];
                                                           NSMutableArray *arrayM = [NSMutableArray array];
                                                           for (int i = 0; i < arr.count; i ++) {
                                                               NSDictionary *dict = arr[i];
                                                               [arrayM addObject:[MyfensiModel MyfensiWithDict:dict]];
                                                               
                                                           }
                                                           weakSelf.fensiArr= arrayM;
                                                           [weakSelf.tableView reloadData];
                                                       }else{
//                                                           [MBProgressHUD showError:obj[@"msg"]];
                                                       }
                                                       
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
    return [self changeTitle:@"我的粉丝"];
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
    if (self.fensiArr.count == 0) {
        
        self.imageview.image = GetImage(@"wufensi");
        self.imageview.hidden = NO;
        return 0;
    }else{
        self.imageview.hidden = YES;
        return self.fensiArr.count;
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
    MyfensiModel *model = self.fensiArr[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.fanshead]] placeholderImage:GetImage(@"tx")];
    cell.userName.text = [NSString stringWithFormat:@"%@",model.fansname];
    cell.fensiLab.text = [NSString stringWithFormat:@"粉丝 %@",model.fansnum];
    if (!kStringIsEmpty(model.isfinish_cert) &&[model.isfinish_cert isEqualToString:@"1"]) {
        cell.vipImage.image = GetImage(@"v");
    }else{
        cell.vipImage.image = GetImage(@"v1");
    }
    if ([[NSString stringWithFormat:@"%@",model.is_follow] isEqualToString:@"1"]) {
        cell.choosetype = guanzhuType;
        [cell setUIWithchooseType:cell.choosetype];
    }else{
        cell.choosetype = weiguanzhuType;
        [cell setUIWithchooseType:cell.choosetype];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonViewController *vc = [[PersonViewController alloc] init];
    MyfensiModel *model = [[MyfensiModel alloc] init];
    model = self.fensiArr[indexPath.row];
    vc.userid = model.fansid;
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
