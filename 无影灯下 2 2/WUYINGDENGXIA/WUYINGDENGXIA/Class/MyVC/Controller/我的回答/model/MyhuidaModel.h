//
//  MyhuidaModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyhuidaModel : NSObject

@property (nonatomic, copy) NSString *answer_content;//id
@property (nonatomic, copy) NSString *answer_id;//id
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *headimg;//
@property (nonatomic, copy) NSString *is_solve;//
@property (nonatomic, copy) NSString *is_take;//
@property (nonatomic, copy) NSString *moon_cash;//
@property (nonatomic, copy) NSString *question_content;//
@property (nonatomic, copy) NSString *question_id;//
@property (nonatomic, copy) NSString *question_title;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *user_name;//



+ (instancetype)MyhuidaWithDict:(NSDictionary *)dict;

@end
