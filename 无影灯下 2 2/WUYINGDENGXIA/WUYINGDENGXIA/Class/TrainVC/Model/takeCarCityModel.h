//
//  takeCarCityModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface takeCarCityModel : NSObject

@property (nonatomic, copy) NSString *sta_name;//
@property (nonatomic, copy) NSString *sta_ename;//主讲
@property (nonatomic, copy) NSString *sta_code;//








+ (instancetype)takeCarCitylWithDict:(NSDictionary *)dict;

@end
