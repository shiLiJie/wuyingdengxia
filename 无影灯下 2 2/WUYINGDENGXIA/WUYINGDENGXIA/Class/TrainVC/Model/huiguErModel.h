//
//  huiguErModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface huiguErModel : NSObject

@property (nonatomic, copy) NSString *comment_num;//id
@property (nonatomic, copy) NSString *meeting_content;//
@property (nonatomic, copy) NSString *meeting_specialist;//
@property (nonatomic, copy) NSString *meeting_title;//
@property (nonatomic, copy) NSString *replay_id;//
@property (nonatomic, copy) NSString *replay_sub_id;//
@property (nonatomic, copy) NSString *support_num;//
@property (nonatomic, copy) NSString *video_url;//
@property (nonatomic, copy) NSString *play_num;//


//往期回顾二级装模型
+ (instancetype)huiguErWithDict:(NSDictionary *)dict;
//收藏转模型
+ (instancetype)huiguShoucangWithDict:(NSDictionary *)dict;

@end
