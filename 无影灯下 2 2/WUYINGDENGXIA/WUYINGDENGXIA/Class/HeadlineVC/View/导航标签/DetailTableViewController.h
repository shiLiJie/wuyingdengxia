//
//  ViewController1.h
//  Linkage
//
//  Created by administrator on 2017/9/1.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pageModel.h"

@protocol JohnScrollViewDelegate<NSObject>

@optional

//监听table滚动的距离
-(void)johnScrollViewDidScroll:(CGFloat)scrollY;

//监听点击table点击的索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath article_id:(NSString *)articleid user_id:(NSString *)userid pageModle:(pageModel *)model;

//点击cell里的头像和用户名弹出个人发表页
-(void)clickUserNamePushPublishVc;

@end

@interface DetailTableViewController : UIViewController

@property (nonatomic,copy) void(^DidScrollBlock)(CGFloat scrollY);

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) id<JohnScrollViewDelegate>delegate;

//对应的标签
@property (nonatomic,copy) NSString *lable;


@end
