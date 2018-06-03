//
//  MyfensiModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyfensiModel.h"

@implementation MyfensiModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.fansid = dict[@"fansid"];
        self.fansname = dict[@"fansname"];
        self.fansnum = dict[@"fansnum"];
        self.isfinish_cert = dict[@"isfinish_cert"];
        self.fanshead = dict[@"fanshead"];
        self.is_follow = dict[@"is_follow"];

    }
    return self;
}

+ (instancetype)MyfensiWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
