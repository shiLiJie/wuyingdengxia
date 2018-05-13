//
//  MyLiwuResultVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"
#import "LiwuModel.h"

@interface MyLiwuResultVc : BaseViewController

@property (nonatomic, strong) LiwuModel *liwumodel;

@property (nonatomic,copy) NSString *courtesy_code;
@property (nonatomic,copy) NSString *exchange_code;
@property (nonatomic,copy) NSString *order_num;

@end
