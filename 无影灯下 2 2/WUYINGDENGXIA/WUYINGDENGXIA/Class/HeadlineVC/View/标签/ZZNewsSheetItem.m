//
//  ZZNewsSheetItem.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZZNewsSheetItem.h"
#import "ZZNewsSheetConfig.h"
static NSTimeInterval const kAnimationItemDuration = 0.25f;

@interface ZZNewsSheetItem()
@property(nonatomic,weak)UIButton *closeButton;
@property(nonatomic,weak)UILabel *itemTitleLab;
@property(nonatomic,weak)UIImageView *btnImage;

@end

@implementation ZZNewsSheetItem

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [ZZNewsSheetConfig defaultCofing].sheetItemSize;
    CGFloat buttonWidth = size.width / 5.0;
    CGFloat buttonHeight = size.width / 5.0;
    self.closeButton.frame = CGRectMake(self.frame.size.width - 0.8 * buttonWidth, -0.3 * buttonWidth, buttonWidth, buttonHeight);
    self.closeButton.layer.cornerRadius = buttonWidth / 2.0f;
    self.itemTitleLab.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.btnImage.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    

}

- (void)setFlagType:(ZZCornerFlagType)flagType{
    _flagType = flagType;
    
    if (flagType == ZZCornerFlagTypeNone) {
        self.closeButton.hidden = NO;
        return;
    }
    
     BOOL isShakeAnimation = [ZZNewsSheetConfig defaultCofing].isShakeAnimation;
    if (self.flagType == ZZCornerFlagTypeDelete) {
        if (isShakeAnimation) {
            [self startShakeAnimation];
            
            self.closeButton.hidden = NO;
            [self.closeButton setBackgroundImage:GetImage(@"cha-1") forState:UIControlStateNormal];
//            [self.closeButton setBackgroundColor:RGB(237, 86, 89)];
            
//            __weak typeof(self) weakSelf = self;
//            self.huanyipi = ^(BOOL ishuanyipi) {
//                if (ishuanyipi) {
//                    [weakSelf.closeButton setBackgroundImage:GetImage(@"") forState:UIControlStateNormal];
//                }else{
//                    [weakSelf.closeButton setBackgroundImage:GetImage(@"cha-1") forState:UIControlStateNormal];
//                }
//
//            };
            
            
            self.layer.borderWidth = 0;
            self.layer.borderColor = [RGB(221, 221, 221) CGColor];
            self.backgroundColor = RGB(45, 163, 255);
            self.itemTitleLab.textColor = [UIColor whiteColor];
            
        }
    }else{
        if (isShakeAnimation) {
             [self removeAnimation];
            
            self.closeButton.hidden = YES;
            
//            [self.closeButton setBackgroundColor:RGB(237, 86, 89)];
            
            self.backgroundColor = RGB(255, 255, 255);
            self.itemTitleLab.textColor = RGB(51, 51, 51);
            self.layer.borderWidth = 0.5;
            self.layer.borderColor = [RGB(221, 221, 221) CGColor];
            
//            NSString * title = self.cornerFlagDictionary[[NSString stringWithFormat:@"%d",(int)flagType]];
//            [self.closeButton setTitle:@"+" forState:UIControlStateNormal];
            
            
        }
    }
    
    NSString * title = self.cornerFlagDictionary[[NSString stringWithFormat:@"%d",(int)flagType]];
    
    
//    [self.closeButton setTitle:title forState:UIControlStateNormal];
    
//    if ([title isEqualToString:@"X"]) {
//
//        [self.closeButton setBackgroundColor:RGB(237, 86, 89)];
//        [self.closeButton setTitle:title forState:UIControlStateNormal];
//    }else{
//        [self.closeButton setBackgroundImage:GetImage(@"cha-1") forState:UIControlStateNormal];
//    }
}

