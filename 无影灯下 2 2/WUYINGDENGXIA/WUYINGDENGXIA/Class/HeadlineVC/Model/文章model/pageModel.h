//
//  pageModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pageModel : NSObject

@property (nonatomic, copy) NSString *article_author;//id
@property (nonatomic, copy) NSString *article_class;//
@property (nonatomic, copy) NSString *article_content;//
@property (nonatomic, copy) NSString *article_id;//
@property (nonatomic, copy) NSString *article_img_path;//
@property (nonatomic, copy) NSString *article_moon_cash;//
@property (nonatomic, copy) NSString *article_tags;//
@property (nonatomic, copy) NSString *article_title;//
@property (nonatomic, copy) NSString *article_type;//
@property (nonatomic, copy) NSString *change_id;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *failreason;//
@property (nonatomic, copy) NSString *is_check;//
@property (nonatomic, copy) NSString *is_edit_check;//
@property (nonatomic, copy) NSString *is_main_check;//
@property (nonatomic, copy) NSString *is_pro;//
@property (nonatomic, copy) NSString *is_pro_check;//
@property (nonatomic, copy) NSString *is_public;//
@property (nonatomic, copy) NSString *nowlevel;//
@property (nonatomic, copy) NSString *overlook_num;//
@property (nonatomic, copy) NSString *public_id;//
@property (nonatomic, copy) NSString *recom_num;//
@property (nonatomic, copy) NSString *support_num;//
@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *headimg;//
@property (nonatomic, copy) NSString *user_name;//

+ (instancetype)pageWithDict:(NSDictionary *)dict;

@end
