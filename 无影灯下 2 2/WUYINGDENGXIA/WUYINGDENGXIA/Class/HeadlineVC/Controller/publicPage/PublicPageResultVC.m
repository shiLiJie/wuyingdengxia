//
//  PublicPageResultVC.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "PublicPageResultVC.h"

@interface PublicPageResultVC ()


@end

@implementation PublicPageResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //切圆角和设置弧度
    self.quedingBtn.layer.cornerRadius = CGRectGetHeight(self.quedingBtn.frame)/2;//半径大小
    self.quedingBtn.layer.masksToBounds = YES;//是否切割
    
    if (!self.isSucess) {
        self.bgImage.image = GetImage(@"tougaoshibai");
        self.mesLab.text = @"提交失败,请从新提交......";
        self.mesLab.textColor = RGB(232, 79, 79);
        [self.quedingBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        self.bgImage.image = GetImage(@"tougaochenggong");
        self.mesLab.text = @"提交成功,请等待审核......";
        self.mesLab.textColor = RGB(45, 163, 255);
        [self.quedingBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
}

//确定或取消按钮点击
- (IBAction)btnClick:(UIButton *)sender {
    if (self.isSucess) {
        [self.navigationController
         popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)hideNavigationBottomLine{
    return YES;
}
//左侧按钮设置点击
-(UIButton *)set_leftButton{
    UIButton *btn = [[UIButton alloc] init];
    return btn;
}

-(void)left_button_event:(UIButton *)sender{
    
    
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
