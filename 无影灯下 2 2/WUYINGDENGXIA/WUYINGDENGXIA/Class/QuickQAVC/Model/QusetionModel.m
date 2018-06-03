//
//  QusetionModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "QusetionModel.h"

@implementation QusetionModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.answer_num = dict[@"answer_num"];
        self.ctime = dict[@"ctime"];
        self.failreason = dict[@"failreason"];
        self.headimg = dict[@"headimg"];
        self.is_con_check = dict[@"is_con_check"];
        self.is_pro_check = dict[@"is_pro_check"];
        self.is_solve = dict[@"is_solve"];
        self.moon_cash = dict[@"moon_cash"];
        self.nowlevel = dict[@"nowlevel"];
        self.ques_answer = dict[@"ques_answer"];
        self.question_content = dict[@"question_content"];
        self.question_id = dict[@"question_id"];
        self.question_image = dict[@"question_image"];
        self.question_tags = dict[@"question_tags"];
        self.question_title = dict[@"question_title"];
        self.question_type_id = dict[@"question_type_id"];
        self.user_id = dict[@"user_id"];
        self.user_name = dict[@"user_name"];
        self.last_answer_time = dict[@"last_answer_time"];
    }
    return self;
}

+ (instancetype)QusetionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
