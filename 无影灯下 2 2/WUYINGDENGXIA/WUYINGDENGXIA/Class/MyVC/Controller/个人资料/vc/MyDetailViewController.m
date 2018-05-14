//
//  MyDetailViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyDetailViewController.h"
#import "BRPickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
#import "ziliaoCell.h"
#import "RenzhengOneVc.h"
#import "ImagePicker.h"

@interface MyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    ImagePicker *imagePicker;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *titleArr1;//标题数组
@property (nonatomic, strong) NSArray *titleArr2;
@property (nonatomic, strong) NSArray *titleArr3;

@property (nonatomic, copy) NSString *phoneStr;//手机号
@property (nonatomic, copy) NSString *nichengStr;//昵称
@property (nonatomic, copy) NSString *birthStr;//生日字符串
@property (nonatomic, copy) NSString *sexStr;//性别字符串
@property (nonatomic, copy) NSString *cityStr;//城市字符串
@property (nonatomic, copy) NSString *isFinishCer;//是否认证
@property (nonatomic, copy) NSString *headUrl;//是否认证

@property (nonatomic, copy) NSString *yiyuan;//医院
@property (nonatomic, copy) NSString *keshi;//科室
@property (nonatomic, copy) NSString *shenfen;//身份
@property (nonatomic, copy) NSString *zhiwei;//职务



@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    if (user.loginStatus) {
        self.phoneStr = user.phoneNum;
        self.nichengStr = user.userName;
        self.birthStr = user.userStschool;
        self.sexStr = user.usersex;
        self.cityStr = user.usercity;
        self.isFinishCer = user.isfinishCer;
        self.headUrl = user.headimg;
        
        self.yiyuan = user.userHospital;
        self.keshi = user.userOffice;
        self.shenfen = user.userPosition;
        self.zhiwei = user.userPost;
    }

    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.cityStr = @"";
