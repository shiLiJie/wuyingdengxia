//
//  MyTableCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableCell : UITableViewCell
//左边图片
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
//cell
//内容
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end
