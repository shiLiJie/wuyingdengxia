//
//  InforViewController.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "InforViewController.h"

@interface InforViewController ()

@end

@implementation InforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 身份认证接口:添加接口参数
 获取文章信息接口:返回数据添加 回复数
 往期回顾接口:返回数据添加 回复数,点赞数
 获取用户信息接口:返回数据添加 标签集合
 2.1.17对文章/视频/问答取消点赞接口: 传入参数应该加一个文章或视频的具体id,不然好像不能定位到是哪篇文章或视频
 2.1.18提问接口:提问也可以传入图片,类似发布文章
*/

@end
