//
//  XuyuanJiluCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _chooseType{
    
    waitType = 0,//标题类型
    susscessType    //内容类型
    
} chooseType;

@interface XuyuanJiluCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;//许愿标题
@property (weak, nonatomic) IBOutlet UILabel *timeLab;//许愿时间
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;//许愿价格
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiLab;//许愿的状态

@property (nonatomic, assign) chooseType choosetype;

//传类型改变UI
-(void)setUIWithchooseType:(chooseType)chooseType;

@end
