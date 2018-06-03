//
//  searchResultModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchResultModel : NSObject

@property (nonatomic, copy) NSString *content;//id
@property (nonatomic, copy) NSString *ctime;//id
@property (nonatomic, copy) NSString *type_id;//id
@property (nonatomic, copy) NSString *title;//id
@property (nonatomic, copy) NSString *type;//id


+ (instancetype)searchResultWithDict:(NSDictionary *)dict;

@end
