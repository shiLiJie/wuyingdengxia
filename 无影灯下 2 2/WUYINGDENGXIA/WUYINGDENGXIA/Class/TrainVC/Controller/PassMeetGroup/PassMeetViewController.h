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
-(void)tableviewDidSelectPageWithIndex2:(NSIndexPath *)indexPath;

@end

@interface PassMeetViewController : BaseViewController

@property (nonatomic, strong) huiguModel *huiguModel;


@property (nonatomic,weak)id <PassMeetDelegate> delegate;

@end
