//
//  hotKeyModel.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotKeyModel : NSObject

@property (nonatomic, copy) NSString *search_content;//id
//@property (nonatomic, copy) NSString *count(search_content);//

+ (instancetype)hotKeyWithDict:(NSDictionary *)dict;

@end
