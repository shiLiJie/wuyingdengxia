//
//  XiaoxiDetailVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XiaoxiDetailVc.h"

@interface XiaoxiDetailVc ()

@end

@implementation XiaoxiDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc]init];
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.midView.frame), kScreen_Width, kScreen_Height-CGRectGetMaxY(self.midView.frame));
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    self.pingfenBtn.layer.cornerRadius = CGRectGetHeight(self.pingfenBtn.frame)/2;//半径大小
    self.pingfenBtn.layer.masksToBounds = YES;//是否切割
    
    [self setUpUI];

}

//判断类型
-(void)setUpUI{
    switch (self.xiaoxiType) {
        case canhuiType:
            self.canhuitongzhiLab.hidden = NO;
            
            self.topView.hidden = YES;
            self.midView.hidden = YES;
            self.webView.hidden = YES;
            self.tuigaoLab.hidden = YES;
            self.tuigaoYuanyinLab.hidden = YES;
            self.imageBg.hidden = YES;
            self.pingfenBtn.hidden = YES;
            self.fanhuiBtn.hidden = YES;
            break;
        case tuigaoType:
            self.canhuitongzhiLab.hidden = YES;
            
            self.topView.hidden = NO;
            self.midView.hidden = NO;
            self.webView.hidden = NO;
            self.tuigaoLab.hidden = NO;
            self.tuigaoYuanyinLab.hidden = NO;
            self.imageBg.hidden = YES;
            self.pingfenBtn.hidden = YES;
            self.fanhuiBtn.hidden = YES;
            break;
        case wenjuanType:
            
            self.navigationController.navigationBar.hidden = YES;
            
            self.imageBg.hidden = NO;
            self.pingfenBtn.hidden = NO;
            self.fanhuiBtn.hidden = NO;
            
            self.canhuitongzhiLab.hidden = YES;
            
            self.topView.hidden = YES;
            self.midView.hidden = YES;
            self.webView.hidden = YES;
            self.tuigaoLab.hidden = YES;
            self.tuigaoYuanyinLab.hidden = YES;
            break;
             
        default:
            break;
    }
    
    
    
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:self.titleStriing];
}

//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 44, 60);
    [btn setImage:GetImage(@"fanhui") forState:UIControlStateNormal];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x000000) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:BOLDSYSTEMFONT(18) range:NSMakeRange(0, title.length)];
    return title;
}

//返回
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//开始评分
- (IBAction)pingfenClick:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
