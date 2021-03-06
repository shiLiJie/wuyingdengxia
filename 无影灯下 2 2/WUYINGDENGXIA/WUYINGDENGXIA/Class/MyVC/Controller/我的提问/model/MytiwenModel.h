//
//  MytiwenModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MytiwenModel : NSObject

@property (nonatomic, copy) NSString *answer_num;//id
@property (nonatomic, copy) NSString *ctime;//id
@property (nonatomic, copy) NSString *failreason;//
@property (nonatomic, copy) NSString *is_con_check;//
@property (nonatomic, copy) NSString *is_pro_check;//
@property (nonatomic, copy) NSString *is_solve;//
@property (nonatomic, copy) NSString *moon_cash;//
@property (nonatomic, copy) NSString *nowlevel;//
@property (nonatomic, copy) NSString *ques_answer;//
@property (nonatomic, copy) NSString *question_content;//
@property (nonatomic, copy) NSString *question_id;//
@property (nonatomic, copy) NSString *question_image;//
@property (nonatomic, copy) NSString *question_tags;//
@property (nonatomic, copy) NSString *question_title;//
@property (nonatomic, copy) NSString *question_type_id;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *username;//


+ (instancetype)QusetionwenWithDict:(NSDictionary *)dict;

@end
