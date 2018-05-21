//
//  huocheModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface huocheModel : NSObject

@property (nonatomic, copy) NSString *start_station;//出发站
@property (nonatomic, copy) NSString *start_time;//出发时间

@property (nonatomic, copy) NSString *end_station;//到达站
@property (nonatomic, copy) NSString *end_time;//到达时间

@property (nonatomic, copy) NSString *run_time;//运行时间

@property (nonatomic, copy) NSString *train_no;//车次



+ (instancetype)huochepiaoWithDict:(NSDictionary *)dict;

@end
