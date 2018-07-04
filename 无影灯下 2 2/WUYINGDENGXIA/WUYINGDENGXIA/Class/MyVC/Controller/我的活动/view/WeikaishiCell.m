//
//  WeikaishiCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "WeikaishiCell.h"

@implementation WeikaishiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.image.clipsToBounds = YES;
}

-(void)setUpUi:(chooseType)choosetype{
    switch (choosetype) {
        case shenhezhongType:
            self.qiandaoLab.text = @"审核中";
            self.qiandaoLab.textColor = RGB(252, 186, 42);
            break;
        case weiqiandaoType:
            self.qiandaoLab.text = @"审核通过";
            self.qiandaoLab.textColor = RGB(151, 151, 151);
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
