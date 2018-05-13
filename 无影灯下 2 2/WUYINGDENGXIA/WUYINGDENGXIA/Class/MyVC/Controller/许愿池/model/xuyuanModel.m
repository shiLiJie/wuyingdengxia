//
//  xuyuanModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "xuyuanModel.h"

@implementation xuyuanModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.wish_id = dict[@"wish_id"];
        self.status = dict[@"status"];
        self.wish_content = dict[@"wish_content"];
        self.moon_cash = dict[@"moon_cash"];
        self.ctime = dict[@"ctime"];
        
    }
    return self;
}

+ (instancetype)xuyuanWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
