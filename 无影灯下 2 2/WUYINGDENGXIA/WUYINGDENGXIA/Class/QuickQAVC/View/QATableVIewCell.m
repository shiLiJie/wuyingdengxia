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
    
    
    
    
    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
    
    self.headImage1.layer.cornerRadius = CGRectGetHeight(self.headImage1.frame)/2;;//半径大小
    self.headImage1.layer.masksToBounds = YES;//是否切割
    
    self.headImage2.layer.cornerRadius = CGRectGetHeight(self.headImage2.frame)/2;;//半径大小
    self.headImage2.layer.masksToBounds = YES;//是否切割
    
    
    self.image1.clipsToBounds = YES;
    self.image21.clipsToBounds = YES;
    self.image22.clipsToBounds = YES;
    self.image23.clipsToBounds = YES;
}

#pragma mark - 按钮点击方法 -
//点击头像跳转到用户详情页
- (IBAction)headImageToUserDetail:(UIButton *)sender {
    
    [self.delegate tableviewDidSelectUserHeadImage:sender.tag];
    
}
//点击回答按钮点击到回答页面
- (IBAction)answerToAnswerPage:(UIButton *)sender {
    
}


/**
 设置行间距
 */
-(void)setLabelSpace{
    if (!kStringIsEmpty(self.detailPage.text)) {
        [self setLabelHangjianj:self.detailPage];
        [QATableVIewCell changeWordSpaceForLabel:self.detailPage WithSpace:1.5 highSpace:1];
        
    }
    if (!kStringIsEmpty(self.detailPage2.text)) {
        [self setLabelHangjianj:self.detailPage2];
        [QATableVIewCell changeWordSpaceForLabel:self.detailPage2 WithSpace:1.5 highSpace:1];
        
    }
    if (!kStringIsEmpty(self.mainTitle1.text)) {
        [self setLabelHangjianj:self.mainTitle1];
        [QATableVIewCell changeWordSpaceForLabel:self.mainTitle1 WithSpace:1 highSpace:4];
        
    }
//    if (!kStringIsEmpty(self.detailPage1.text)) {
//        [self setLabelHangjianj:self.detailPage1];
//        [QATableVIewCell changeWordSpaceForLabel:self.detailPage1 WithSpace:1.5 highSpace:1];
//
//    }
//    if (!kStringIsEmpty(self.detailPage1.text)) {
//        [self setLabelHangjianj:self.detailPage2];
//        [QATableVIewCell changeWordSpaceForLabel:self.detailPage WithSpace:1.5 highSpace:1];
//
//    }
}

/**
 间距
 
 @param label lab
 @param space 字间距
 @param highSpace 行间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space highSpace:(float)highSpace{
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = highSpace;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

-(void)setLabelHangjianj:(UILabel *)lab{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lab.text length])];
    lab.attributedText = attributedString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
