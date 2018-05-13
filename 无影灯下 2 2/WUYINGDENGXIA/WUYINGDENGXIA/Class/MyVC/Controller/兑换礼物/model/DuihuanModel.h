//
//  DuihuanModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuihuanModel : NSObject

@property (nonatomic, copy) NSString *begin_time;//id
@property (nonatomic, copy) NSString *courtesy_code;//id
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *end_time;//
@property (nonatomic, copy) NSString *ex_num;//

@property (nonatomic, copy) NSString *exchange_code;//
@property (nonatomic, copy) NSString *exchange_time;//
@property (nonatomic, copy) NSString *goods_id;//

@property (nonatomic, copy) NSString *goods_img;//
@property (nonatomic, copy) NSString *goods_name;//
@property (nonatomic, copy) NSString *goods_tips;//
@property (nonatomic, copy) NSString *is_public;//

@property (nonatomic, copy) NSString *moon_cash;//
@property (nonatomic, copy) NSString *order_num;//






+ (instancetype)DuihuanModelWithDict:(NSDictionary *)dict;

@end
