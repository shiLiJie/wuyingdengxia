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
        self.banner_id = dict[@"banner_id"];
        self.banner_imgpath = dict[@"banner_imgpath"];
        self.banner_link = dict[@"banner_link"];
        self.banner_title = dict[@"banner_title"];
        self.banner_type = dict[@"banner_type"];
        self.ctime = dict[@"ctime"];
        self.have_ballot = dict[@"have_ballot"];
        self.img_id = dict[@"img_id"];
        self.news_ballot_id = dict[@"news_ballot_id"];
    }
    return self;
}

+ (instancetype)QusetionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
