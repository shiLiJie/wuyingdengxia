//
//  MyhuidaModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyhuidaModel.h"

@implementation MyhuidaModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.answer_content = dict[@"answer_content"];
        self.answer_id = dict[@"answer_id"];
        self.ctime = dict[@"ctime"];
        self.headimg = dict[@"headimg"];
        self.is_solve = dict[@"is_solve"];
        self.is_take = dict[@"is_take"];
        self.moon_cash = dict[@"moon_cash"];
        self.question_content = dict[@"question_content"];
        self.question_id = dict[@"question_id"];
        self.question_title = dict[@"question_title"];
        self.user_id = dict[@"user_id"];
        self.user_name = dict[@"user_name"];

    }
    return self;
}

+ (instancetype)MyhuidaWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
