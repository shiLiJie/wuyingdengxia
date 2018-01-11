//
//  ZZNewsSheetMenu.h
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNewsSheetConfig.h"

 typedef   void(^newsSheetBlock)(ZZNewsSheetConfig *);

typedef void(^clossViewBlock)(NSMutableArray *itemArray);

@interface ZZNewsSheetMenu : UIView

+(instancetype)newsSheetMenu;

@property(nonatomic,assign)BOOL hiddenAllCornerFlag;
@property(nonatomic,strong)NSMutableArray<NSString *> *mySubjectArray;
@property(nonatomic,strong)NSMutableArray<NSString *> *recommendSubjectArray;

@property(nonatomic,copy)  clossViewBlock clossviewblock;

//显示
- (void)showNewsMenu;
//隐藏
- (void)dismissNewsMenu;
//刷新推荐标签
- (void)setRecommentSubject;

- (void)updateNewSheetConfig:(newsSheetBlock)block;

- (void)updataItmeArray:(clossViewBlock)block;

@end
