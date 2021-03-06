//
//  ZZNewsSheetMenu.h
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNewsSheetConfig1.h"

 typedef   void(^newsSheetBlock)(ZZNewsSheetConfig1 *);

typedef void(^clossViewBlock)(NSMutableArray *itemArray);

@interface ZZNewsSheetMenu1 : UIView

//初始化方法
+(instancetype)newsSheetMenu;
//初始化方法(给文章添加标签时用此方法)
+(instancetype)newsSheetMenu1;

@property(nonatomic,assign)BOOL hiddenAllCornerFlag;
@property(nonatomic,strong)NSMutableArray<NSString *> *mySubjectArray;
@property(nonatomic,strong)NSMutableArray<NSString *> *recommendSubjectArray;

@property(nonatomic,weak)UIButton *closeMenuButton;
@property(nonatomic,weak)UIButton *editMenuButton;
@property(nonatomic,weak)UILabel *recommentTitleLab;
@property(nonatomic,weak)UILabel *myTitleLab;
//添加标签页我的导航标题配置属性
@property(nonatomic,weak)UILabel *myTitleLab1;

@property(nonatomic,copy)  clossViewBlock clossviewblock;

//显示
- (void)showNewsMenu;
//显示(给文章添加标签时用此方法)
- (void)showNewsMenu1;
//隐藏
- (void)dismissNewsMenu;
//刷新推荐标签
- (void)setRecommentSubject;

- (void)updateNewSheetConfig:(newsSheetBlock)block;

- (void)updataItmeArray:(clossViewBlock)block;

@end
