//
//  MDMultipleSegmentViewCell1.m
//  WUYINGDENGXIA
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 医视中国. All rights reserved.
//

#import "MDMultipleSegmentViewCell1.h"

@interface MDMultipleSegmentViewCell1()

@property (nonatomic, strong) UIColor *tintColor;

@end

@implementation MDMultipleSegmentViewCell1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bottomLineWidth = 2.0f;
        _tintColor = RGB(10, 147, 255);
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(0,
                                           0,
                                           CGRectGetWidth(frame),
                                           CGRectGetHeight(frame));
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    
    
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.titleLabel.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName, nil] context:nil];
    
    frame.size.height = 44;
    attributes.frame = frame;
    
    //如果你cell上的子控件不是用约束来创建的,那么这边必须也要去修改cell上控件的frame才行
    self.titleLabel.frame = CGRectMake(0, 0, attributes.frame.size.width, 44);
    
    return attributes;
}

- (void)setIsSeleted:(BOOL)isSeleted
{
    _isSeleted = isSeleted;
    if (_isSeleted) {
        _titleLabel.textColor = _tintColor;
        
    }else
    {
        _titleLabel.textColor = [UIColor blackColor];
    }
    [self setNeedsDisplay];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = _tintColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)drawRect:(CGRect)rect
{
    if (_isSeleted) {
        UIColor *circleColor = _tintColor;
        
        UIBezierPath* linePath = [UIBezierPath bezierPath];
        CGFloat y = CGRectGetHeight(rect) - _bottomLineWidth;
        //        [linePath moveToPoint:CGPointMake(CGRectGetMaxX(_titleLabel.frame)/3, y)];
        //        [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(_titleLabel.frame)/3*2, y)];
        [linePath moveToPoint:CGPointMake(_titleLabel.center.x-12, y)];
        [linePath addLineToPoint:CGPointMake(_titleLabel.center.x+12, y)];
        linePath.lineWidth = _bottomLineWidth;
        linePath.lineCapStyle = kCGLineCapRound; //线条拐角
        linePath.lineJoinStyle = kCGLineJoinRound; //终点处理
        [circleColor setStroke];
        [linePath stroke];
    }
}

@end
