//
//  lableModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "lableModel.h"

@implementation lableModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.label_id = dict[@"label_id"];
        self.key_num = dict[@"key_num"];
        self.ctime = dict[@"ctime"];
    }
    return self;
}

+ (instancetype)lableWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
