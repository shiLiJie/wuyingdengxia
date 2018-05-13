//
//  SettingVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "SettingVc.h"
#import "SettingCell.h"
#import "RenzhengOneVc.h"
#import "MyDetailViewController.h"

@interface SettingVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *cacheSize;//缓存大小

@end

@implementation SettingVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取缓存大小
    self.cacheSize = [NSString stringWithFormat:@"%.1f",[self readCacheSize]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"设置"];
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
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
} 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 10;
            break;
        case 2:
            return 10;
            break;
        case 3:
            return 77;
            break;
            
        default:
            break;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else
    if (section == 1) {
        return 1;
    }else
    if (section == 2) {
        return 2;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 73;
    }
    if (indexPath.section == 3) {
        return 44;
    }
    return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoModel *user = [UserInfoModel shareUserModel];
    [user loadUserInfoFromSanbox];
    
    static NSString * reuseID = @"SettingCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil] firstObject];
                if (user.loginStatus) {
                    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:user.headimg] placeholderImage:GetImage(@"tx")];
                    cell.userName.text = user.userName;
                }
                
                
            }
        }else{
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil][1];
            }
            if (user.loginStatus) {
                //身份认证状态
                if ([user.isfinishCer isEqualToString:@"0"]) {
                    cell.renzhengLab.text = @"已认证";
                }else{
                    cell.renzhengLab.text = @"未认证";
                }
            }
            
        }
    }
    if (indexPath.section == 1) {
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil][2];
        }
        //清除缓存
        cell.huancunLab.text = [NSString stringWithFormat:@"%@M",self.cacheSize];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil][3];
            }
        }else{
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil][4];
            }
        }
    }
    if (indexPath.section == 3) {
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil][5];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //个人信息
            MyDetailViewController *vc = [[MyDetailViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //身份认证
            RenzhengOneVc *vc = [[RenzhengOneVc alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        //清除缓存
        [self alterController];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //关于我们
        }else{
            //软件评分
        }
    }
    if (indexPath.section == 3) {
        //退出登录
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"退出登录"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //响应事件
                                                                  UserInfoModel *user = [UserInfoModel shareUserModel];
                                                                  [user loadUserInfoFromSanbox];
                                                                  user.userid = @"0";
                                                                  user.loginStatus = NO;
                                                                  
                                                                  
                                                                  user.userName = @"";
                                                                  user.passWord = @"";
                                                                  user.certid = @"";
                                                                  user.ctime = @"";
                                                                  user.fansnum = @"";
                                                                  user.headimg = @"";
                                                                  user.isV = @"";
                                                                  user.isadmin = @"";
                                                                  user.isfinishCer = @"";
                                                                  user.ishead = @"";
                                                                  user.isphoneverify = @"";
                                                                  user.last_login_time = @"";
                                                                  user.phoneNum = @"";
                                                                  user.supportnum = @"";
                                                                  user.userDegree = @"";
                                                                  user.userEmail = @"";
                                                                  user.userHospital = @"";
                                                                  user.userIdcard = @"";
                                                                  user.userLoginway = @"";
                                                                  user.userMajor = @"";
                                                                  user.userOffice = @"";
                                                                  user.userPosition = @"";
                                                                  user.userReal_name = @"";
                                                                  user.userSchool = @"";
                                                                  user.userStschool = @"";
                                                                  user.userTitle = @"";
                                                                  user.userUnit = @"";
                                                                  user.user_token = @"";
                                                                  user.useravatar_id = @"";
                                                                  user.usercity = @"";
                                                                  user.usersex = @"";
                                                                  user.usertoken = @"";
                                                                  user.moon_cash = @"";
                                                                  
                                                                  [user saveUserInfoToSanbox];
                                                                  [self.navigationController popViewControllerAnimated:YES];
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - 清理缓存 -
//1. 获取缓存文件的大小
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [self folderSizeAtPath :cachePath];
}

// 遍历文件夹获得文件夹大小，返回多少 M
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}

// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

//清理缓存
- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];

    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    //读取缓存大小
    float cacheSize = [self readCacheSize];
    self.cacheSize = [NSString stringWithFormat:@"%.1f",cacheSize];
}
//弹出清理缓存框
-(void)alterController{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"清除缓存"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              [self clearFile];
                                                              [self.tableView reloadData];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
