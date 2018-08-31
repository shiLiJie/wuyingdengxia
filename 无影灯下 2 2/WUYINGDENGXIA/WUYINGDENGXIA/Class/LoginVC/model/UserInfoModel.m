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
    
    if (!kObjectIsEmpty(self.userName) && ![self.userName isEqualToString:@""]) {
        [defaults setObject:self.userName forKey:@"username"];
    }else{
        [defaults setObject:@"" forKey:@"username"];
    }
    
//    if (!kObjectIsEmpty(self.loginStatus)) {
        [defaults setBool:self.loginStatus forKey:LoginStatusKey];
//    }
    if (!kObjectIsEmpty(self.passWord) && ![self.passWord isEqualToString:@""]) {
        [defaults setObject:self.passWord forKey:PwdKey];
    }else{
        [defaults setObject:@"" forKey:PwdKey];
    }
    
    if (!kObjectIsEmpty(self.phoneNum) && ![self.phoneNum isEqualToString:@""]) {
        [defaults setObject:self.phoneNum forKey:@"phoneNum"];
    }else{
        [defaults setObject:@"" forKey:@"phoneNum"];
    }
    
    if (!kObjectIsEmpty(self.userReal_name) && ![self.userReal_name isEqualToString:@""]) {
        [defaults setObject:self.userReal_name forKey:@"userReal_name;"];
    }else{
        [defaults setObject:@"" forKey:@"userReal_name;"];
    }
    
    if (!kObjectIsEmpty(self.userEmail) && ![self.userEmail isEqualToString:@""]) {
        [defaults setObject:self.userEmail forKey:@"userEmail"];
    }else{
        [defaults setObject:@"" forKey:@"userEmail"];
    }
    
    if (!kObjectIsEmpty(self.usercity) && ![self.usercity isEqualToString:@""]) {
        [defaults setObject:self.usercity forKey:@"usercity"];
    }else{
        [defaults setObject:@"" forKey:@"usercity"];
    }
    
    if (!kObjectIsEmpty(self.userLoginway) && ![self.userLoginway isEqualToString:@""]) {
        [defaults setObject:self.userLoginway forKey:@"userLoginway"];
    }else{
        [defaults setObject:@"" forKey:@"userLoginway"];
    }
    
    if (!kObjectIsEmpty(self.userIdcard) && ![self.userIdcard isEqualToString:@""]) {
        [defaults setObject:self.userIdcard forKey:@"userIdcard"];
    }else{
        [defaults setObject:@"" forKey:@"userIdcard"];
    }
    
    if (!kObjectIsEmpty(self.usersex) && ![self.usersex isEqualToString:@""]) {
        [defaults setObject:self.usersex forKey:@"usersex"];
    }else{
        [defaults setObject:@"" forKey:@"usersex"];
    }
    
    if (!kObjectIsEmpty(self.userHospital) && ![self.userHospital isEqualToString:@""]) {
        [defaults setObject:self.userHospital forKey:@"userHospital"];
    }else{
        [defaults setObject:@"" forKey:@"userHospital"];
    }
    
    if (!kObjectIsEmpty(self.userOffice) && ![self.userOffice isEqualToString:@""]) {
        [defaults setObject:self.userOffice forKey:@"userOffice"];
    }else{
        [defaults setObject:@"" forKey:@"userOffice"];
    }
    
    if (!kObjectIsEmpty(self.userTitle) && ![self.userTitle isEqualToString:@""]) {
        [defaults setObject:self.userTitle forKey:@"userTitle"];
    }else{
        [defaults setObject:@"" forKey:@"userTitle"];
    }
    
    if (!kObjectIsEmpty(self.userPost) && ![self.userPost isEqualToString:@""]) {
        [defaults setObject:self.userPost forKey:@"userPost"];
    }else{
        [defaults setObject:@"" forKey:@"userPost"];
    }
    
    if (!kObjectIsEmpty(self.userUnit) && ![self.userUnit isEqualToString:@""]) {
        [defaults setObject:self.userUnit forKey:@"userUnit"];
    }else{
        [defaults setObject:@"" forKey:@"userUnit"];
    }
    
    if (!kObjectIsEmpty(self.userPosition) && ![self.userPosition isEqualToString:@""]) {
        [defaults setObject:self.userPosition forKey:@"userPosition"];
    }else{
        [defaults setObject:@"" forKey:@"userPosition"];
    }
    
    if (!kObjectIsEmpty(self.userSchool) && ![self.userSchool isEqualToString:@""]) {
        [defaults setObject:self.userSchool forKey:@"userSchool"];
    }else{
        [defaults setObject:@"" forKey:@"userSchool"];
    }
    
    if (!kObjectIsEmpty(self.userMajor) && ![self.userMajor isEqualToString:@""]) {
        [defaults setObject:self.userMajor forKey:@"userMajor"];
    }else{
        [defaults setObject:@"" forKey:@"userMajor"];
    }
    
    if (!kObjectIsEmpty(self.userDegree) && ![self.userDegree isEqualToString:@""]) {
        [defaults setObject:self.userDegree forKey:@"userDegree"];
    }else{
        [defaults setObject:@"" forKey:@"userDegree"];
    }
    
    if (!kObjectIsEmpty(self.userStschool) && ![self.userStschool isEqualToString:@""]) {
        [defaults setObject:self.userStschool forKey:@"userStschool"];
    }else{
        [defaults setObject:@"" forKey:@"userStschool"];
    }
    
    if (!kObjectIsEmpty(self.userid) && ![self.userid isEqualToString:@""]) {
        [defaults setObject:self.userid forKey:@"userid"];
    }else{
        [defaults setObject:@"" forKey:@"userid"];
    }
    
    if (!kObjectIsEmpty(self.ishead) && ![self.ishead isEqualToString:@""]) {
        [defaults setObject:self.ishead forKey:@"ishead"];
    }else{
        [defaults setObject:@"" forKey:@"ishead"];
    }
    
    if (!kObjectIsEmpty(self.useravatar_id) && ![self.useravatar_id isEqualToString:@""]) {
        [defaults setObject:self.useravatar_id forKey:@"useravatar_id"];
    }else{
        [defaults setObject:@"" forKey:@"useravatar_id"];
    }
    
    if (!kObjectIsEmpty(self.usertoken) && ![self.usertoken isEqualToString:@""]) {
        [defaults setObject:self.usertoken forKey:@"usertoken"];
    }else{
        [defaults setObject:@"" forKey:@"usertoken"];
    }
    
    if (!kObjectIsEmpty(self.certid) && ![self.certid isEqualToString:@""]) {
        [defaults setObject:self.certid forKey:@"certid"];
    }else{
        [defaults setObject:@"" forKey:@"certid"];
    }
    
    if (!kObjectIsEmpty(self.isV) && ![self.isV isEqualToString:@""]) {
        [defaults setObject:self.isV forKey:@"isV"];
    }else{
        [defaults setObject:@"" forKey:@"isV"];
    }
    
    if (!kObjectIsEmpty(self.isfinishCer) && ![self.isfinishCer isEqualToString:@""]) {
        [defaults setObject:self.isfinishCer forKey:@"isfinishCer"];
    }else{
        [defaults setObject:@"" forKey:@"isfinishCer"];
    }
    
    if (!kObjectIsEmpty(self.isphoneverify) && ![self.isphoneverify isEqualToString:@""]) {
        [defaults setObject:self.isphoneverify forKey:@"isphoneverify"];
    }else{
        [defaults setObject:@"" forKey:@"isphoneverify"];
    }
    
    if (!kObjectIsEmpty(self.last_login_time) && ![self.last_login_time isEqualToString:@""]) {
        [defaults setObject:self.last_login_time forKey:@"last_login_time"];
    }else{
        [defaults setObject:@"" forKey:@"last_login_time"];
    }
    
    if (!kObjectIsEmpty(self.ctime) && ![self.ctime isEqualToString:@""]) {
        [defaults setObject:self.ctime forKey:@"ctime"];
    }else{
        [defaults setObject:@"" forKey:@"ctime"];
    }
    
    if (!kObjectIsEmpty(self.isadmin) && ![self.isadmin isEqualToString:@""]) {
        [defaults setObject:self.isadmin forKey:@"isadmin"];
    }else{
        [defaults setObject:@"" forKey:@"isadmin"];
    }
    
    if (!kObjectIsEmpty(self.headimg) && ![self.headimg isEqualToString:@""]) {
        [defaults setObject:self.headimg forKey:@"headimg"];
    }else{
        [defaults setObject:@"" forKey:@"headimg"];
    }
    
    if (!kObjectIsEmpty(self.fansnum) && ![self.fansnum isEqualToString:@""]) {
        [defaults setObject:self.fansnum forKey:@"fansnum"];
    }else{
        [defaults setObject:@"" forKey:@"fansnum"];
    }
    
    if (!kObjectIsEmpty(self.supportnum) && ![self.supportnum isEqualToString:@""]) {
        [defaults setObject:self.supportnum forKey:@"supportnum"];
    }else{
        [defaults setObject:@"" forKey:@"supportnum"];
    }
    
    if (!kObjectIsEmpty(self.user_token) && ![self.user_token isEqualToString:@""]) {
        [defaults setObject:self.user_token forKey:@"user_token"];
    }else{
        [defaults setObject:@"" forKey:@"user_token"];
    }
    
    if (!kObjectIsEmpty(self.moon_cash) && ![self.moon_cash isEqualToString:@""]) {
        [defaults setObject:self.moon_cash forKey:@"moon_cash"];
    }else{
        [defaults setObject:@"" forKey:@"moon_cash"];
    }
    
    if (!kObjectIsEmpty(self.we_chat_id) && ![self.we_chat_id isEqualToString:@""]) {
        [defaults setObject:self.we_chat_id forKey:@"we_chat_id"];
    }else{
        [defaults setObject:@"" forKey:@"we_chat_id"];
    }
    
    if (!kObjectIsEmpty(self.user_birthday) && ![self.user_birthday isEqualToString:@""]) {
        [defaults setObject:self.user_birthday forKey:@"user_birthday"];
    }else{
        [defaults setObject:@"" forKey:@"user_birthday"];
    }
    
    if (!kObjectIsEmpty(self.special_committee) && ![self.special_committee isEqualToString:@""]) {
        [defaults setObject:self.special_committee forKey:@"special_committee"];
    }else{
        [defaults setObject:@"" forKey:@"special_committee"];
    }
    
    if (!kObjectIsEmpty(self.user_identity) && ![self.user_identity isEqualToString:@""]) {
        [defaults setObject:self.user_identity forKey:@"user_identity"];
    }else{
        [defaults setObject:@"" forKey:@"user_identity"];
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
    self.user_birthday = [defaults objectForKey:@"user_birthday"];
    self.special_committee = [defaults objectForKey:@"special_committee"];
    self.user_identity = [defaults objectForKey:@"user_identity"];

    
}

-(void)clearUserInfoFromSanbox{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"username"];
    [defaults removeObjectForKey:@"userPost"];
    [defaults removeObjectForKey:@"userUnit"];
    [defaults removeObjectForKey:@"userPosition"];
    [defaults removeObjectForKey:@"userOffice"];
    [defaults removeObjectForKey:@"userHospital"];
}

@end
