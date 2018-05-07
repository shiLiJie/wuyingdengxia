//
//  pageModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "pageModel.h"

@implementation pageModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.article_author = dict[@"article_author"];
        self.article_class = dict[@"article_class"];
        self.article_content = dict[@"article_content"];
        self.article_id = dict[@"article_id"];
        self.article_img_path = dict[@"article_img_path"];
        self.article_moon_cash = dict[@"article_moon_cash"];
        self.article_tags = dict[@"article_tags"];
        self.article_title = dict[@"article_title"];
        self.article_type = dict[@"article_type"];
        self.change_id = dict[@"change_id"];
        self.ctime = dict[@"ctime"];
        self.failreason = dict[@"failreason"];
        self.is_check = dict[@"is_check"];
        self.is_edit_check = dict[@"is_edit_check"];
        self.is_main_check = dict[@"is_main_check"];
        self.is_pro = dict[@"is_pro"];
        self.is_pro_check = dict[@"is_pro_check"];
        self.is_public = dict[@"is_public"];
        self.nowlevel = dict[@"nowlevel"];
        self.overlook_num = dict[@"overlook_num"];
        self.public_id = dict[@"public_id"];
        self.recom_num = dict[@"recom_num"];
        self.support_num = dict[@"support_num"];
        self.user_id = dict[@"user_id"];
        self.headimg = dict[@"headimg"];
        self.user_name = dict[@"user_name"];
        
    }
    return self;
}

+ (instancetype)pageWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