- (void)setItemTitle:(NSString *)itemTitle{
    _itemTitle = [itemTitle copy];
    self.itemTitleLab.text = itemTitle;
}
- (void)setCornerFlagHidden:(BOOL)cornerFlagHidden{
    _cornerFlagHidden = cornerFlagHidden;
    
    self.longGestureEnable = !cornerFlagHidden;
    if (self.flagType != ZZCornerFlagTypeDelete && self.flagType != ZZCornerFlagTypeAddition) {
        self.longGestureEnable = NO;
    }
    
    [self commintAnimation:cornerFlagHidden];
}

- (void)commintAnimation:(BOOL)hidden{
    BOOL isShakeAnimation = [ZZNewsSheetConfig defaultCofing].isShakeAnimation;
    NSTimeInterval animationDuration = isShakeAnimation ? kAnimationItemDuration : 0.0f;
    if (hidden) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.closeButton.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (isShakeAnimation) {
                 [self removeAnimation];
            }
        }];
    }else{
        [UIView animateWithDuration:animationDuration animations:^{
            self.closeButton.alpha = 1.0f;
        } completion:^(BOOL finished) {
            if (self.flagType == ZZCornerFlagTypeDelete) {
                if (isShakeAnimation) {
                     [self startShakeAnimation];
                }
            }
        }];
    }
}

- (void)removeAnimation{
    [self.layer removeAllAnimations];
}

- (void)startShakeAnimation{
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAnimation.values = @[@(-0.03),@0.03,@(-0.03)];
    
    CGFloat timeArc = (arc4random() % 9 + 1 ) * 0.01;
    shakeAnimation.timeOffset = [self.layer convertTime:CACurrentMediaTime()+timeArc 
                                                toLayer:nil];
    
//    shakeAnimation.duration = 0.3f;
    shakeAnimation.fillMode = kCAFillModeForwards;
    shakeAnimation.repeatCount = HUGE_VAL;
    shakeAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:shakeAnimation forKey:@"shake"];
}

#pragma mark - SetUp
- (void)defaultConfig{
    self.backgroundColor = [ZZNewsSheetConfig defaultCofing].sheetBackgroundColor;
    self.layer.cornerRadius = 17.0f;
}
- (void)setUp{
    [self defaultConfig];
    [self addTipsLab];
    [self addCloseButton];
    [self addLongPanGesture];
}
- (void)addTipsLab{
    
    ////////////////////给标签添加图片/////////////////////////
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"Snip20180109_1"];
    [self addSubview:image];
    self.btnImage = image;
    
    
    UILabel *tLab = [[UILabel alloc]init];
    tLab.textColor = [ZZNewsSheetConfig defaultCofing].sheetItemTitleColor;
    tLab.font = [ZZNewsSheetConfig defaultCofing].sheetItemFont;
    tLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tLab];
    self.itemTitleLab = tLab;
    

}

- (void)addCloseButton{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeButton setTitle:@"X" forState:UIControlStateNormal];
//    [closeButton setBackgroundImage:GetImage(@"cha-1") forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [closeButton addTarget:self action:@selector(zz_close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    self.closeButton = closeButton;
    closeButton.backgroundColor = [ZZNewsSheetConfig defaultCofing].closeBackgroundColor;
}

- (void)addLongPanGesture{
    UILongPressGestureRecognizer * ges = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPanGesture:)];
    [self addGestureRecognizer:ges];
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zz_close)];
    [self addGestureRecognizer:ges1];
}

- (NSDictionary *)cornerFlagDictionary{
    return @{
        @"1":@"X",
        @"2":@"+"
        };
}

#pragma mark -  事件处理
- (void)longPanGesture:(UILongPressGestureRecognizer*)ges{
    if (!self.isGestureEnable) 
        return;
    if (self.flagType == ZZCornerFlagTypeAddition) {
        return;
    }
    
    if (self.longPressBlock) {
        self.longPressBlock(ges);
    }
}

- (void)zz_close{
    if (!self.isGestureEnable) {
        return;
    }
    
    if (self.itemCloseBlock) {
        self.itemCloseBlock(self);
    }
}



@end
