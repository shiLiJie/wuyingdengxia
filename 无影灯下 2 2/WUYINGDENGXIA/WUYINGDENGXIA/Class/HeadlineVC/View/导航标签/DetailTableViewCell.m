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
    
    self.headImage = 0;
    
    self.mainTitle.font = BOLDSYSTEMFONT(16);
    
    UITapGestureRecognizer *tapRecognizerWeibo=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPublishWithTag:)];
    
    self.userName.userInteractionEnabled=YES;
    [self.userName addGestureRecognizer:tapRecognizerWeibo];
    
    [self.headImage addTarget:self action:@selector(pushPublishWithTag:) forControlEvents:UIControlEventTouchUpInside];
    //4行间距
    [self setLabelHangjianj:self.pageDetail];
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
