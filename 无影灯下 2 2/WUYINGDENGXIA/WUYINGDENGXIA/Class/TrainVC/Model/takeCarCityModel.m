//
//  takeCarCityModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "takeCarCityModel.h"

@implementation takeCarCityModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.sta_name = dict[@"sta_name"];
        self.sta_ename = dict[@"sta_ename"];
        self.sta_code = dict[@"sta_code"];
    }
    return self;
}


+ (instancetype)takeCarCitylWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
