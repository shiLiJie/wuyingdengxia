//
//  QATableVIewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lableModel.h"
#import "QusetionModel.h"

@protocol QATableVIewDelegate<NSObject>

@optional
//监听点击table点击的索引
-(void)QAtableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath QusetionModel:(QusetionModel *)Qusetionmodel;

//点击头像推出个人展示页
-(void)clickHeadImageJumpToPersonDetailPage:(NSInteger)indexPath;

@end

@interface QATableVIewController : UIViewController

@property (nonatomic,weak) id<QATableVIewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

//对应的标签
@property (nonatomic,strong) lableModel *lablemodel;

//获取标签下对应问答
-(void)getQusetionWithLabel;

//我的收藏问题列表
-(void)getMyshoucangQusetion;

@end
