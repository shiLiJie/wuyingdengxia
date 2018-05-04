//
//  meetingModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "meetingModel.h"

@implementation meetingModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.begin_time = dict[@"begin_time"];
        self.city = dict[@"city"];
        self.ctime = dict[@"ctime"];
        self.isfinish = dict[@"isfinish"];
        self.meet_address = dict[@"meet_address"];
        self.meet_content = dict[@"meet_content"];
        self.meet_id = dict[@"meet_id"];
        self.meet_title = dict[@"meet_title"];
        self.meeting_image = dict[@"meeting_image"];
        self.province = dict[@"province"];
    }
    return self;
}

+ (instancetype)meetWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
