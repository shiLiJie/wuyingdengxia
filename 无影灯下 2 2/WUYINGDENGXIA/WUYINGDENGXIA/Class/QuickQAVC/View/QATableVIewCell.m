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
    [self setLabelHangjianj:self.detailPage];
    
    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
}

#pragma mark - 按钮点击方法 -
//点击头像跳转到用户详情页
- (IBAction)headImageToUserDetail:(UIButton *)sender {
    
    [self.delegate tableviewDidSelectUserHeadImage:sender.tag];
    
}
//点击回答按钮点击到回答页面
- (IBAction)answerToAnswerPage:(UIButton *)sender {
    
}


-(void)setLabelHangjianj:(UILabel *)lab{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lab.text length])];
    lab.attributedText = attributedString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
