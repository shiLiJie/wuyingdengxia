//
//  hotKeyModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "hotKeyModel.h"

@implementation hotKeyModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.search_content = dict[@"search_content"];
//        self.count(search_content) = dict[@"count(search_content)"];

    }
    return self;
}

+ (instancetype)hotKeyWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
