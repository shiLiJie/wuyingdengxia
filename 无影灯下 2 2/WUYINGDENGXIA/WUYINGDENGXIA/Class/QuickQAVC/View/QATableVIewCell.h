//
//  QATableVIewCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QATableVIewCellDelegate<NSObject>

@optional
//监听点击table点击的索引
-(void)tableviewDidSelectUserHeadImage:(NSInteger )indexPath;

@end

@interface QATableVIewCell : UITableViewCell
//头像
@property (weak, nonatomic) IBOutlet UIButton *headImage;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName;
//主标题
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
//内容详情
@property (weak, nonatomic) IBOutlet UILabel *detailPage;
//回答时间
@property (weak, nonatomic) IBOutlet UILabel *answerTime;
//回答次数
@property (weak, nonatomic) IBOutlet UILabel *answerNum;
//回答按钮
@property (weak, nonatomic) IBOutlet UIButton *answer;
//月亮币
@property (weak, nonatomic) IBOutlet UILabel *mooncash;

@property (nonatomic,weak) id<QATableVIewCellDelegate>delegate;

@end
