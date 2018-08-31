//
//  DetailTableViewCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/5.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DetailTableViewCell.h"


@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.mainTitle.font = BOLDSYSTEMFONT(16);
    
    UITapGestureRecognizer *tapRecognizerWeibo=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPublishWithTag:)];
    
    self.userName.userInteractionEnabled=YES;
    [self.userName addGestureRecognizer:tapRecognizerWeibo];
    
//    [self.headImage addTarget:self action:@selector(pushPublishWithTag:) forControlEvents:UIControlEventTouchUpInside];

    self.headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.frame)/2;//半径大小
    self.headImage.layer.masksToBounds = YES;//是否切割
    
    self.headImage1.layer.cornerRadius = CGRectGetHeight(self.headImage1.frame)/2;//半径大小
    self.headImage1.layer.masksToBounds = YES;//是否切割
    
    self.headImage3.layer.cornerRadius = CGRectGetHeight(self.headImage3.frame)/2;//半径大小
    self.headImage3.layer.masksToBounds = YES;//是否切割
    
    if (kDevice_Is_iPhone5) {
        self.mainTitle.font = BOLDSYSTEMFONT(14);
        self.mainTitle1.font = BOLDSYSTEMFONT(14);
        self.mainTitle3.font = BOLDSYSTEMFONT(14);
    }
    if (kDevice_Is_iPhone4) {
        self.mainTitle.font = BOLDSYSTEMFONT(14);
        self.mainTitle1.font = BOLDSYSTEMFONT(14);
        self.mainTitle3.font = BOLDSYSTEMFONT(14);
    }
    
}


/**
 设置行间距
 */
-(void)setWordSpace{
    //4行间距
    if (!kStringIsEmpty(self.pageDetail.text)) {
        
        [DetailTableViewCell changeWordSpaceForLabel:self.pageDetail WithSpace:1.5 highSpace:2.5];
        self.pageDetail.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (!kStringIsEmpty(self.mainTitle.text)) {
        
        [DetailTableViewCell changeWordSpaceForLabel:self.mainTitle WithSpace:1 highSpace:4];
        self.mainTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (!kStringIsEmpty(self.mainTitle1.text)) {
        
        [DetailTableViewCell changeWordSpaceForLabel:self.mainTitle1 WithSpace:1 highSpace:4];
        self.mainTitle1.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (!kStringIsEmpty(self.pageDetail1.text)) {
        
        [DetailTableViewCell changeWordSpaceForLabel:self.pageDetail1 WithSpace:1 highSpace:2.5];
        self.pageDetail1.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    if (!kStringIsEmpty(self.pageDetail3.text)) {
        
        [DetailTableViewCell changeWordSpaceForLabel:self.pageDetail3 WithSpace:1 highSpace:2.5] ;
        self.pageDetail3.lineBreakMode = NSLineBreakByTruncatingTail;
    }
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
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lab.text length])];
    lab.attributedText = attributedString;
}
//- (IBAction)pushPublishWithTag:(NSInteger *)sender {
//}

//点击头像和用户名,弹出发表人页
-(void)pushPublishWithTag:(NSInteger)tag{
    [self.delegate pushPublishPersonVc:self.headTag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
}

@end
