//
//  MyGuanzhuModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyGuanzhuModel.h"

@implementation MyGuanzhuModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.ctime = dict[@"ctime"];
        self.followhead = dict[@"followhead"];
        self.followid = dict[@"followid"];
        self.followname = dict[@"followname"];
        
        self.user_post = dict[@"user_post"];
        self.fans_num = dict[@"fans_num"];

    }
    return self;
}

+ (instancetype)guanzhuWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
