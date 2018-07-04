//
//  PassMeetViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"
#import "huiguModel.h"
#import "huiguErModel.h"

@protocol PassMeetDelegate<NSObject>

@optional

//监听点击table点击的索引
-(void)tableviewDidSelectPageWithIndex2:(NSIndexPath *)indexPath huiguErModel:(huiguErModel *)model;

@end

@interface PassMeetViewController : BaseViewController

@property (nonatomic, strong) huiguModel *huiguModel;

@property (nonatomic, strong) NSArray *huiguerArr;

@property (nonatomic,weak)id <PassMeetDelegate> delegate;


//获取回顾列表
-(void)getVideoList;

//我的收藏视频列表
-(void)getMyshoucangQusetion;

@end
