//
//  huiguModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/5.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "huiguModel.h"

@implementation huiguModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.abstract = dict[@"abstract"];
        self.begin_time = dict[@"begin_time"];
        self.ctime = dict[@"ctime"];
        self.maintalk = dict[@"maintalk"];
        self.meeting_content = dict[@"meeting_content"];
        self.meeting_specialist = dict[@"meeting_specialist"];
        self.meeting_title = dict[@"meeting_title"];
        self.moon_cash = dict[@"moon_cash"];
        self.play_id = dict[@"play_id"];
        self.play_num = dict[@"play_num"];
        self.recom_num = dict[@"recom_num"];
        self.replay_id = dict[@"replay_id"];
        self.replay_title = dict[@"replay_title"];
        self.suport_num = dict[@"suport_num"];
    }
    return self;
}

+ (instancetype)huiguWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
