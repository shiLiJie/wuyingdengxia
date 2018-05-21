//
//  ChooseCarGViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^checikBlcok) (NSString *str, BOOL isCheci);


@interface ChooseCarGViewController : BaseViewController

//火车票数组
@property (nonatomic, strong) NSArray *huocheArr;
//日期lab
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,assign) BOOL isCheci;

@property (nonatomic,copy)checikBlcok checikBlcok;


@end
