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
    [defaults setObject:self.userName forKey:UserKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults setObject:self.passWord forKey:PwdKey];
    [defaults synchronize];
}

/**
 *
 *保存用户数据到沙盒
 */
-(void)loadUserInfoFromSanbox{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    self.userName =     [defaults objectForKey:UserKey];
    self.loginStatus=   [defaults boolForKey:LoginStatusKey];
    self.passWord =     [defaults objectForKey:PwdKey];
    
}

@end
