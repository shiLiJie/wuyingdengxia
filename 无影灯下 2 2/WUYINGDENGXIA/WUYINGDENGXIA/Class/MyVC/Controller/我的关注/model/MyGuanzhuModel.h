//
//  MyGuanzhuModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGuanzhuModel : NSObject

@property (nonatomic, copy) NSString *ctime;//id
@property (nonatomic, copy) NSString *followhead;//id
@property (nonatomic, copy) NSString *followid;//
@property (nonatomic, copy) NSString *followname;//

@property (nonatomic, copy) NSString *user_post;//
@property (nonatomic, copy) NSString *isfinish_cert;//
@property (nonatomic, copy) NSString *fans_num;//



+ (instancetype)guanzhuWithDict:(NSDictionary *)dict;

@end
