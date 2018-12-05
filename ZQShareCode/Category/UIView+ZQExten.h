//
//  UIView+ZQExten.h
//  ZQDemoApp
//
//  Created by Macro on 2018/8/17.
//  Copyright © 2018年 张泉. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - layoutSubviews 布局回调
@interface UIView (LayoutSubviewsFinish)

/**
   layoutSubviews callback with block
   you need do something about layer with view's frame
   then  you can do it in this block
 
*/
@property (nonatomic,copy) void (^layoutSubviewsFinish)(UIView * view);

@end

#pragma mark - UIView 拖动
@interface UIView (Draggable)

/**
 *  Make view draggable.
 *
 *  @param view    Animator reference view, usually is super view.
 *  @param damping Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;
- (void)makeDraggable;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;


@end
