//
//  discussModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "discussModel.h"

@implementation discussModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.ctime = dict[@"ctime"];
        self.dis_img = dict[@"dis_img"];
        self.end_time = dict[@"end_time"];
        self.is_public = dict[@"is_public"];
        self.key_dis_id = dict[@"key_dis_id"];
        self.key_dis_title = dict[@"key_dis_title"];
        self.key_id = dict[@"key_id"];
        self.type = dict[@"type"];
        self.user_id = dict[@"user_id"];
    }
    return self;
}

+ (instancetype)discussWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
