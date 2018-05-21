//
//  MeetDetailViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

@interface MeetDetailViewController : BaseViewController
//滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
//会议图片
@property (weak, nonatomic) IBOutlet UIImageView *meetImage;
//会议名称
@property (weak, nonatomic) IBOutlet UILabel *meetName;
//会议时间
@property (weak, nonatomic) IBOutlet UILabel *meetTime;
//会议地点
@property (weak, nonatomic) IBOutlet UILabel *meetAddress;
//会议详情
@property (weak, nonatomic) IBOutlet UILabel *meetDetailText;
//报名参会
@property (weak, nonatomic) IBOutlet UIButton *baomingBtn;
//会议介绍展开收起按钮
@property (weak, nonatomic) IBOutlet UIButton *huiyijieshaoBtn;

//会议介绍容器view
@property (weak, nonatomic) IBOutlet UIView *huiyiJieshaoView;
@property (weak, nonatomic) IBOutlet UIView *huiyiRichengView;
@property (weak, nonatomic) IBOutlet UITableView *richengTableView;
@property (weak, nonatomic) IBOutlet UIButton *huiyiRichengBtn;

@property (nonatomic,copy) NSString *meetId;
@property (nonatomic,assign) BOOL isJieshu;

@end
