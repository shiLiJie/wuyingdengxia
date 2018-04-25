//
//  WeikaishiCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum _chooseType{
    
    shenhezhongType = 0,//标题类型
    weiqiandaoType    //内容类型
    
} chooseType;

@interface WeikaishiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *qiandaoLab;
@property (nonatomic, assign) chooseType choosetype;

-(void)setUpUi:(chooseType)choosetype;
@end
