//
//  MBProgressHUD+BYHUDTools.h
//  NewSuperGymForCoach
//
//  Created by 凤凰八音 on 16/6/27.
//  Copyright © 2016年 HanYouApp. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (BYHUDTools)
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;


/**
 单独显示信息一秒后消失
 
 @param message 信息
 */
+ (void)showOneSecond:(NSString *)message;
@end
