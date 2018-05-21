//
//  MDMultipleSegmentLayout.m
//  MDMultipleSegment
//
//  Created by 梁宪松 on 2017/8/29.
//  Copyright © 2017年 Madao. All rights reserved.
//

#import "MDMultipleSegmentLayout1.h"

NSInteger const MDItemsPerPage1 = 5;//一页最多4个

@interface MDMultipleSegmentLayout1()
{
    NSMutableArray * _attributeAtts;//属性数组
    NSInteger _totalItemsNum;//总共标签数
}


@end

@implementation MDMultipleSegmentLayout1



- (void)prepareLayout
{
    

    _totalItemsNum = (int)[self.collectionView numberOfItemsInSection:0];
    _attributeAtts = [[NSMutableArray alloc]init];
    CGFloat collectionViewW = CGRectGetWidth(self.collectionView.frame);
    CGFloat collectionViewH = CGRectGetHeight(self.collectionView.frame);
    
//    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
//    // 设置具体属性
//    // 1.设置 最小行间距
//    self.minimumLineSpacing = 20;
//    // 2.设置 最小列间距
//    self. minimumInteritemSpacing  = 0;
//    // 3.设置item块的大小 (可以用于自适应)
//    self.estimatedItemSize = CGSizeMake(kScreen_Width, 44);
//    // 设置滑动的方向 (默认是竖着滑动的)
//    self.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
//    // 设置item的内边距
//    self.sectionInset = UIEdgeInsetsMake(0,20,0,0);

    if (_attributeAtts.count) {
        return;
    }

    for (int i = 0; i < _totalItemsNum; i ++) {

        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (_totalItemsNum >= MDItemsPerPage1) {

            //            attr.size = CGSizeMake(collectionViewW/MDItemsPerPage,
            //                                   collectionViewH);
            attr.size = CGSizeMake(77,
                                   collectionViewH);
        }else
        {
            attr.size = CGSizeMake(77,
                                   collectionViewH);
            //            attr.size = CGSizeMake(collectionViewW/_totalItemsNum,
            //                                   collectionViewH);
        }
        attr.center = CGPointMake(attr.size.width * (i + 0.5),
                                  CGRectGetMidY(self.collectionView.frame));

        [_attributeAtts addObject:attr];
    }
    
}

// 设置内容区域大小
-(CGSize)collectionViewContentSize{
    
    //    NSLog(@"%lu",(unsigned long)_attributeAtts.count);
    
    return (_attributeAtts.count < MDItemsPerPage1) ? self.collectionView.frame.size : CGSizeMake((SCREEN_WIDTH-44)/MDItemsPerPage1 * _attributeAtts.count,
                                                                                                 CGRectGetHeight(self.collectionView.frame));
    
    //    return (_attributeAtts.count <= MDItemsPerPage) ? self.collectionView.frame.size : CGSizeMake(SCREEN_WIDTH/MDItemsPerPage * _attributeAtts.count,
    //                          CGRectGetHeight(self.collectionView.frame));
}

//返回属性数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributeAtts;
}




@end

