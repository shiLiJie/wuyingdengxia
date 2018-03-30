//
//  TakeCarView.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TakeCarViewkBlcok) (NSArray *arr);
//添加乘车信息的回调
typedef void(^AddTakeCarViewkBlcok) (void);

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

@property (nonatomic,copy)TakeCarViewkBlcok takeCarViewkBlcok;
@property (nonatomic,copy)AddTakeCarViewkBlcok addtakeCarViewkBlcok;

@end
