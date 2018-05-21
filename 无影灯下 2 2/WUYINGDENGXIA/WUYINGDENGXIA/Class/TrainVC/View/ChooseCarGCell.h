//
//  ChooseCarGCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCarGCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *startStep;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *endStep;
@property (weak, nonatomic) IBOutlet UILabel *runTime;
@property (weak, nonatomic) IBOutlet UILabel *carG;

@property (weak, nonatomic) IBOutlet UIView *backView;

@end
