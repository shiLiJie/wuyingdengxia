//
//  XWScanImage.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XWScanImage : NSObject
/**
 *  浏览大图
 *
 *  @param scanImageView 图片所在的imageView
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview;
@end
