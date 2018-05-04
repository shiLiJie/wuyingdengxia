//
//  bannermodel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bannermodel : NSObject

@property (nonatomic, copy) NSString *banner_id;//id
@property (nonatomic, copy) NSString *banner_imgpath;//
@property (nonatomic, copy) NSString *banner_link;//
@property (nonatomic, copy) NSString *banner_title;//
@property (nonatomic, copy) NSString *banner_type;//
@property (nonatomic, copy) NSString *ctime;//
@property (nonatomic, copy) NSString *have_ballot;//
@property (nonatomic, copy) NSString *img_id;//
@property (nonatomic, copy) NSString *news_ballot_id;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)bannerWithDict:(NSDictionary *)dict;

@end
