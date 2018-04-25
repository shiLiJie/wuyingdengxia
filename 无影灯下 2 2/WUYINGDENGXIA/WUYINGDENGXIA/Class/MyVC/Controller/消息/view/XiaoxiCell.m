//
//  XiaoxiCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XiaoxiCell.h"

@implementation XiaoxiCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setUpImage{
    switch (self.xiaoxiType) {
        case canhuiType:
            self.xiaoxiImage.image = GetImage(@"wodetougaoicon");
            break;
        case tuigaoType:
            self.xiaoxiImage.image = GetImage(@"wodetougaoicon");
            break;
        case xitongType:
            self.xiaoxiImage.image = GetImage(@"每日签到");
            break;
        case wenjuanType:
            self.xiaoxiImage.image = GetImage(@"wenjuanicon");
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
