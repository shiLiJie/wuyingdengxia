//
//  DuihuanModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DuihuanModel.h"

@implementation DuihuanModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.begin_time = dict[@"begin_time"];
        self.courtesy_code = dict[@"courtesy_code"];
        self.ctime = dict[@"ctime"];
        self.end_time = dict[@"end_time"];
        self.ex_num = dict[@"ex_num"];
        self.exchange_code = dict[@"exchange_code"];
        self.exchange_time = dict[@"exchange_time"];
        self.goods_id = dict[@"goods_id"];
        self.goods_img = dict[@"goods_img"];
        
        self.goods_name = dict[@"goods_name"];
        self.goods_tips = dict[@"goods_tips"];
        self.is_public = dict[@"is_public"];
        self.moon_cash = dict[@"moon_cash"];
        self.order_num = dict[@"order_num"];
    }
    return self;
}

+ (instancetype)DuihuanModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
