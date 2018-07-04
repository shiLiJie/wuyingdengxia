//
//  ViewController1.h
//  Linkage
//
//  Created by administrator on 2017/9/1.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pageModel.h"

typedef enum _choosePageType{

    labelType = 0,//标题类型
    shoucangType,//内容类型
    personType

} choosePageType;

@protocol JohnScrollViewDelegate<NSObject>

@optional

//监听table滚动的距离
-(void)johnScrollViewDidScroll:(CGFloat)scrollY;

//监听点击table点击的索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath article_id:(NSString *)articleid user_id:(NSString *)userid pageModle:(pageModel *)model;

//点击cell里的头像和用户名弹出个人发表页
-(void)clickUserNamePushPublishVcWithUserid:(NSString *)userid;

@end

@interface DetailTableViewController : UIViewController

@property (nonatomic,copy) void(^DidScrollBlock)(CGFloat scrollY);

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) id<JohnScrollViewDelegate>delegate;

//对应的标签(主页用)
@property (nonatomic,copy) NSString *lable;
//对应的标签(主页用)
@property (nonatomic,copy) NSString *lableName;
//选择从哪进来
@property (nonatomic, assign) choosePageType choosetype;

//我的收藏文章列表
-(void)getMyshoucangPage;

//查看别人主页时吊用此方法,获取文章列表
-(void)getPersonVcPageWithPersonId:(NSString *)userid userName:(NSString *)username userHeadimg:(NSString *)userheadimg;


@end
