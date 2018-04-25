//
//  ziliaoCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ziliaoCellBlcok) (NSString *text, NSInteger tag);
typedef void(^renzhengBlcok) (void);
typedef void(^touxiangBlcok) (void);

@interface ziliaoCell : UITableViewCell

@property (nonatomic,copy)ziliaoCellBlcok ziliaoCellBlcok;//监听textfield
@property (nonatomic,copy)renzhengBlcok renzhengBlcok;//认证按钮
@property (nonatomic,copy)touxiangBlcok touxiangBlcok;//认证按钮

@property (weak, nonatomic) IBOutlet UIButton *headBtn;//头像
@property (weak, nonatomic) IBOutlet UIButton *renzhengBtn;//认证按钮

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *jiantou;

@end
