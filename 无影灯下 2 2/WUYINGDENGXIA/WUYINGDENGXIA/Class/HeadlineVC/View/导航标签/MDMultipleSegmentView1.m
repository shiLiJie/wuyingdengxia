//
//  MDMultipleSegmentView.m
//  MDMultipleSegment
//
//  Created by 梁宪松 on 2017/8/29.
//  Copyright © 2017年 Madao. All rights reserved.
//

#import "MDMultipleSegmentView1.h"
#import "MDMultipleSegmentLayout1.h"
#import "MDMultipleSegmentViewCell1.h"


#define kRedColor [[UIColor orangeColor] colorWithAlphaComponent:0.99]

@interface MDMultipleSegmentView1 ()<UICollectionViewDelegate,
UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) MDMultipleSegmentLayout1 *layout;

@end

@implementation MDMultipleSegmentView1



- (instancetype)init
{
    if (self = [super init]) {
        
        [self initialProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initialProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initialProperty];
    }
    
    return self;
}

- (void)initialProperty
{
    //    _titleFont = [UIFont systemFontOfSize:16];
    _titleFont = BOLDSYSTEMFONT(16);
    _titleNormalColor = RGB(51, 51, 51);
    _titleSelectColor = RGB(10, 147, 255);
    _selectedSegmentIndex = 0;
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = self.backgroundColor =  [UIColor whiteColor];
    // 设置约束
    //创建宽度约束
    NSLayoutConstraint * constraintw =  [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    //创建高度约束
    NSLayoutConstraint * constrainth = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    //水平居中约束
    NSLayoutConstraint * constraintCenterX =  [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //竖直居中
    NSLayoutConstraint * constraintCenterY =  [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    //添加约束之前，必须将视图加在父视图上
    [self addSubview:self.collectionView];
    [self addConstraints:@[constrainth,constraintw,constraintCenterX, constraintCenterY]];
}


#pragma mark - Engine
-(void)updateView{
    [self.collectionView reloadData];
}

#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置具体属性
        // 1.设置 最小行间距
        layout.minimumLineSpacing = 20;
        // 2.设置 最小列间距
        layout. minimumInteritemSpacing  = 0;
        // 3.设置item块的大小 (可以用于自适应)
        layout.estimatedItemSize = CGSizeMake(20, 44);
        // 设置滑动的方向 (默认是竖着滑动的)
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        // 设置item的内边距
        layout.sectionInset = UIEdgeInsetsMake(0,20,0,0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:[MDMultipleSegmentViewCell1 class] forCellWithReuseIdentifier:NSStringFromClass([MDMultipleSegmentViewCell1 class])];
        
    }
    return _collectionView;
}

- (MDMultipleSegmentLayout1 *)layout
{
    if (!_layout) {
        
        _layout = [[MDMultipleSegmentLayout1 alloc] init];
    }
    return _layout;
}

#pragma mark - Setter
- (void)setItems:(NSArray *)items
{
    _items = items;
    [self updateView];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    [self updateView];
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    [self updateView];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self updateView];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    _selectedSegmentIndex = selectedSegmentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self updateView];
}

- (void)selectIndex:(NSInteger)index
{
    self.selectedSegmentIndex = index;
}

#pragma mark -  CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _items.count;
 
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MDMultipleSegmentViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MDMultipleSegmentViewCell1 class]) forIndexPath:indexPath];
    
    cell.isSeleted = (indexPath.row == _selectedSegmentIndex ? YES : NO);
    cell.titleLabel.font = cell.isSeleted ? self.titleFont : [UIFont systemFontOfSize:16];
    cell.titleLabel.textColor = cell.isSeleted ? self.titleSelectColor : self.titleNormalColor;
    
    if (cell.isSeleted) {
    }
    
    NSString *str = [_items objectAtIndex:indexPath.row];
    if (str) {
        cell.titleLabel.text = [_items objectAtIndex:indexPath.row];
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    _selectedSegmentIndex = indexPath.row;
    [collectionView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeSegmentAtIndex1:)]) {
        
        [self.delegate changeSegmentAtIndex1:indexPath.row];
    }
}


@end

