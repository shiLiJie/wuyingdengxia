//
//  UserInfoModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "UserInfoModel.h"

#define UserKey         @"userName"
#define LoginStatusKey  @"LoginStatus"
#define PwdKey          @"passWord"

static UserInfoModel * _userInfoModel;

@implementation UserInfoModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (_userInfoModel == nil) {
            _userInfoModel = [super allocWithZone:zone];
        }
    });
    
    return _userInfoModel;
}
+ (instancetype)shareUserModel{
    
    return  [[self alloc] init];
}

/**
 *
 *从沙盒里获取用户数据
 */
-(void)saveUserInfoToSanbox{
    
    
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userName forKey:@"username"];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults setObject:self.passWord forKey:PwdKey];
    
    [defaults setObject:self.phoneNum forKey:@"phoneNum"];
    [defaults setObject:self.userReal_name forKey:@"userReal_name;"];
    [defaults setObject:self.userEmail forKey:@"userEmail"];
    [defaults setObject:self.usercity forKey:@"usercity"];
    [defaults setObject:self.userLoginway forKey:@"userLoginway"];
    [defaults setObject:self.userIdcard forKey:@"userIdcard"];
    [defaults setObject:self.usersex forKey:@"usersex"];
    [defaults setObject:self.userHospital forKey:@"userHospital"];
    [defaults setObject:self.userOffice forKey:@"userOffice"];
    [defaults setObject:self.userTitle forKey:@"userTitle"];
    [defaults setObject:self.userPost forKey:@"userPost"];
    [defaults setObject:self.userUnit forKey:@"userUnit"];
    [defaults setObject:self.userPosition forKey:@"userPosition"];
    [defaults setObject:self.userSchool forKey:@"userSchool"];
    [defaults setObject:self.userMajor forKey:@"userMajor"];
    [defaults setObject:self.userDegree forKey:@"userDegree"];
    [defaults setObject:self.userStschool forKey:@"userStschool"];
    [defaults setObject:self.userid forKey:@"userid"];
    [defaults setObject:self.ishead forKey:@"ishead"];
    [defaults setObject:self.useravatar_id forKey:@"useravatar_id"];
    [defaults setObject:self.usertoken forKey:@"usertoken"];
    [defaults setObject:self.certid forKey:@"certid"];
    [defaults setObject:self.isV forKey:@"isV"];
    [defaults setObject:self.isfinishCer forKey:@"isfinishCer"];
    [defaults setObject:self.isphoneverify forKey:@"isphoneverify"];
    [defaults setObject:self.last_login_time forKey:@"last_login_time"];
    [defaults setObject:self.ctime forKey:@"ctime"];
    [defaults setObject:self.isadmin forKey:@"isadmin"];
    [defaults setObject:self.headimg forKey:@"headimg"];
    [defaults setObject:self.fansnum forKey:@"fansnum"];
    [defaults setObject:self.supportnum forKey:@"supportnum"];
    [defaults setObject:self.user_token forKey:@"user_token"];

    [defaults synchronize];
}

/**
 *
 *保存用户数据到沙盒
 */
-(void)loadUserInfoFromSanbox{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    self.userName =     [defaults objectForKey:@"username"];
    self.loginStatus=   [defaults boolForKey:LoginStatusKey];
    self.passWord =     [defaults objectForKey:PwdKey];
    
    self.phoneNum = [defaults  objectForKey:@"phoneNum"];
    self.userReal_name = [defaults objectForKey:@"userReal_name;"];
    self.userEmail = [defaults objectForKey:@"userEmail"];
    self.usercity = [defaults objectForKey:@"usercity"];
    self.userLoginway = [defaults objectForKey:@"userLoginway"];
    self.userIdcard = [defaults objectForKey:@"userIdcard"];
    self.usersex = [defaults objectForKey:@"usersex"];
    self.userHospital = [defaults objectForKey:@"userHospital"];
    self.userOffice = [defaults objectForKey:@"userOffice"];
    self.userTitle = [defaults objectForKey:@"userTitle"];
    self.userPost = [defaults objectForKey:@"userPost"];
    self.userUnit = [defaults objectForKey:@"userUnit"];
    self.userPosition = [defaults objectForKey:@"userPosition"];
    self.userSchool = [defaults objectForKey:@"userSchool"];
    self.userMajor = [defaults objectForKey:@"userMajor"];
    self.userDegree = [defaults objectForKey:@"userDegree"];
    self.userStschool = [defaults objectForKey:@"userStschool"];
    self.userid = [defaults objectForKey:@"userid"];
    self.ishead = [defaults objectForKey:@"ishead"];
    self.useravatar_id = [defaults objectForKey:@"useravatar_id"];
    self.usertoken = [defaults objectForKey:@"usertoken"];
    self.certid = [defaults objectForKey:@"certid"];
    self.isV = [defaults objectForKey:@"isV"];
    self.isfinishCer = [defaults objectForKey:@"isfinishCer"];
    self.isphoneverify = [defaults objectForKey:@"isphoneverify"];
    self.last_login_time = [defaults objectForKey:@"last_login_time"];
    self.ctime = [defaults objectForKey:@"ctime"];
    self.isadmin = [defaults objectForKey:@"isadmin"];
    self.headimg = [defaults objectForKey:@"headimg"];
    self.fansnum = [defaults objectForKey:@"fansnum"];
    self.supportnum = [defaults objectForKey:@"supportnum"];
    self.user_token = [defaults objectForKey:@"user_token"];
    
}

@end
