//
//  zhuangjiaModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "zhuangjiaModel.h"

@implementation zhuangjiaModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.meet_id = dict[@"meet_id"];
        self.meet_talk_content = dict[@"meet_talk_content"];
        self.meet_talk_id = dict[@"meet_talk_id"];
        
        self.meet_talk_name = dict[@"meet_talk_name"];
        self.specialist_image = dict[@"specialist_image"];

    }
    return self;
}


+ (instancetype)zhuagnjiaWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
