//
//  zhuangjiaCollectionView.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/27.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "zhuangjiaCollectionView.h"
#import "zhuangjiaModel.h"
#import "zhuanjiaCell.h"


static NSString *ID = @"zhuanjiaCell";

@interface zhuangjiaCollectionView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation zhuangjiaCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        [self registerNib:[UINib nibWithNibName:[[zhuanjiaCell class] description] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ID];
        
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
    
    return  self.zhuangjiaDataArr.count;
    
}

//返回某个indexPath对应的cell，该方法必须实现：

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    zhuanjiaCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    zhuangjiaModel *model = [[zhuangjiaModel alloc] init];
    model = self.zhuangjiaDataArr[indexPath.row];
    
    cell.zhuanjiaName.text = model.meet_talk_name;
    cell.zhuanjiaDetail.text = model.meet_talk_content;
    
    [cell.zhuangjiaImage sd_setImageWithURL:[NSURL URLWithString:model.specialist_image] placeholderImage:GetImage(@"")];
    
//    cell.layer.cornerRadius = 3;
//    cell.contentView.layer.cornerRadius = 3.0f;
//    cell.contentView.layer.borderWidth = 0.5f;
//    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
//    cell.contentView.layer.masksToBounds = YES;
//
//    cell.layer.shadowColor = RGBA(210, 208, 208,0.7).CGColor;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    cell.layer.shadowRadius = 3.0f;
//    cell.layer.shadowOpacity = 0.5f;
//    cell.layer.masksToBounds = NO;
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    return cell;
}

//#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (kDevice_Is_iPhoneX) {
        return  CGSizeMake(kScreen_Width/3, 180);
    }else{
        return  CGSizeMake(kScreen_Width/3, 180);
    }
}

//设定collectionView(指定区)的边距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (kDevice_Is_iPhoneX) {
        return UIEdgeInsetsMake(5, 15, 0,50);
    }else{
        return UIEdgeInsetsMake(5, 15, 0,0);
    }
}

//点击每个item实现的方法：

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    discussModel *model = [[discussModel alloc] init];
//    model = self.modelArr[indexPath.row];
//
//
//    if ([self.delegate1 respondsToSelector:@selector(clickDiscussToIndex:discussModel:)]) {
//        [self.delegate1 clickDiscussToIndex:indexPath.row discussModel:model];
//    }
    
}
    



@end
