//
//  PageDetailViewController.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"
#import "pageModel.h"

@interface PageDetailViewController : BaseViewController

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *articleid;
@property (nonatomic,copy) NSString *userid;

@property (nonatomic, strong) pageModel *model;


@end
