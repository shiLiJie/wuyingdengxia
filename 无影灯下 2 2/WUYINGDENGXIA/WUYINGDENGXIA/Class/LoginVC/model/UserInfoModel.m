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
    
    if (!kObjectIsEmpty(self.userName)) {
        [defaults setObject:self.userName forKey:@"username"];
    }
    
//    if (!kObjectIsEmpty(self.loginStatus)) {
        [defaults setBool:self.loginStatus forKey:LoginStatusKey];
//    }
    if (!kObjectIsEmpty(self.passWord)) {
        [defaults setObject:self.passWord forKey:PwdKey];
    }
    if (!kObjectIsEmpty(self.phoneNum)) {
        [defaults setObject:self.phoneNum forKey:@"phoneNum"];
    }
    if (!kObjectIsEmpty(self.userReal_name)) {
        [defaults setObject:self.userReal_name forKey:@"userReal_name;"];
    }
    if (!kObjectIsEmpty(self.userEmail)) {
        [defaults setObject:self.userEmail forKey:@"userEmail"];
    }
    if (!kObjectIsEmpty(self.usercity)) {
        [defaults setObject:self.usercity forKey:@"usercity"];
    }
    if (!kObjectIsEmpty(self.userLoginway)) {
        [defaults setObject:self.userLoginway forKey:@"userLoginway"];
    }
    if (!kObjectIsEmpty(self.userIdcard)) {
        [defaults setObject:self.userIdcard forKey:@"userIdcard"];
    }
    if (!kObjectIsEmpty(self.usersex)) {
        [defaults setObject:self.usersex forKey:@"usersex"];
    }
    if (!kObjectIsEmpty(self.userHospital)) {
        [defaults setObject:self.userHospital forKey:@"userHospital"];
    }
    if (!kObjectIsEmpty(self.userOffice)) {
        [defaults setObject:self.userOffice forKey:@"userOffice"];
    }
    if (!kObjectIsEmpty(self.userTitle)) {
        [defaults setObject:self.userTitle forKey:@"userTitle"];
    }
    if (!kObjectIsEmpty(self.userPost)) {
        [defaults setObject:self.userPost forKey:@"userPost"];
    }
    if (!kObjectIsEmpty(self.userUnit)) {
        [defaults setObject:self.userUnit forKey:@"userUnit"];
    }
    if (!kObjectIsEmpty(self.userPosition)) {
        [defaults setObject:self.userPosition forKey:@"userPosition"];
    }
    if (!kObjectIsEmpty(self.userSchool)) {
        [defaults setObject:self.userSchool forKey:@"userSchool"];
    }
    if (!kObjectIsEmpty(self.userMajor)) {
        [defaults setObject:self.userMajor forKey:@"userMajor"];
    }
    if (!kObjectIsEmpty(self.userDegree)) {
        [defaults setObject:self.userDegree forKey:@"userDegree"];
    }
    if (!kObjectIsEmpty(self.userStschool)) {
        [defaults setObject:self.userStschool forKey:@"userStschool"];
    }
    if (!kObjectIsEmpty(self.userid)) {
        [defaults setObject:self.userid forKey:@"userid"];
    }
    if (!kObjectIsEmpty(self.ishead)) {
        [defaults setObject:self.ishead forKey:@"ishead"];
    }
    if (!kObjectIsEmpty(self.useravatar_id)) {
        [defaults setObject:self.useravatar_id forKey:@"useravatar_id"];
    }
    if (!kObjectIsEmpty(self.usertoken)) {
        [defaults setObject:self.usertoken forKey:@"usertoken"];
    }
    if (!kObjectIsEmpty(self.certid)) {
        [defaults setObject:self.certid forKey:@"certid"];
    }
    if (!kObjectIsEmpty(self.isV)) {
        [defaults setObject:self.isV forKey:@"isV"];
    }
    if (!kObjectIsEmpty(self.isfinishCer)) {
        [defaults setObject:self.isfinishCer forKey:@"isfinishCer"];
    }
    if (!kObjectIsEmpty(self.isphoneverify)) {
        [defaults setObject:self.isphoneverify forKey:@"isphoneverify"];
    }
    if (!kObjectIsEmpty(self.last_login_time)) {
        [defaults setObject:self.last_login_time forKey:@"last_login_time"];
    }
    if (!kObjectIsEmpty(self.ctime)) {
        [defaults setObject:self.ctime forKey:@"ctime"];
    }
    if (!kObjectIsEmpty(self.isadmin)) {
        [defaults setObject:self.isadmin forKey:@"isadmin"];
    }
    if (!kObjectIsEmpty(self.headimg)) {
        [defaults setObject:self.headimg forKey:@"headimg"];
    }
    if (!kObjectIsEmpty(self.fansnum)) {
        [defaults setObject:self.fansnum forKey:@"fansnum"];
    }
    if (!kObjectIsEmpty(self.supportnum)) {
        [defaults setObject:self.supportnum forKey:@"supportnum"];
    }
    if (!kObjectIsEmpty(self.user_token)) {
        [defaults setObject:self.user_token forKey:@"user_token"];
    }
    if (!kObjectIsEmpty(self.moon_cash)) {
        [defaults setObject:self.moon_cash forKey:@"moon_cash"];
    }

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
    self.moon_cash = [defaults objectForKey:@"moon_cash"];
    
}

@end
