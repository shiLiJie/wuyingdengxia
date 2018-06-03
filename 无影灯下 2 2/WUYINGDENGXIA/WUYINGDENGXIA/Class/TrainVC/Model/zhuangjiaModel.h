//
//  zhuangjiaModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zhuangjiaModel : NSObject

@property (nonatomic, copy) NSString *meet_id;//出发站
@property (nonatomic, copy) NSString *meet_talk_content;//出发时间

@property (nonatomic, copy) NSString *meet_talk_id;//到达站
@property (nonatomic, copy) NSString *meet_talk_name;//到达时间

@property (nonatomic, copy) NSString *specialist_image;//到达时间




+ (instancetype)zhuagnjiaWithDict:(NSDictionary *)dict;

@end
