//
//  ziliaoCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "ziliaoCell.h"



@implementation ziliaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addTargetMethod];
    
    self.renzhengBtn.layer.cornerRadius = CGRectGetHeight(self.renzhengBtn.frame)/2;//半径大小
    self.renzhengBtn.layer.masksToBounds = YES;//是否切割
    
    self.headBtn.layer.cornerRadius = CGRectGetHeight(self.headBtn.frame)/2;//半径大小
    self.headBtn.layer.masksToBounds = YES;//是否切割
    
}



-(void)addTargetMethod{
    [self.textfield addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingDidEnd];
}
-(void)textField1TextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    self.ziliaoCellBlcok(textField.text, textField.tag);
    if (textField.text.length) {
        
    }else{
        
    }
}
//认证按钮点击
- (IBAction)renzhengClick:(UIButton *)sender {

    [self.textfield resignFirstResponder];
    self.renzhengBlcok();
}
//点击头像
- (IBAction)headImageClick:(UIButton *)sender {

    [self.textfield resignFirstResponder];
    self.touxiangBlcok();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
