//
//  UIView+ZQExten.m
//  ZQDemoApp
//
//  Created by 张泉(macro) on 2018/8/17.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import "UIView+ZQExten.h"
#import <objc/runtime.h>
#import "ZQMacros.h"

ZQCATEGORY_DUMMY_CLASS(UIView_ZQAdd)
#pragma mark - View 布局
@implementation UIView (Layout)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

#pragma mark - layoutSubviews 布局回调
@implementation UIView (LayoutSubviewsFinish)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
        Method newMethod = class_getInstanceMethod(self, @selector(_zq_layoutSubviews));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}
- (void)_zq_layoutSubviews {
    [self _zq_layoutSubviews];
    !self.layoutSubviewsFinish ?: self.layoutSubviewsFinish(self);
}

- (void (^)(UIView *))layoutSubviewsFinish {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLayoutSubviewsFinish:(void (^)(UIView *))layoutSubviewsFinish {
    objc_setAssociatedObject(self, @selector(layoutSubviewsFinish), layoutSubviewsFinish, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

#pragma mark - View Draggable
@implementation UIView (Draggable)

- (void)makeDraggable{
    NSAssert(self.superview, @"Super view is required when make view draggable");
    [self makeDraggableInView:self.superview damping:0.4];
}

- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping{
    if (!view) return;
    [self removeDraggable];
    
    self.zy_playground = view;
    self.zy_damping = damping;
    
    [self zy_creatAnimator];
    [self zy_addPanGesture];
}

- (void)removeDraggable{
    [self removeGestureRecognizer:self.zy_panGesture];
    self.zy_panGesture = nil;
    self.zy_playground = nil;
    self.zy_animator = nil;
    self.zy_snapBehavior = nil;
    self.zy_attachmentBehavior = nil;
    self.zy_centerPoint = CGPointZero;
}

- (void)updateSnapPoint {
    self.zy_centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) toView:self.zy_playground];
    self.zy_snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.zy_centerPoint];
    self.zy_snapBehavior.damping = self.zy_damping;
}

- (void)zy_creatAnimator {
    self.zy_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.zy_playground];
    [self updateSnapPoint];
}

- (void)zy_addPanGesture {
    self.zy_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zy_panGesture:)];
    [self addGestureRecognizer:self.zy_panGesture];
}

- (void)zy_panGesture:(UIPanGestureRecognizer *)pan {
    CGPoint panLocation = [pan locationInView:self.zy_playground];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self updateSnapPoint];
        
        UIOffset offset = UIOffsetMake(panLocation.x - self.zy_centerPoint.x, panLocation.y - self.zy_centerPoint.y);
        [self.zy_animator removeAllBehaviors];
        self.zy_attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self
                                                               offsetFromCenter:offset
                                                               attachedToAnchor:panLocation];
        [self.zy_animator addBehavior:self.zy_attachmentBehavior];
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.zy_attachmentBehavior setAnchorPoint:panLocation];
    }
    else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed) {
        [self.zy_animator addBehavior:self.zy_snapBehavior];
        [self.zy_animator removeBehavior:self.zy_attachmentBehavior];
    }
}
- (void)setZy_playground:(id)object {
    objc_setAssociatedObject(self, @selector(zy_playground), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)zy_playground {
    return objc_getAssociatedObject(self, @selector(zy_playground));
}

- (void)setZy_animator:(id)object {
    objc_setAssociatedObject(self, @selector(zy_animator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicAnimator *)zy_animator {
    return objc_getAssociatedObject(self, @selector(zy_animator));
}

- (void)setZy_snapBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(zy_snapBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UISnapBehavior *)zy_snapBehavior {
    return objc_getAssociatedObject(self, @selector(zy_snapBehavior));
}

- (void)setZy_attachmentBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(zy_attachmentBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAttachmentBehavior *)zy_attachmentBehavior {
    return objc_getAssociatedObject(self, @selector(zy_attachmentBehavior));
}

- (void)setZy_panGesture:(id)object {
    objc_setAssociatedObject(self, @selector(zy_panGesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)zy_panGesture {
    return objc_getAssociatedObject(self, @selector(zy_panGesture));
}

- (void)setZy_centerPoint:(CGPoint)point {
    objc_setAssociatedObject(self, @selector(zy_centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)zy_centerPoint {
    return [objc_getAssociatedObject(self, @selector(zy_centerPoint)) CGPointValue];
}

- (void)setZy_damping:(CGFloat)damping {
    objc_setAssociatedObject(self, @selector(zy_damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)zy_damping {
    return [objc_getAssociatedObject(self, @selector(zy_damping)) floatValue];
}


@end
