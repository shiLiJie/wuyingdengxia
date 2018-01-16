//
//  QATableVIewCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "QATableVIewCell.h"

@implementation QATableVIewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - 按钮点击方法 -
//点击头像跳转到用户详情页
- (IBAction)headImageToUserDetail:(UIButton *)sender {
    
    [self.delegate tableviewDidSelectUserHeadImage:sender.tag];
    
}
//点击回答按钮点击到回答页面
- (IBAction)answerToAnswerPage:(UIButton *)sender {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
