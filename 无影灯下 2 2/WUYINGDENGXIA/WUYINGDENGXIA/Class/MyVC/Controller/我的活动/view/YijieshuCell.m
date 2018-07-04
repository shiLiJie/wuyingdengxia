//
//  YijieshuCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "YijieshuCell.h"

@implementation YijieshuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image.clipsToBounds = YES;
}

-(void)setUpUi:(chooseType)choosetype{
    switch (choosetype) {
        case yiqiandaoType:
            self.qiandaoLab.text = @"已签到";
            self.qiandaoLab.textColor = RGB(74, 206, 172);
            break;
        case weiqiandaoType:
            self.qiandaoLab.text = @"未签到";
            self.qiandaoLab.textColor = RGB(252, 186, 42);
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
