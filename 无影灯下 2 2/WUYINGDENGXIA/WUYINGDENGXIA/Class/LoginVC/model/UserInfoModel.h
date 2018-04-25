//
//  UserInfoModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

//用户名
@property (nonatomic ,copy)NSString *userName;
//密码
@property (nonatomic ,copy)NSString *passWord;
//登陆的状态 YES 登录过 NO 注销
@property (nonatomic, assign) BOOL  loginStatus;

//单例
+(instancetype)shareUserModel;

//从沙盒里获取用户数据
-(void)loadUserInfoFromSanbox;

//保存用户数据到沙盒
-(void)saveUserInfoToSanbox;

@end
