//
//  MeetingNewViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeetNewDelegate<NSObject>

@optional

//监听点击table点击的索引
-(void)meetTbleviewDidSelectPageWithIndex:(NSIndexPath *)indexPath;

@end

@interface MeetingNewViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,weak) id<MeetNewDelegate>delegate;

@end
