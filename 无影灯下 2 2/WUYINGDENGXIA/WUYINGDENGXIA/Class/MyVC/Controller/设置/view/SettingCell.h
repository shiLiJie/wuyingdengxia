//
//  SettingCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *huancunLab;
@property (weak, nonatomic) IBOutlet UILabel *renzhengLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
//登录或者退出登录
@property (weak, nonatomic) IBOutlet UILabel *dengluBtn;

@end
