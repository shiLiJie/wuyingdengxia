//
//  MyGuanzhuCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyGuanzhuCell.h"

@implementation MyGuanzhuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.guanzhuBtn.layer.cornerRadius = CGRectGetHeight(self.guanzhuBtn.frame)/2;//半径大小
    self.guanzhuBtn.layer.masksToBounds = YES;//是否切割
}

-(void)setUIWithchooseType:(chooseType)chooseType{
    switch (chooseType) {
        case weiguanzhuType:
            [self.guanzhuBtn setTitle:@"关注" forState:UIControlStateNormal];
            [self.guanzhuBtn setBackgroundColor:RGB(252, 186, 42)];
            
            break;
        case guanzhuType:
            [self.guanzhuBtn setTitle:@"未关注" forState:UIControlStateNormal];
            [self.guanzhuBtn setBackgroundColor:RGB(233, 233, 233)];
            
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
