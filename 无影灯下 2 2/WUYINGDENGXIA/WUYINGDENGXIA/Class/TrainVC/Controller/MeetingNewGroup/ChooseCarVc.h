//
//  ChooseCarVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^chooseCarViewkBlcok) (NSString *car);

@interface ChooseCarVc : BaseViewController

@property (nonatomic,retain)NSArray *zhanArr;
@property (nonatomic,retain)NSArray *zhanArrall;

@property (nonatomic,copy)chooseCarViewkBlcok choosecarViewkBlcok;

@end
