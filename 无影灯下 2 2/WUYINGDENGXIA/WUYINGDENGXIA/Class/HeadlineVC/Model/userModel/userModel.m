//
//  userModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "userModel.h"

@implementation userModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.certid = dict[@"certid"];
        self.ctime = dict[@"ctime"];
        self.fansnum = dict[@"fansnum"];
        self.headimg = dict[@"headimg"];
        self.isV = dict[@"isV"];
        self.isadmin = dict[@"isadmin"];
        self.isfinishCer = dict[@"isfinishCer"];
        self.ishead = dict[@"ishead"];
        self.isphoneverify = dict[@"isphoneverify"];
        self.last_login_time = dict[@"last_login_time"];
        self.ctime = dict[@"ctime"];
        self.phoneNum = dict[@"phoneNum"];
        self.supportnum = dict[@"supportnum"];
        self.userDegree = dict[@"userDegree"];
        self.userEmail = dict[@"userEmail"];
        self.userHospital = dict[@"userHospital"];
        self.userIdcard = dict[@"userIdcard"];
        self.userLoginway = dict[@"userLoginway"];
        self.userMajor = dict[@"userMajor"];
        self.userOffice = dict[@"userOffice"];
        self.userPosition = dict[@"userPosition"];
        self.userPost = dict[@"userPost"];
        self.userReal_name = dict[@"userReal_name"];
        self.userSchool = dict[@"userSchool"];
        self.userStschool = dict[@"userStschool"];
        self.userTitle = dict[@"userTitle"];
        self.userUnit = dict[@"userUnit"];
        self.user_token = dict[@"user_token"];
        self.useravatar_id = dict[@"useravatar_id"];
        self.usercity = dict[@"usercity"];
        self.userid = dict[@"userid"];
        self.username = dict[@"username"];
        self.usersex = dict[@"usersex"];
        self.usertoken = dict[@"usertoken"];
        self.moon_cash = dict[@"moon_cash"];
        
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
