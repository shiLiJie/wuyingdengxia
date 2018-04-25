//
//  MyTiwenCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _chooseType{
    
    waitType = 0,//标题类型
    susscessType    //内容类型
    
} chooseType;

@interface MyTiwenCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *huidaLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;


@property (nonatomic, assign) chooseType choosetype;
//传类型改变UI
-(void)setUIWithchooseType:(chooseType)chooseType;

@end
