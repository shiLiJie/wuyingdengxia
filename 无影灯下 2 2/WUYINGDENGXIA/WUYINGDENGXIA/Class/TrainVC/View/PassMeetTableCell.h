//
//  PassMeetTableCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassMeetTableCell : UITableViewCell
//视频图片
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
//视频名称
@property (weak, nonatomic) IBOutlet UILabel *videoName;
//主讲人名字
@property (weak, nonatomic) IBOutlet UILabel *videoPerson;
//播放次数
@property (weak, nonatomic) IBOutlet UILabel *playNum;
//评论次数
@property (weak, nonatomic) IBOutlet UILabel *talkNum;
//点赞次数
@property (weak, nonatomic) IBOutlet UILabel *goodNum;

@end
