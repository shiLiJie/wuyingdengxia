//
//  DiscussCollectionView.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DiscussCollectionView.h"
#import "DiscussCell.h"

static NSString *ID = @"DiscussCell";

@interface DiscussCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation DiscussCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        [self registerNib:[UINib nibWithNibName:[[DiscussCell class] description] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
        
    }
    
    return self;
    
}

//返回collection view里区(section)的个数，如果没有实现该方法，将默认返回1：

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

//返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现：

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  3;
    
}

//返回某个indexPath对应的cell，该方法必须实现：

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiscussCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 3;
    cell.contentView.layer.cornerRadius = 3.0f;
    cell.contentView.layer.borderWidth = 0.5f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath; 
    
    return cell;
    
}

//设定collectionView(指定区)的边距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(5, 20, 5,6);
    
}

//点击每个item实现的方法：

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
