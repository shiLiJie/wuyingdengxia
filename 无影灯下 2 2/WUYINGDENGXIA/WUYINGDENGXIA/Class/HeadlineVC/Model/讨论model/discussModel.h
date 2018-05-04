//
//  discussModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface discussModel : NSObject

@property (nonatomic, copy) NSString *ctime;//id
@property (nonatomic, copy) NSString *dis_img;//
@property (nonatomic, copy) NSString *end_time;//
@property (nonatomic, copy) NSString *is_public;//
@property (nonatomic, copy) NSString *key_dis_id;//id
@property (nonatomic, copy) NSString *key_dis_title;//
@property (nonatomic, copy) NSString *key_id;//
@property (nonatomic, copy) NSString *type;//
@property (nonatomic, copy) NSString *user_id;//

+ (instancetype)discussWithDict:(NSDictionary *)dict;

@end
