//
//  ChooseCarGCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "ChooseCarGCell.h"

@implementation ChooseCarGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backView.layer.cornerRadius = 5;//半径大小
    self.backView.layer.masksToBounds = YES;//是否切割
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
