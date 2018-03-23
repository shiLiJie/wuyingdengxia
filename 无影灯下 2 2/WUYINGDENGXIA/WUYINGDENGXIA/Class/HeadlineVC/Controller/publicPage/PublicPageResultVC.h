//
//  PublicPageResultVC.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

@interface PublicPageResultVC : BaseViewController
//审核提示图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
//审核文字信息
@property (weak, nonatomic) IBOutlet UILabel *mesLab;
//确定/取消按钮
@property (weak, nonatomic) IBOutlet UIButton *quedingBtn;
//是否成功
@property (nonatomic, assign) BOOL isSucess;

@end
