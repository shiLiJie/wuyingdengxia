//
//  huocheModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "huocheModel.h"

@implementation huocheModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.start_station = dict[@"start_station"];
        self.start_time = dict[@"start_time"];
        self.end_station = dict[@"end_station"];
        
        self.end_time = dict[@"end_time"];
        self.run_time = dict[@"run_time"];
        self.train_no = dict[@"train_no"];
    }
    return self;
}


+ (instancetype)huochepiaoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
