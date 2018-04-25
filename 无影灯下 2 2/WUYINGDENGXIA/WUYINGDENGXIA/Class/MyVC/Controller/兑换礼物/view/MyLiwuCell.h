//
//  MyLiwuCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLiwuCell : UICollectionViewCell
//礼物图片
@property (weak, nonatomic) IBOutlet UIImageView *liwuImage;
//礼物名称
@property (weak, nonatomic) IBOutlet UILabel *liwuName;
//礼物价格
@property (weak, nonatomic) IBOutlet UILabel *liwuJiage;
@end
