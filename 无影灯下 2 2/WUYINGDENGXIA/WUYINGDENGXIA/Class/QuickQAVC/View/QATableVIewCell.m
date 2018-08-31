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
    
    self.niimage1.clipsToBounds = YES;
    self.niimage21.clipsToBounds = YES;
    self.niimage22.clipsToBounds = YES;
    self.niimage23.clipsToBounds = YES;
    
    //吸顶
//    [self.mainTitle alignTop];
//    [self.mainTitle1 alignTop];
//    [self.mainTitle2 alignTop];
//    [self.nimainTitle alignTop];
//    [self.nimainTitle1 alignTop];
//    [self.nimainTitle2 alignTop];
    
    [self.mainTitle sizeToFit];
    [self.mainTitle1 sizeToFit];
    [self.mainTitle2 sizeToFit];
    [self.nimainTitle sizeToFit];
    [self.nimainTitle1 sizeToFit];
    [self.nimainTitle2 sizeToFit];
    
    if (kDevice_Is_iPhone5) {
        self.mainTitle.font = BOLDSYSTEMFONT(14);
        self.mainTitle1.font = BOLDSYSTEMFONT(14);
        self.mainTitle2.font = BOLDSYSTEMFONT(14);
        self.nimainTitle.font = BOLDSYSTEMFONT(14);
        self.nimainTitle1.font = BOLDSYSTEMFONT(14);
        self.nimainTitle2.font = BOLDSYSTEMFONT(14);
    }
    if (kDevice_Is_iPhone4) {
        self.mainTitle.font = BOLDSYSTEMFONT(14);
        self.mainTitle1.font = BOLDSYSTEMFONT(14);
        self.mainTitle2.font = BOLDSYSTEMFONT(14);
        self.nimainTitle.font = BOLDSYSTEMFONT(14);
        self.nimainTitle1.font = BOLDSYSTEMFONT(14);
        self.nimainTitle2.font = BOLDSYSTEMFONT(14);
    }

}


/**
 给标题前添加月亮币

 @param mooncash 月亮币个数
 @param title 标题
 */
-(void)setTitleLabMoonCash:(NSString *)mooncash
                     title:(NSString *)title
                     lable:(UILabel *)lable{

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",mooncash,title]];

    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"yueliangbi-1"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, -3, 16, 16);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(252, 168, 42) range:NSMakeRange(1, mooncash.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, mooncash.length)];
    
    [attri addAttributes:@{NSKernAttributeName:@(1)} range:NSMakeRange(mooncash.length, [title length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    
    lable.attributedText = attri;
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
        [QATableVIewCell changeWordSpaceForLabel:self.detailPage WithSpace:1.5 highSpace:1.5];
        self.detailPage.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (!kStringIsEmpty(self.detailPage2.text)) {
        [self setLabelHangjianj:self.detailPage2];
        [QATableVIewCell changeWordSpaceForLabel:self.detailPage2 WithSpace:1.5 highSpace:1.5];
        self.detailPage2.lineBreakMode = NSLineBreakByTruncatingTail;
    }
//    if (!kStringIsEmpty(self.mainTitle1.text)) {
//        [self setLabelHangjianj:self.mainTitle1];
//        [QATableVIewCell changeWordSpaceForLabel:self.mainTitle1 WithSpace:1 highSpace:4];
//        
//    }
    
    if (!kStringIsEmpty(self.nidetailPage.text)) {
        [self setLabelHangjianj:self.nidetailPage];
        [QATableVIewCell changeWordSpaceForLabel:self.nidetailPage WithSpace:1.5 highSpace:1.5];
        self.nidetailPage.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (!kStringIsEmpty(self.nidetailPage2.text)) {
        [self setLabelHangjianj:self.nidetailPage2];
        [QATableVIewCell changeWordSpaceForLabel:self.nidetailPage2 WithSpace:1.5 highSpace:1.5];
        self.nidetailPage2.lineBreakMode = NSLineBreakByTruncatingTail;
    }
//    if (!kStringIsEmpty(self.nimainTitle1.text)) {
//        [self setLabelHangjianj:self.nimainTitle1];
//        [QATableVIewCell changeWordSpaceForLabel:self.nimainTitle1 WithSpace:1 highSpace:4];
//
//    }
    
    
    
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
