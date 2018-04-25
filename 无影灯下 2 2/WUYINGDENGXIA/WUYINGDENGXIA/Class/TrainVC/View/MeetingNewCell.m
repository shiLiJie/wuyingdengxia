//
//  MeetingNewCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MeetingNewCell.h"

@implementation MeetingNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.meetImage.layer.cornerRadius = 5;//半径大小
    self.meetImage.layer.masksToBounds = YES;//是否切割
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
