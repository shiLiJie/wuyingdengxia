//
//  SearchBarEffectController.h
//  微信搜索模糊效果
//
//  Created by MAC on 17/4/1.
//  Copyright © 2017年 MyanmaPlatform. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  SearchBarDelegate <NSObject>
- (void)didSelectKey:(NSString *)key;

@end

@interface SearchBarEffectController : UIView

@property(nonatomic , strong)NSArray * effectArray;
@property(nonatomic , strong)UITableView * tableView;
@property(nonatomic, weak) id<SearchBarDelegate> delegate;


- (void)hidden;
- (void)show;
@end
