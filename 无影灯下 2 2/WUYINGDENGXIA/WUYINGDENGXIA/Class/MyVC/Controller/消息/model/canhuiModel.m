//
//  canhuiModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "canhuiModel.h"

@implementation canhuiModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.content = dict[@"content"];
        self.send_by_id = dict[@"send_by_id"];
        self.send_name = dict[@"send_name"];
        self.sys_msg_id = dict[@"sys_msg_id"];
        self.ctime = dict[@"ctime"];
        
        self.tiku_id = dict[@"tiku_id"];
        self.to_id = dict[@"to_id"];
        self.type = dict[@"type"];
        self.user_id = dict[@"user_id"];
        self.user_name = dict[@"user_name"];
        
    }
    return self;
}

+ (instancetype)canhuiWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
