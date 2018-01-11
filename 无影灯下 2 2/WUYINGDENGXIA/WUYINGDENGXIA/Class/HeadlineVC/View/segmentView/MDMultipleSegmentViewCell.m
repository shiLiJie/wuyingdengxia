//
//  MDMultipleSegmentViewCell.m
//  MDMultipleSegment
//
//  Created by 梁宪松 on 2017/8/29.
//  Copyright © 2017年 Madao. All rights reserved.
//

#import "MDMultipleSegmentViewCell.h"

@interface MDMultipleSegmentViewCell()

@property (nonatomic, strong) UIColor *tintColor;

@end

@implementation MDMultipleSegmentViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bottomLineWidth = 1.0f;
        _tintColor = [UIColor blueColor];
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(0,
                                           0,
                                           CGRectGetWidth(frame),
                                           CGRectGetHeight(frame));
    }
    return self;
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
        _titleLabel.font = [UIFont systemFontOfSize:16];
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
        [linePath moveToPoint:CGPointMake(CGRectGetMaxX(_titleLabel.frame)/3, y)];
        [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(_titleLabel.frame)/3*2, y)];
        linePath.lineWidth = _bottomLineWidth;
        [circleColor setStroke];
        [linePath stroke];
    }
}

@end
