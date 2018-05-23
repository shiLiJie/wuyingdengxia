//
//  DFSegmentHeadView1.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)

@protocol DFSegmentHeadViewDelegate <NSObject>

@required
- (NSInteger)dfSegmentNumber;
- (CGSize)dfSegmentItemSimeWithIndex:(NSInteger)index;
- (void)selectWithIndex:(NSInteger)index;
- (NSString *)textForCellWithIndex:(NSInteger)index;

@end

@interface DFSegmentHeadView1 : UIView

@property (nonatomic, weak) id<DFSegmentHeadViewDelegate> delegate;

@property (nonatomic, copy) UIColor *textLabelColor;

@property (nonatomic, copy) UIColor *linelColor;

- (void)setSelectItemWithIndex:(NSInteger)index;

@end


@interface DFSegmentViewCell1 : UICollectionViewCell

@property (nonatomic, strong) UILabel *labelText;

@property (nonatomic, strong) UIView *lineView;

@end
