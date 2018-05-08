//
//  huiguDetailModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface huiguDetailModel : NSObject

@property (nonatomic, copy) NSString *replay_title;//
@property (nonatomic, copy) NSString *maintalk;//主讲
@property (nonatomic, copy) NSString *playnum;//
@property (nonatomic, copy) NSString *playpath;//
@property (nonatomic, copy) NSString *abstract;//id
@property (nonatomic, copy) NSString *begintime;//
@property (nonatomic, copy) NSString *meeting_content;//
@property (nonatomic, copy) NSString *meeting_specialist;//
@property (nonatomic, copy) NSString *meeting_title;//
@property (nonatomic, copy) NSString *recom_num;//
@property (nonatomic, copy) NSString *suport_num;//播放地址








+ (instancetype)huiguDetailWithDict:(NSDictionary *)dict;

@end
