//
//  MyHuidaCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyHuidaCell.h"

@implementation MyHuidaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setLabelHangjianj:self.detailLab];
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
