//
//  MyKeshiCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyKeshiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *keshiImage;//科室头像
@property (weak, nonatomic) IBOutlet UILabel *keshiName;//科室名称
@property (weak, nonatomic) IBOutlet UILabel *personNum;//科室人数

@end
