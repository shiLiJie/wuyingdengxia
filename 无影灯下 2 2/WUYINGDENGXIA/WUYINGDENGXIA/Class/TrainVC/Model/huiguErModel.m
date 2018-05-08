//
//  huiguErModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "huiguErModel.h"

@implementation huiguErModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.comment_num = dict[@"comment_num"];
        self.meeting_content = dict[@"meeting_content"];
        self.meeting_specialist = dict[@"meeting_specialist"];
        self.meeting_title = dict[@"meeting_title"];
        self.replay_id = dict[@"replay_id"];
        self.replay_sub_id = dict[@"replay_sub_id"];
        self.support_num = dict[@"support_num"];
        self.video_url = dict[@"video_url"];
        self.play_num = dict[@"play_num"];
    }
    return self;
}

+ (instancetype)huiguErWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
