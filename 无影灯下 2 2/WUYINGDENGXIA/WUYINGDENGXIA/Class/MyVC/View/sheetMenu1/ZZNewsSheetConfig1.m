//
//  ZZNewsSheetConfig.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZZNewsSheetConfig1.h"


@implementation ZZNewsSheetConfig1

- (instancetype)init{
    if (self = [super init]) {
        [self commit];
    }
    return self;
}
- (void)commit{
    self.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    self.sheetBackgroundColor = RGB(45, 163, 255);
    self.isShakeAnimation = YES;
    self.sheetMaxColumn = 3;
//    self.closeBackgroundColor = RGB(237, 86, 89);
    self.isHiddenWhenHasNoneRecomment = NO;
    self.sheetItemFont = [UIFont systemFontOfSize:13];
    self.sheetItemTitleColor = [UIColor whiteColor];
}

+ (instancetype)defaultCofing{
    static ZZNewsSheetConfig1 *cofig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cofig = [[ZZNewsSheetConfig1 alloc]init];
    });
    return cofig;
}

@end
