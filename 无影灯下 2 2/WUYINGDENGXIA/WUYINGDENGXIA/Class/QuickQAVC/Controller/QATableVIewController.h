//
//  QATableVIewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QATableVIewDelegate<NSObject>

@optional
//监听点击table点击的索引
-(void)QAtableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath;

//点击头像推出个人展示页
-(void)clickHeadImageJumpToPersonDetailPage:(NSInteger)indexPath;

@end

@interface QATableVIewController : UIViewController

@property (nonatomic,weak) id<QATableVIewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
