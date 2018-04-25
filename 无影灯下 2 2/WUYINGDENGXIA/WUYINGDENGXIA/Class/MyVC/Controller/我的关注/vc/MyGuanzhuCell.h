//
//  MyGuanzhuCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum _chooseType{
    
    guanzhuType = 0,//标题类型
    weiguanzhuType    //内容类型
    
} chooseType;

@interface MyGuanzhuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *zhiwuLab;
@property (weak, nonatomic) IBOutlet UILabel *fensiLab;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;

@property (nonatomic, assign) chooseType choosetype;

//传类型改变UI
-(void)setUIWithchooseType:(chooseType)chooseType;

@end
