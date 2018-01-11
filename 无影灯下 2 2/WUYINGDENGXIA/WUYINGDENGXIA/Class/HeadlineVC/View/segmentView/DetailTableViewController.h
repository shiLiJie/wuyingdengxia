//
//  ViewController1.h
//  Linkage
//
//  Created by administrator on 2017/9/1.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JohnScrollViewDelegate<NSObject>

@optional

//监听table滚动的距离
-(void)johnScrollViewDidScroll:(CGFloat)scrollY;

//监听点击table点击的索引
-(void)tableviewDidSelectPageWithIndex:(NSIndexPath *)indexPath;

@end

@interface DetailTableViewController : UIViewController

@property (nonatomic,copy) void(^DidScrollBlock)(CGFloat scrollY);

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) id<JohnScrollViewDelegate>delegate;

@end
