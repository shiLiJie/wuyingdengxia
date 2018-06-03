//
//  lableModel2.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "lableModel2.h"

@implementation lableModel2

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.label_name = dict[@"label_name"];
        self.label_id = dict[@"label_id"];
        self.label_type = dict[@"label_type"];
        self.ctime = dict[@"ctime"];
    }
    return self;
}

+ (instancetype)lable2WithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
