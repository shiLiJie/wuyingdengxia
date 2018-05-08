//
//  huiguDetailModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "huiguDetailModel.h"

@implementation huiguDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.replay_title = dict[@"replay_title"];
        self.maintalk = dict[@"maintalk"];
        self.playnum = dict[@"playnum"];
        self.playpath = dict[@"playpath"];
        self.abstract = dict[@"abstract"];
        self.begintime = dict[@"begintime"];
        self.meeting_content = dict[@"meeting_content"];
        self.meeting_specialist = dict[@"meeting_specialist"];
        self.meeting_title = dict[@"meeting_title"];
        self.recom_num = dict[@"recom_num"];
        self.suport_num = dict[@"suport_num"];

    }
    return self;
}

+ (instancetype)huiguDetailWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
