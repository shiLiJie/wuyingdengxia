//
//  ZZNewsSheetConfig.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZZNewsSheetConfig.h"


@implementation ZZNewsSheetConfig

- (instancetype)init{
    if (self = [super init]) {
        [self commit];
    }
    return self;
}
- (void)commit{
    self.sheetItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 35);
    self.sheetBackgroundColor = [UIColor clearColor];
    self.isShakeAnimation = YES;
    self.sheetMaxColumn = 3;
    self.closeBackgroundColor = [UIColor lightGrayColor];
    self.isHiddenWhenHasNoneRecomment = NO;
    self.sheetItemFont = [UIFont systemFontOfSize:12];
    self.sheetItemTitleColor = [UIColor blackColor];
}

+ (instancetype)defaultCofing{
    static ZZNewsSheetConfig *cofig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cofig = [[ZZNewsSheetConfig alloc]init];
    });
    return cofig;
}

@end
