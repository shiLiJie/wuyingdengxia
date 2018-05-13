//
//  XuyuanJiluCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XuyuanJiluCell.h"

@implementation XuyuanJiluCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUIWithchooseType:(chooseType)chooseType{
    switch (chooseType) {
        case waitType:
            self.zhuangtaiLab.text = @"许愿中";
            self.zhuangtaiLab.textColor = RGB(252, 186, 42);
            break;
        case susscessType:
            self.zhuangtaiLab.text = @"实现";
            self.zhuangtaiLab.textColor = RGB(19, 151, 255);
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
