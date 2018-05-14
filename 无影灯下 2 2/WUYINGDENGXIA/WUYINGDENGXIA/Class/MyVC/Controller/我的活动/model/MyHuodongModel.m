//
//  MyHuodongModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyHuodongModel.h"

@implementation MyHuodongModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.begin_time = dict[@"begin_time"];
        self.is_check = dict[@"is_check"];
        self.is_sign = dict[@"is_sign"];
        self.isfinish = dict[@"isfinish"];
        self.meet_content = dict[@"meet_content"];
        self.meet_id = dict[@"meet_id"];
        self.meet_title = dict[@"meet_title"];
        self.meeting_image = dict[@"meeting_image"];
    }
    return self;
}

+ (instancetype)MyHuodongWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
