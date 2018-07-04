//
//  meetingDetailModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/5.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface meetingDetailModel : NSObject

@property (nonatomic, copy) NSString *begin_time;//id
@property (nonatomic, copy) NSString *city;//
@property (nonatomic, copy) NSString *country;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *isfinish;//

@property (nonatomic, copy) NSString *meet_address;//
@property (nonatomic, copy) NSString *meet_content;//

@property (nonatomic, copy) NSDictionary *meet_date;//
@property (nonatomic, copy) NSString *meet_talk;//

@property (nonatomic, copy) NSString *meet_id;//


@property (nonatomic, copy) NSString *meet_title;//
@property (nonatomic, copy) NSString *meeting_image;//
@property (nonatomic, copy) NSString *province;//
@property (nonatomic, copy) NSString *is_attend;//


+ (instancetype)meedetailtWithDict:(NSDictionary *)dict;

@end
