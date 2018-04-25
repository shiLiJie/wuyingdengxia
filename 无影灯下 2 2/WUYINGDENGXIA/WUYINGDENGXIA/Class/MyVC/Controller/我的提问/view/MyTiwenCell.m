//
//  MyTiwenCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyTiwenCell.h"

@implementation MyTiwenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUIWithchooseType:(chooseType)chooseType{
    switch (chooseType) {
        case waitType:
            self.typeLab.text = @"未解决";
            self.typeLab.textColor = RGB(252, 186, 42);
            break;
        case susscessType:
            self.typeLab.text = @"已解决";
            self.typeLab.textColor = RGB(19, 151, 255);
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
