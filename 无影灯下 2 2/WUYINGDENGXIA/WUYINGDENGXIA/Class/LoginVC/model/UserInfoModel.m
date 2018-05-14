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
    }else{
        [defaults setObject:self.userName forKey:@""];
    }
    
//    if (!kObjectIsEmpty(self.loginStatus)) {
        [defaults setBool:self.loginStatus forKey:LoginStatusKey];
//    }
    if (!kObjectIsEmpty(self.passWord)) {
        [defaults setObject:self.passWord forKey:PwdKey];
    }else{
        [defaults setObject:self.passWord forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.phoneNum)) {
        [defaults setObject:self.phoneNum forKey:@"phoneNum"];
    }else{
        [defaults setObject:self.phoneNum forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userReal_name)) {
        [defaults setObject:self.userReal_name forKey:@"userReal_name;"];
    }else{
        [defaults setObject:self.userReal_name forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userEmail)) {
        [defaults setObject:self.userEmail forKey:@"userEmail"];
    }else{
        [defaults setObject:self.userEmail forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.usercity)) {
        [defaults setObject:self.usercity forKey:@"usercity"];
    }else{
        [defaults setObject:self.usercity forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userLoginway)) {
        [defaults setObject:self.userLoginway forKey:@"userLoginway"];
    }else{
        [defaults setObject:self.userLoginway forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userIdcard)) {
        [defaults setObject:self.userIdcard forKey:@"userIdcard"];
    }else{
        [defaults setObject:self.userIdcard forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.usersex)) {
        [defaults setObject:self.usersex forKey:@"usersex"];
    }else{
        [defaults setObject:self.usersex forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userHospital)) {
        [defaults setObject:self.userHospital forKey:@"userHospital"];
    }else{
        [defaults setObject:self.userHospital forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userOffice)) {
        [defaults setObject:self.userOffice forKey:@"userOffice"];
    }else{
        [defaults setObject:self.userOffice forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userTitle)) {
        [defaults setObject:self.userTitle forKey:@"userTitle"];
    }else{
        [defaults setObject:self.userTitle forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userPost)) {
        [defaults setObject:self.userPost forKey:@"userPost"];
    }else{
        [defaults setObject:self.userPost forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userUnit)) {
        [defaults setObject:self.userUnit forKey:@"userUnit"];
    }else{
        [defaults setObject:self.userUnit forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userPosition)) {
        [defaults setObject:self.userPosition forKey:@"userPosition"];
    }else{
        [defaults setObject:self.userPosition forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userSchool)) {
        [defaults setObject:self.userSchool forKey:@"userSchool"];
    }else{
        [defaults setObject:self.userSchool forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userMajor)) {
        [defaults setObject:self.userMajor forKey:@"userMajor"];
    }else{
        [defaults setObject:self.userMajor forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userDegree)) {
        [defaults setObject:self.userDegree forKey:@"userDegree"];
    }else{
        [defaults setObject:self.userDegree forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userStschool)) {
        [defaults setObject:self.userStschool forKey:@"userStschool"];
    }else{
        [defaults setObject:self.userStschool forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.userid)) {
        [defaults setObject:self.userid forKey:@"userid"];
    }else{
        [defaults setObject:self.userid forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.ishead)) {
        [defaults setObject:self.ishead forKey:@"ishead"];
    }else{
        [defaults setObject:self.ishead forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.useravatar_id)) {
        [defaults setObject:self.useravatar_id forKey:@"useravatar_id"];
    }else{
        [defaults setObject:self.useravatar_id forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.usertoken)) {
        [defaults setObject:self.usertoken forKey:@"usertoken"];
    }else{
        [defaults setObject:self.usertoken forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.certid)) {
        [defaults setObject:self.certid forKey:@"certid"];
    }else{
        [defaults setObject:self.certid forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.isV)) {
        [defaults setObject:self.isV forKey:@"isV"];
    }else{
        [defaults setObject:self.isV forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.isfinishCer)) {
        [defaults setObject:self.isfinishCer forKey:@"isfinishCer"];
    }else{
        [defaults setObject:self.isfinishCer forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.isphoneverify)) {
        [defaults setObject:self.isphoneverify forKey:@"isphoneverify"];
    }else{
        [defaults setObject:self.isphoneverify forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.last_login_time)) {
        [defaults setObject:self.last_login_time forKey:@"last_login_time"];
    }else{
        [defaults setObject:self.last_login_time forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.ctime)) {
        [defaults setObject:self.ctime forKey:@"ctime"];
    }else{
        [defaults setObject:self.ctime forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.isadmin)) {
        [defaults setObject:self.isadmin forKey:@"isadmin"];
    }else{
        [defaults setObject:self.isadmin forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.headimg)) {
        [defaults setObject:self.headimg forKey:@"headimg"];
    }else{
        [defaults setObject:self.headimg forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.fansnum)) {
        [defaults setObject:self.fansnum forKey:@"fansnum"];
    }else{
        [defaults setObject:self.fansnum forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.supportnum)) {
        [defaults setObject:self.supportnum forKey:@"supportnum"];
    }else{
        [defaults setObject:self.supportnum forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.user_token)) {
        [defaults setObject:self.user_token forKey:@"user_token"];
    }else{
        [defaults setObject:self.user_token forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.moon_cash)) {
        [defaults setObject:self.moon_cash forKey:@"moon_cash"];
    }else{
        [defaults setObject:self.moon_cash forKey:@""];
    }
    
    if (!kObjectIsEmpty(self.we_chat_id)) {
        [defaults setObject:self.we_chat_id forKey:@"we_chat_id"];
    }else{
        [defaults setObject:self.we_chat_id forKey:@""];
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
    self.we_chat_id = [defaults objectForKey:@"we_chat_id"];
    
}

@end
