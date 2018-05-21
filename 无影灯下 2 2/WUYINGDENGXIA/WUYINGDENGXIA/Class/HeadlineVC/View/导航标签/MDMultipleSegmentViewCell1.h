//
//  MDMultipleSegmentViewCell1.h
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDMultipleSegmentViewCell1 : UICollectionViewCell

/**
 *  标签label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  当前是否被选中
 */
@property (nonatomic, assign) BOOL isSeleted;

/**
 *  选中后下划线高度
 */
@property (nonatomic, assign) CGFloat bottomLineWidth;

@end
