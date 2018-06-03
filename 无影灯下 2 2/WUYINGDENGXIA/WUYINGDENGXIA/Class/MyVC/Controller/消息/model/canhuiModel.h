//
//  canhuiModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface canhuiModel : NSObject

@property (nonatomic, copy) NSString *content;//id
@property (nonatomic, copy) NSString *send_by_id;//id
@property (nonatomic, copy) NSString *send_name;//
@property (nonatomic, copy) NSString *sys_msg_id;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *tiku_id;//id
@property (nonatomic, copy) NSString *to_id;//id
@property (nonatomic, copy) NSString *type;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *user_name;//




+ (instancetype)canhuiWithDict:(NSDictionary *)dict;

@end
