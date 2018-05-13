//
//  DetailTableViewCell.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/1/5.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailTableViewCellDelegate <NSObject>
//弹出发表人页面
- (void)pushPublishPersonVc:(NSInteger)tag;
@end

@interface DetailTableViewCell : UITableViewCell

@property (nonatomic, weak) id<DetailTableViewCellDelegate> delegate;

//主标题
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
//头像
@property (weak, nonatomic) IBOutlet UIButton *headImage;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName;
//文章详情
@property (weak, nonatomic) IBOutlet UILabel *pageDetail;
//浏览数
@property (weak, nonatomic) IBOutlet UILabel *liulanLab;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *pinglunLab;
//点赞数
@property (weak, nonatomic) IBOutlet UILabel *dianzanLab;
//点击头像的所以
@property (nonatomic, assign) NSInteger headTag;

@end
