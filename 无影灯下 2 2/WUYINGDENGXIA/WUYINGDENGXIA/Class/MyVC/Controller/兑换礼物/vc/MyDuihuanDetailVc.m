//
//  MyDuihuanDetailVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MyDuihuanDetailVc.h"

@interface MyDuihuanDetailVc ()
@property (weak, nonatomic) IBOutlet UIImageView *image;//图片
@property (weak, nonatomic) IBOutlet UILabel *imageName;//宁城
@property (weak, nonatomic) IBOutlet UILabel *number;//数量
@property (weak, nonatomic) IBOutlet UILabel *jiage;//价格
@property (weak, nonatomic) IBOutlet UILabel *duihuanma;//兑换码
@property (weak, nonatomic) IBOutlet UILabel *dingdanhao;//订单号
@property (weak, nonatomic) IBOutlet UILabel *riqi;//下单日期
@property (weak, nonatomic) IBOutlet UILabel *youxiaoqi;//有效期

@end

@implementation MyDuihuanDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageName.text = self.duihuanmodel.goods_name;
    self.jiage.text = self.duihuanmodel.moon_cash;
    self.duihuanma.text = self.duihuanmodel.exchange_code;
    self.dingdanhao.text = self.duihuanmodel.order_num;
    self.riqi.text = self.duihuanmodel.exchange_time;
    
    NSString *string =self.duihuanmodel.begin_time;
    NSString *string1 =self.duihuanmodel.end_time;
    
    NSArray *array = [string componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    NSArray *array1 = [string1 componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    if (array.count>0 && array1.count>0) {
        self.youxiaoqi.text = [NSString stringWithFormat:@"%@ - %@",array[0],array1[0]];
    }
    
    if (!kStringIsEmpty(self.duihuanmodel.exchange_time)) {
        self.riqi.text = self.duihuanmodel.exchange_time;
    }
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.duihuanmodel.goods_img] placeholderImage:GetImage(@"")];
    
    self.image.clipsToBounds = YES;
}

#pragma mark - UI -
-(BOOL)hideNavigationBottomLine{
    return NO;
}

-(UIColor *)set_colorBackground{
    return [UIColor whiteColor];
}

-(NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"兑换详情"];
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

#pragma mark - 私有方法 -
//复制兑换码
- (IBAction)copyDuihuanma:(UIButton *)sender {
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = self.duihuanma.text;;
    [pab setString:string];
    if (pab == nil) {
        [MBProgressHUD showError:@"复制失败"];
    }else
    {
        [MBProgressHUD showSuccess:@"已复制"];
    }
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
