//
//  PersonViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonViewController : BaseViewController

//传过来的userid
@property (nonatomic,copy) NSString *userid;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end
