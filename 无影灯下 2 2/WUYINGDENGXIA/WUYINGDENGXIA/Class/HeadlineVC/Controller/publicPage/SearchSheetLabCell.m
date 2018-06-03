//
//  SearchSheetLabCell.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "SearchSheetLabCell.h"

@interface SearchSheetLabCell()


@end

@implementation SearchSheetLabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selecttype = noSelect;
}


/**
 是否选中更改cell

 @param selecttype selecttype description
 */
-(void)changeCellWithSelectType{
    
    switch (self.selecttype) {
        case isSelect:
            self.lableImage.image = GetImage(@"duihao1");
            break;
        case noSelect:
            self.lableImage.image = GetImage(@"duihao");
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
