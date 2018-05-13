//
//  XuyuanDetailVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"
#import "xuyuanModel.h"

@interface XuyuanDetailVc : BaseViewController

@property (nonatomic, strong) xuyuanModel *xuyuan;

@property (nonatomic,copy) NSString *wishid;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,copy) NSString *mooncash;
@property (nonatomic,copy) NSString *ctime;


@end
