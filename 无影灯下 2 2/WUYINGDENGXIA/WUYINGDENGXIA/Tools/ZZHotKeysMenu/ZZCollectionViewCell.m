//
//  ZZCollectionViewCell.m
//  ZZHotKeysMenu
//
//  Created by 周晓瑞 on 2018/3/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZCollectionViewCell.h"

@interface ZZCollectionViewCell()

@end

@implementation ZZCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

#pragma mark - Commit
- (void)setUp{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = RGB(221, 221, 221).CGColor;
    [self msgLab];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat boundMargin = 10.0f;
    CGFloat ory = 0.0f;
    
    self.hkLab.frame = CGRectMake(boundMargin,ory,self.contentView.bounds.size.width - 2 * boundMargin, self.contentView.bounds.size.height - 2 * ory);
    self.contentView.layer.cornerRadius = self.contentView.bounds.size.height * 0.5;
}

- (UILabel *)msgLab{
    if (_hkLab == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment= NSTextAlignmentCenter;
        label.textColor=RGB51;
        label.font=[UIFont systemFontOfSize:13];
        label.numberOfLines=0;
        [self.contentView addSubview:label];
        _hkLab = label;
    }
    return _hkLab;
}
@end
