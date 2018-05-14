//
//  MyHuodongModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHuodongModel : NSObject
@property (nonatomic, copy) NSString *begin_time;//id
@property (nonatomic, copy) NSString *is_check;//id
@property (nonatomic, copy) NSString *is_sign;//
@property (nonatomic, copy) NSString *isfinish;//
@property (nonatomic, copy) NSString *meet_content;//
@property (nonatomic, copy) NSString *meet_id;//
@property (nonatomic, copy) NSString *meet_title;//
@property (nonatomic, copy) NSString *meeting_image;//



+ (instancetype)MyHuodongWithDict:(NSDictionary *)dict;

@end
