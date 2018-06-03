//
//  MyfensiModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyfensiModel : NSObject

@property (nonatomic, copy) NSString *fansid;//id

@property (nonatomic, copy) NSString *fansname;//id

@property (nonatomic, copy) NSString *fansnum;//id

@property (nonatomic, copy) NSString *isfinish_cert;//

@property (nonatomic, copy) NSString *fanshead;//

@property (nonatomic, copy) NSString *is_follow;//




+ (instancetype)MyfensiWithDict:(NSDictionary *)dict;

@end
