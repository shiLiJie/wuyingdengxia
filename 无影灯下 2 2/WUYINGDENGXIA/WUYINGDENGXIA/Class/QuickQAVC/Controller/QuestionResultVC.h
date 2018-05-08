//
//  QuestionResultVC.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

@interface QuestionResultVC : BaseViewController

//标题lab
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//内容lab
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
//月亮币展示
@property (weak, nonatomic) IBOutlet UIButton *yueliangbiBtn;
//装图片的数组
@property (nonatomic, strong) NSMutableArray *imageArr;
//标签内容数组
@property(nonatomic,strong)NSMutableArray *hotKeys;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,copy) NSString *yueliang;

@end