//    self.birthStr = @"";
//    self.sexStr = @"";
    self.titleArr1 = @[@"手机号",@"昵称"];
    self.titleArr2 = @[@"性别",@"出生年月",@"城市"];
    self.titleArr3= @[@"医院",@"科室",@"身份",@"职位"];
    
    //初始化
    imagePicker = [ImagePicker sharedManager];
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"个人资料"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else if (section == 1) {
        return 0;
    }else if (section == 2) {
        return 0;
    }else{
        return 13;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 3;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * pageID = @"ziliaoCell";
    
    __weak ziliaoCell *cell=[tableView dequeueReusableCellWithIdentifier:pageID];
    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.section == 0) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ziliaoCell" owner:nil options:nil][2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.isFinishCer isEqualToString:@"0"]) {
            [cell.renzhengBtn setTitle:@"已认证" forState:UIControlStateNormal];
        }
        //点击认证按钮
        cell.renzhengBlcok = ^{
            
            RenzhengOneVc *vc = [[RenzhengOneVc alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.headUrl] forState:UIControlStateNormal placeholderImage:GetImage(@"tx")];
        //点击更换头像
        cell.touxiangBlcok = ^{
            
            //设置主要参数
            [imagePicker dwSetPresentDelegateVC:weakSelf SheetShowInView:weakSelf.view InfoDictionaryKeys:(long)nil];
            //回调
            [imagePicker dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
                
            } pickerImagePic:^(UIImage *pickerImagePic) {
                
                [cell.headBtn setImage:pickerImagePic forState:UIControlStateNormal];
 
            }];
        };
    }
    
    if (indexPath.section == 1) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ziliaoCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = self.titleArr1[indexPath.row];
        
        if (indexPath.row == 0) {
            cell.textfield.tag = indexPath.row;
            cell.textfield.text = weakSelf.phoneStr;
            cell.ziliaoCellBlcok = ^(NSString *text, NSInteger tag) {
                if (tag == indexPath.row) {
                    weakSelf.phoneStr = text;
                }
            };
        }
        if (indexPath.row == 1) {
            cell.textfield.tag = indexPath.row;
            cell.textfield.text = weakSelf.nichengStr;
            cell.ziliaoCellBlcok = ^(NSString *text, NSInteger tag) {
                if (tag == indexPath.row) {
                    weakSelf.nichengStr = text;
                }
            };
        }
    }
    
    if (indexPath.section == 2){
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"ziliaoCell" owner:nil options:nil][1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titlelab.text = self.titleArr2[indexPath.row];

        if (indexPath.row == 0) {
            //性别
            if (!kStringIsEmpty(self.sexStr)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.sexStr;
        }
        if (indexPath.row == 1) {
            //生日
            if (!kStringIsEmpty(self.birthStr)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.birthStr;
        }
        if (indexPath.row == 2) {
            //城市
            if (!kStringIsEmpty(self.cityStr)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.cityStr;
        }
    }
    
    if (indexPath.section == 3) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ziliaoCell" owner:nil options:nil][1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titlelab.text = self.titleArr3[indexPath.row];
        cell.jiantou.hidden = YES;
        if (indexPath.row == 0) {
            
            if (!kStringIsEmpty(self.yiyuan)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.yiyuan;
        }
        if (indexPath.row == 1) {
            //
            if (!kStringIsEmpty(self.keshi)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.keshi;
        }
        if (indexPath.row == 2) {
            //
            if (!kStringIsEmpty(self.shenfen)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.shenfen;
        }
        if (indexPath.row == 3) {
            //
            if (!kStringIsEmpty(self.zhiwei)) {
                cell.jiantou.hidden = YES;
            }
            cell.detailLab.text = self.zhiwei;
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            //性别
            NSArray *arr = @[@"男",@"女"];
            [BRStringPickerView showStringPickerWithTitle:@"性别" dataSource:arr defaultSelValue:@"男" resultBlock:^(id selectValue) {
                weakSelf.sexStr = selectValue;
                //修改信息
                UserInfoModel *user = [UserInfoModel shareUserModel];
                [user loadUserInfoFromSanbox];
                
                NSDictionary *dict = @{
                                       @"userid" : user.userid,
//                                       @"realName" : self.nameField,
                                       //                           @"useremail":user.userEmail,
                                       //                           @"usercity":user.usercity,
                                       //                           @"useridcard":user.userIdcard,
                                       //                           @"username":user.userIdcard,
                                                                  @"usersex":selectValue,
//                                       @"userhospital":self.yiyuanField,
//                                       @"useroffice":self.keshiField,
                                       //                           @"usertitle":user.userTitle,
//                                       @"userpost":self.zhiwuField,
                                       //                           @"userunit":user.userUnit,
//                                       @"userposition":self.shenfenField,
                                       //                           @"userschool":user.userSchool,
                                       //                           @"usermajor":user.userMajor,
                                       //                           @"userdegree":user.userDegree,
                                       //                           @"userstschool":user.userStschool,
                                       //                           @"head_img":user.headimg,
                                       //                           @"user_loginway":user.userLoginway
                                       };
                
                [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_change_myinfo"]
                                                             parameters:dict
                                                                success:^(id obj) {
                                                                    
                                                                    if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                        user.usersex = selectValue;
                                                                        [user saveUserInfoToSanbox];
                                                                        [MBProgressHUD showSuccess:obj[@"msg"]];
                                                                    }else{
                                                                        [MBProgressHUD showError:obj[@"msg"]];
                                                                    }
                                                                } fail:^(NSError *error) {
                                                                    
                                                                }];
                [weakSelf.tableview reloadData];
            }];
        }
        if (indexPath.row == 1) {
            //生日
            [BRDatePickerView showDatePickerWithTitle:@"入学年份" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
                
                weakSelf.birthStr = selectValue;
                //修改信息
                UserInfoModel *user = [UserInfoModel shareUserModel];
                [user loadUserInfoFromSanbox];
                
                NSDictionary *dict = @{
                                       @"userid" : user.userid,
                                       @"userschool":selectValue,

                                       };
                
                [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_change_myinfo"]
                                                             parameters:dict
                                                                success:^(id obj) {
                                                                    
                                                                    if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                        user.userStschool = selectValue;
                                                                        [user saveUserInfoToSanbox];
                                                                        [MBProgressHUD showSuccess:obj[@"msg"]];
                                                                    }else{
                                                                        [MBProgressHUD showError:obj[@"msg"]];
                                                                    }
                                                                } fail:^(NSError *error) {
                                                                    
                                                                }];
                [weakSelf.tableview reloadData];
            }];
        }
        if (indexPath.row == 2) {
            //城市
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@0, @0, @0] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {

//                weakSelf.cityStr = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
                weakSelf.cityStr = selectAddressArr[1];
                //修改信息
                UserInfoModel *user = [UserInfoModel shareUserModel];
                [user loadUserInfoFromSanbox];
                
                NSDictionary *dict = @{
                                       @"userid" : user.userid,
                                       @"usercity":selectAddressArr[1],
                                       
                                       };
                
                [[HttpRequest shardWebUtil] postNetworkRequestURLString:[BaseUrl stringByAppendingString:@"post_change_myinfo"]
                                                             parameters:dict
                                                                success:^(id obj) {
                                                                    
                                                                    if ([obj[@"code"] isEqualToString:SucceedCoder]) {
                                                                        user.usercity = selectAddressArr[1];
                                                                        [user saveUserInfoToSanbox];
                                                                        [MBProgressHUD showSuccess:obj[@"msg"]];
                                                                    }else{
                                                                        [MBProgressHUD showError:obj[@"msg"]];
                                                                    }
                                                                } fail:^(NSError *error) {
                                                                    
                                                                }];
                [weakSelf.tableview reloadData];
            }];
        }
    }
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
