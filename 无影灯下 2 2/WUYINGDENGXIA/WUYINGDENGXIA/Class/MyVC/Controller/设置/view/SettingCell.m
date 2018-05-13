//
//  SettingCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
