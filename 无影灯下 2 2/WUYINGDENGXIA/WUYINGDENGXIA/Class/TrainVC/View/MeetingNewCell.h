//
//  MeetingNewCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingNewCell : UITableViewCell
//会议摘要图片
@property (weak, nonatomic) IBOutlet UIImageView *meetImage;
//大会名称
@property (weak, nonatomic) IBOutlet UILabel *meetName;
//具体开会时间
@property (weak, nonatomic) IBOutlet UILabel *meetTime;
//报名状态按钮
@property (weak, nonatomic) IBOutlet UIButton *baomingBtn;

@end
