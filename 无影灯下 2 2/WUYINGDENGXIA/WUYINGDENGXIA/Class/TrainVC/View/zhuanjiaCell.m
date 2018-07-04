//
//  zhuanjiaCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "zhuanjiaCell.h"

@implementation zhuanjiaCell

//-(void)layoutSubviews{
////    [self.zhuanjiaDetail alignTop];
////    [self.zhuanjiaDetail sizeToFit];
//}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.zhuangjiaImage.clipsToBounds = YES;
    
}

@end
