//
//  MyDuihuanCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyDuihuanCell.h"

@implementation MyDuihuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.image.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
