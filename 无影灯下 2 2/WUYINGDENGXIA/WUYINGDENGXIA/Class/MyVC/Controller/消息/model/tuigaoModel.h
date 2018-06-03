//
//  tuigaoModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tuigaoModel : NSObject

@property (nonatomic, copy) NSString *wish_id;//id
@property (nonatomic, copy) NSString *status;//id
@property (nonatomic, copy) NSString *wish_content;//
@property (nonatomic, copy) NSString *moon_cash;//
@property (nonatomic, copy) NSString *ctime;//




+ (instancetype)tuigaoWithDict:(NSDictionary *)dict;

@end
