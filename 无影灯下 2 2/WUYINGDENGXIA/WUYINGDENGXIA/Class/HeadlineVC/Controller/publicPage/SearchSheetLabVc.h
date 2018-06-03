//
//  SearchSheetLabVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^dismissViewBlock)(NSMutableArray *itemArray);

@interface SearchSheetLabVc : BaseViewController

//回调数组
@property(nonatomic,copy)  dismissViewBlock dismissviewBlock;

@end
