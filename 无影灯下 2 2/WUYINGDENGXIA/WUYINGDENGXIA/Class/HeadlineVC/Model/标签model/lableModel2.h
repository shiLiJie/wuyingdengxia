//
//  lableModel2.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lableModel2 : NSObject

@property (nonatomic, copy) NSString *label_name;//id
@property (nonatomic, copy) NSString *label_id;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *label_type;//


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)lable2WithDict:(NSDictionary *)dict;

@end
