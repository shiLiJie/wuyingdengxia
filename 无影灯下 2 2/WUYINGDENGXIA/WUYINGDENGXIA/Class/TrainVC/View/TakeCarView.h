//
//  TakeCarView.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 添加乘车信息回调

 @param arr arr description
 @param isZuo isZuo description
 @param isYou isYou description
 */
typedef void(^TakeCarViewkBlcok) (NSArray *arr, BOOL isZuo, BOOL isYou);

/**
 添加乘车信息的回调
 */
typedef void(^AddTakeCarViewkBlcok) (void);

/**
 添加乘车日期

 @param str 日期
 */
typedef void(^TakeCarDatekBlcok) (NSString *str);

/**
 选择车次回调
 */
typedef void(^choosechecikBlcok) (void);

/**
 备选车次回调
 */
typedef void(^choosebeicheciBlcok) (void);

/**
 备注掉
 */
typedef void(^beizhuBlcok) (void);

@interface TakeCarView : UIView
//左侧城市按钮
@property (weak, nonatomic) IBOutlet UIButton *zuoCity;
//右侧城市按钮
@property (weak, nonatomic) IBOutlet UIButton *youCity;
//中间旋转按钮
@property (weak, nonatomic) IBOutlet UIButton *xuanzhuanBtn;
//乘车日期
@property (weak, nonatomic) IBOutlet UILabel *chengcheDate;
//车次
@property (weak, nonatomic) IBOutlet UILabel *checi;
//备选车次
@property (weak, nonatomic) IBOutlet UILabel *beixuanCheci;
//备注
@property (weak, nonatomic) IBOutlet UILabel *beizhuLab;

@property (nonatomic,copy)TakeCarViewkBlcok takeCarViewkBlcok;
@property (nonatomic,copy)AddTakeCarViewkBlcok addtakeCarViewkBlcok;
@property (nonatomic,copy)TakeCarDatekBlcok addtakeCarDatekBlcok;
@property (nonatomic,copy)choosechecikBlcok choosechecikBlcok;
@property (nonatomic,copy)choosebeicheciBlcok choosebeicheciBlcok;
@property (nonatomic,copy)beizhuBlcok beizhuBlcok;

@end
