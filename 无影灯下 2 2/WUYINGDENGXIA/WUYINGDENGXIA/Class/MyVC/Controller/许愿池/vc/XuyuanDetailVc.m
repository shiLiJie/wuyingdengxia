//
//  XuyuanDetailVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XuyuanDetailVc.h"

@interface XuyuanDetailVc ()
@property (weak, nonatomic) IBOutlet UILabel *xuyuanDetailLab;//许愿内容
@property (weak, nonatomic) IBOutlet UILabel *xuyuanTime;//许愿时间
@property (weak, nonatomic) IBOutlet UILabel *xuyuanJiage;//许愿价格
@property (weak, nonatomic) IBOutlet UIButton *shixianBtn;//确认实现按钮

@end

@implementation XuyuanDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shixianBtn.layer.cornerRadius = CGRectGetHeight(self.shixianBtn.frame)/2;//半径大小
    self.shixianBtn.layer.masksToBounds = YES;//是否切割
    
    
    self.xuyuanDetailLab.text = self.detail;
    self.xuyuanTime.text = self.ctime;
    self.xuyuanJiage.text = self.mooncash;
        
}
//确认实现按钮
- (IBAction)btnClick:(UIButton *)sender {
    
    [[HttpRequest shardWebUtil] getNetworkRequestURLString:[BaseUrl stringByAppendingString:[NSString stringWithFormat:@"confirm_wish?wishid=%@",self.wishid]]
                                                parameters:nil
                                                   success:^(id obj) {
                                                       NSLog(@"%@",obj);
    } fail:^(NSError *error) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"愿望详情"];
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
