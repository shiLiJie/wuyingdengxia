//
//  XuyuanResultVc.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "XuyuanResultVc.h"

@interface XuyuanResultVc ()
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation XuyuanResultVc

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [super viewWillAppear:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    
    self.sureBtn.layer.cornerRadius = CGRectGetHeight(self.sureBtn.frame)/2;//半径大小
    self.sureBtn.layer.masksToBounds = YES;//是否切割
}
- (IBAction)sureBtnClick:(UIButton *)sender {
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES]; 
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
