//
//  WeikaishiVc.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/4/18.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WeikaishitDelegate<NSObject>

@optional

//监听点击table点击的索引
-(void)tableviewDidSelectPageWithIndex3:(NSIndexPath *)indexPath;

@end

@interface WeikaishiVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,weak)id <WeikaishitDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *weikaishiArr;


@end
