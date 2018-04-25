//
//  XiaoxiCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

typedef enum NSUInteger{
    
    tuigaoType = 0,//标题类型
    canhuiType,    //内容类型
    xitongType,
    wenjuanType
    
} xiaoxiType;



#import <UIKit/UIKit.h>



@interface XiaoxiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *xiaoxiImage;//消息图片
@property (weak, nonatomic) IBOutlet UILabel *xiaoxiTitle;//消息标题
@property (weak, nonatomic) IBOutlet UILabel *xiaoxiDetail;//消息详情内容
@property (weak, nonatomic) IBOutlet UILabel *xiaoxiTime;//消息时间

@property (nonatomic,assign) xiaoxiType xiaoxiType;//消息类型



-(void)setUpImage;

@end
