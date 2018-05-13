//
//  LiwuModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "LiwuModel.h"

@implementation LiwuModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.ctime = dict[@"ctime"];
        self.ex_num = dict[@"ex_num"];
        self.goods_id = dict[@"goods_id"];
        self.goods_img = dict[@"goods_img"];
        self.goods_name = dict[@"goods_name"];
        self.goods_tips = dict[@"goods_tips"];
        self.is_public = dict[@"is_public"];
        self.moon_cash = dict[@"moon_cash"];
        
    }
    return self;
}

+ (instancetype)LiwuModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
