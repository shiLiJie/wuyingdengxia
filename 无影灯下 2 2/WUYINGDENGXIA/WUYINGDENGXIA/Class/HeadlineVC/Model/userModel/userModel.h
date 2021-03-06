//
//  userModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject

//用户名
@property (nonatomic ,copy)NSString *username;
@property (nonatomic ,copy)NSString *phoneNum;
@property (nonatomic ,copy)NSString *userReal_name;
@property (nonatomic ,copy)NSString *userEmail;
@property (nonatomic ,copy)NSString *usercity;
@property (nonatomic ,copy)NSString *userLoginway;
@property (nonatomic ,copy)NSString *userIdcard;
@property (nonatomic ,copy)NSString *usersex;
@property (nonatomic ,copy)NSString *userHospital;
@property (nonatomic ,copy)NSString *userOffice;
@property (nonatomic ,copy)NSString *userTitle;
@property (nonatomic ,copy)NSString *userPost;
@property (nonatomic ,copy)NSString *userUnit;
@property (nonatomic ,copy)NSString *userPosition;
@property (nonatomic ,copy)NSString *userSchool;
@property (nonatomic ,copy)NSString *userMajor;
@property (nonatomic ,copy)NSString *userDegree;
@property (nonatomic ,copy)NSString *userStschool;
@property (nonatomic ,copy)NSString *userid;
@property (nonatomic ,copy)NSString *ishead;
@property (nonatomic ,copy)NSString *useravatar_id;
@property (nonatomic ,copy)NSString *usertoken;
@property (nonatomic ,copy)NSString *certid;
@property (nonatomic ,copy)NSString *isV;
@property (nonatomic ,copy)NSString *isfinishCer;
@property (nonatomic ,copy)NSString *isphoneverify;
@property (nonatomic ,copy)NSString *last_login_time;
@property (nonatomic ,copy)NSString *ctime;
@property (nonatomic ,copy)NSString *isadmin;
@property (nonatomic ,copy)NSString *headimg;
@property (nonatomic ,copy)NSString *fansnum;
@property (nonatomic ,copy)NSString *supportnum;
@property (nonatomic ,copy)NSString *user_token;
@property (nonatomic,copy) NSString *moon_cash;
@property (nonatomic,copy) NSString *we_chat_id;
@property (nonatomic,copy) NSString *user_birthday;
@property (nonatomic,copy) NSString *is_follow;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
