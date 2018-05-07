//
//  PastViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "huiguModel.h"


@protocol PassDelegate<NSObject>

@optional

//监听点击table点击的索引
-(void)passTableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath huiguModel:(huiguModel *)huiyiModel;

@end

@interface PastViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,weak) id<PassDelegate>delegate;

@end
