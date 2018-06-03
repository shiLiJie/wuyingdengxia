//
//  searchResultModel.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "searchResultModel.h"


@implementation searchResultModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.content = dict[@"content"];
        self.ctime = dict[@"ctime"];
        self.type_id = dict[@"id"];
        self.title = dict[@"title"];
        self.type = dict[@"type"];
    }
    return self;
}

+ (instancetype)searchResultWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
