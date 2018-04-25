//
//  XiaoxiDetailVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

typedef enum _chooseType{
    
    canhuiType = 0,//标题类型
    tuigaoType,    //内容类型
    wenjuanType    //问卷类型
    
} xiaoxiType;

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface XiaoxiDetailVc : BaseViewController

@property (nonatomic,copy) NSString *titleStriing;
//一种
@property (weak, nonatomic) IBOutlet UILabel *canhuitongzhiLab;
//另一种
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (nonatomic, strong) WKWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *tuigaoLab;
@property (weak, nonatomic) IBOutlet UILabel *tuigaoYuanyinLab;
//第三种
@property (weak, nonatomic) IBOutlet UIImageView *imageBg;
@property (weak, nonatomic) IBOutlet UIButton *pingfenBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanhuiBtn;

//消息类型
@property (nonatomic, assign) xiaoxiType xiaoxiType;

@end
