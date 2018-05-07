//
//  huiguModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/5.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface huiguModel : NSObject
@property (nonatomic, copy) NSString *abstract;//id
@property (nonatomic, copy) NSString *begin_time;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *maintalk;//
@property (nonatomic, copy) NSString *meeting_content;//
@property (nonatomic, copy) NSArray *meeting_specialist;//
@property (nonatomic, copy) NSArray *meeting_title;//
@property (nonatomic, copy) NSString *moon_cash;//
@property (nonatomic, copy) NSString *play_id;//
@property (nonatomic, copy) NSString *play_num;//
@property (nonatomic, copy) NSString *recom_num;//
@property (nonatomic, copy) NSString *replay_id;//
@property (nonatomic, copy) NSString *replay_title;//
@property (nonatomic, copy) NSString *suport_num;//


+ (instancetype)huiguWithDict:(NSDictionary *)dict;

@end
