//
//  UIView+TRExtension.m
//  Pods-Transparring_Example
//
//  Created by 姜政 on 2020/4/14.
//

#import "UIView+TRExtension.h"

@implementation UIView (TRExtension)


-(void)addEdgeInset:(UIEdgeInsets)inset subView:(UIView *)subView{
    subView.translatesAutoresizingMaskIntoConstraints = NO;
   [self addConstraints:@[
                                      // 顶部
                                             [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:inset.top],
                                      // 左边
                                      [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:inset.left],
                                      
                                      // 右边
                                      [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant: - inset.right],
                                      
                                      // 底部
                                      [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant: - inset.bottom]
                                      ]];
}

#pragma mark - 设置部分圆角

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    shape.frame = self.bounds;
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}
@end
