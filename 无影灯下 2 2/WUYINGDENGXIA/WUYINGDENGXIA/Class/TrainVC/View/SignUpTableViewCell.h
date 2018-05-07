//
//  SignUpTableViewCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *meetName;
@property (weak, nonatomic) IBOutlet UILabel *meetTime;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userShenfenid;
@property (weak, nonatomic) IBOutlet UILabel *userSex;
@property (weak, nonatomic) IBOutlet UILabel *danwei;
@property (weak, nonatomic) IBOutlet UILabel *bumen;
@property (weak, nonatomic) IBOutlet UILabel *zhiwu;

@end
