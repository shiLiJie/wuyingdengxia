//
//  LiwuModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiwuModel : NSObject

@property (nonatomic, copy) NSString *ctime;//id
@property (nonatomic, copy) NSString *ex_num;//id
@property (nonatomic, copy) NSString *goods_id;//
@property (nonatomic, copy) NSString *goods_img;//
@property (nonatomic, copy) NSString *goods_name;//
@property (nonatomic, copy) NSString *goods_tips;//
@property (nonatomic, copy) NSString *is_public;//
@property (nonatomic, copy) NSString *moon_cash;//




+ (instancetype)LiwuModelWithDict:(NSDictionary *)dict;

@end
