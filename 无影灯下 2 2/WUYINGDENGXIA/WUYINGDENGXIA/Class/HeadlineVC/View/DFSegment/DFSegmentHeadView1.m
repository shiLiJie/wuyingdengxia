//
//  DFSegmentHeadView1.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "DFSegmentHeadView1.h"

@interface DFSegmentHeadView1 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectV;

@property (nonatomic, assign) NSInteger selectIndex;


@end

@implementation DFSegmentHeadView1

- (void)setDelegate:(id<DFSegmentHeadViewDelegate>)delegate {
    
    _delegate = delegate;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    
    self.collectV = collectionView;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    self.selectIndex = 0;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;;
    
    [self addSubview:collectionView];
    
    [self.collectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [collectionView registerClass:[DFSegmentViewCell1 class] forCellWithReuseIdentifier:@"DFSegmentViewCell1"];
    
    self.textLabelColor = RGB(10, 147, 255);
    self.linelColor = RGB(10, 147, 255);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.delegate dfSegmentNumber];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate dfSegmentItemSimeWithIndex:indexPath.item];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DFSegmentViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFSegmentViewCell1" forIndexPath:indexPath];
    
    cell.labelText.text = [self.delegate textForCellWithIndex:indexPath.item];
    [cell.labelText setTextColor:RGB(51, 51, 51)];
    [cell.labelText setFont:BOLDSYSTEMFONT(16)];
    
    if (self.selectIndex == indexPath.item) {
        
        cell.lineView.backgroundColor = self.linelColor;
        cell.labelText.textColor = self.textLabelColor;
        [cell.labelText setFont:BOLDSYSTEMFONT(16)];
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.lineView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            cell.labelText.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
        
    }else {
        cell.lineView.backgroundColor = [UIColor clearColor];
        cell.labelText.textColor = [UIColor blackColor];
        
        cell.lineView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        cell.labelText.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }
    
    cell.lineView .layer.cornerRadius = CGRectGetHeight(cell.lineView .frame)/2;//半径大小
    cell.lineView .layer.masksToBounds = YES;//是否切割
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectIndex == indexPath.row) {
        
        return;
    }
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self.collectV reloadData];
    
    self.selectIndex = indexPath.row;
    
    [self.delegate selectWithIndex:indexPath.row];
}

- (void)setSelectItemWithIndex:(NSInteger)index {
    
    if (index > [self.delegate dfSegmentNumber] || index < 0) {
        
        return;
    }
    
    [self.collectV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    
    self.selectIndex = index;
    
    [self.collectV reloadData];
}

@end


@implementation DFSegmentViewCell1

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.labelText = [UILabel new];
        
        [self.contentView addSubview:self.labelText];
        
        self.labelText.font = [UIFont systemFontOfSize:13];
        
        self.labelText.textAlignment = NSTextAlignmentCenter;
        
        [self.labelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.mas_equalTo(-4);
            make.centerX.equalTo(self.contentView);
        }];
        
        
        
        self.lineView = [UIView new];
        
        
        
        [self.contentView addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelText.mas_bottom).offset(2);
            make.height.equalTo(@2);
            //            make.left.right.equalTo(self.labelText);
            make.centerX.equalTo(self.labelText);
            make.width.equalTo(@25);
        }];
        
        
    }
    return self;
    
}

@end
