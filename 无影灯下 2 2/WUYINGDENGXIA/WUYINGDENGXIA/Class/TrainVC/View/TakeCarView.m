//
//  TakeCarView.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "TakeCarView.h"

@implementation TakeCarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"TakeCarView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}
//左侧城市按钮点击
- (IBAction)zuoBtnClick:(UIButton *)sender {
}
//右侧城市按钮点击
- (IBAction)youBtnClick:(UIButton *)sender {
}
//中间旋转按钮点击
- (IBAction)xuanzhuanBtnClick:(UIButton *)sender {
    
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
    self.takeCarViewkBlcok(arr);
}

@end
