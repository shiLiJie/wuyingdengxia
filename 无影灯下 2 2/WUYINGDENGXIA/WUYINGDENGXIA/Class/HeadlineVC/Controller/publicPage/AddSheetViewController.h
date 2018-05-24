//
//  AddSheetViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"
#import "ZZNewsSheetMenu.h"

typedef void(^clossViewBlock)(NSMutableArray *itemArray);

@interface AddSheetViewController : BaseViewController

//文章标签添加页面
@property(nonatomic, strong) ZZNewsSheetMenu *newsMenu;
//回调数组
@property(nonatomic,copy)  clossViewBlock clossviewblock;

//存放自定义标签的数组
@property (nonatomic, strong) NSMutableArray *allLabArr;

@end
