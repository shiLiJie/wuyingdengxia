//
//  XitongVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/16.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "BaseViewController.h"

//typedef void(^XitongVcBlcok) (NSIndexPath *index);

@protocol XitongVcDelegate <NSObject>//协议

- (void)transIndex1:(NSIndexPath *)index;//协议方法

@end

@interface XitongVc : BaseViewController

@property(nonatomic,weak)id<XitongVcDelegate>   delegate;

//@property (nonatomic,assign)XitongVcBlcok XitongVcBlcok;

@end
