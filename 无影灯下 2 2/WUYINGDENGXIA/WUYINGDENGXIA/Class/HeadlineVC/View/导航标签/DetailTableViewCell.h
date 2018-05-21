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



//主标题
@property (weak, nonatomic) IBOutlet UILabel *mainTitle1;
//头像
@property (weak, nonatomic) IBOutlet UIButton *headImage1;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName1;
//文章详情
@property (weak, nonatomic) IBOutlet UILabel *pageDetail1;
//浏览数
@property (weak, nonatomic) IBOutlet UILabel *liulanLab1;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *pinglunLab1;
//点赞数
@property (weak, nonatomic) IBOutlet UILabel *dianzanLab1;
@property (weak, nonatomic) IBOutlet UIImageView *image1;



//主标题
@property (weak, nonatomic) IBOutlet UILabel *mainTitle2;
//头像
@property (weak, nonatomic) IBOutlet UIButton *headImage2;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName2;
//文章详情
@property (weak, nonatomic) IBOutlet UILabel *pageDetail2;
//浏览数
@property (weak, nonatomic) IBOutlet UILabel *liulanLab2;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *pinglunLab2;
//点赞数
@property (weak, nonatomic) IBOutlet UILabel *dianzanLab2;
@property (weak, nonatomic) IBOutlet UIImageView *image21;
@property (weak, nonatomic) IBOutlet UIImageView *image22;




//主标题
@property (weak, nonatomic) IBOutlet UILabel *mainTitle3;
//头像
@property (weak, nonatomic) IBOutlet UIButton *headImage3;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName3;
//文章详情
@property (weak, nonatomic) IBOutlet UILabel *pageDetail3;
//浏览数
@property (weak, nonatomic) IBOutlet UILabel *liulanLab3;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *pinglunLab3;
//点赞数
@property (weak, nonatomic) IBOutlet UILabel *dianzanLab3;
@property (weak, nonatomic) IBOutlet UIImageView *image31;
@property (weak, nonatomic) IBOutlet UIImageView *image32;
@property (weak, nonatomic) IBOutlet UIImageView *image33;



@end
