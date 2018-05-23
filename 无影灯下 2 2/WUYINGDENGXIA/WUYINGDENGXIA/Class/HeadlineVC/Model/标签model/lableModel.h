//
//  lableModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lableModel : NSObject

@property (nonatomic, copy) NSString *name;//id
@property (nonatomic, copy) NSString *label_id;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *key_num;//

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)lableWithDict:(NSDictionary *)dict;
@end
