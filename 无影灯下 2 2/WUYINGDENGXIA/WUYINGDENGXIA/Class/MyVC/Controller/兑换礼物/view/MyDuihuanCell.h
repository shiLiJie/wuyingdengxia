//
//  MyDuihuanCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyDuihuanCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIView *cellView;//需要切圆角view

@property (weak, nonatomic) IBOutlet UILabel *dingdanhaoLab;//兑换码
@property (weak, nonatomic) IBOutlet UIImageView *image;//图片
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//名称
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;//价格
@property (weak, nonatomic) IBOutlet UILabel *shiyongLab;//是否使用

@end
