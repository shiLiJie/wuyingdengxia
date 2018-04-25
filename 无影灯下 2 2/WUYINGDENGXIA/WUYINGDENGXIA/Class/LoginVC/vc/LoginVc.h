//
//  LoginVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^LoginHandler)(BOOL result, NSString *message);

@interface LoginVc : BaseViewController

/** 登录按钮点击回调 **/
@property (nonatomic, copy) LoginHandler loginBlock;

+ (instancetype)loginControllerWithBlock:(LoginHandler)loginBlock;

@end
