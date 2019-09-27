//
//  BaseTabBarVC.m
//  ZQDemoApp
//
//  Created by 张泉(macro) on 2019/9/24.
//  Copyright © 2019 张泉. All rights reserved.
//

#import "BaseTabBarVC.h"
#import <objc/runtime.h>

#pragma mark - UITabBar (Category)
@implementation UITabBar (Category)
- (NSMutableArray<UIView*> *)imageViewArray {
    NSMutableArray * imageArr =objc_getAssociatedObject(self, _cmd);
    if (!imageArr &&  !imageArr.count) {
        NSMutableArray * tempArr = @[].mutableCopy;
        for (UIView *childView in self.subviews) {
            /**找到 UITabBarItem 的按钮**/
            if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                continue;
            }
            /** tabbar的图片*/
            for (UIView *tabBtnChildView in childView.subviews) {
                if ([tabBtnChildView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    [tempArr addObject:tabBtnChildView];
                }
            }
        }
        return tempArr;
    }
    return imageArr;
}

@end

#pragma mark - UITabBar (Badge)
@implementation UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIImageView *badgeView = [[UIImageView alloc] init];
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;
    badgeView.layer.masksToBounds = YES;
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.55) / self.imageViewArray.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * 49);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end


#pragma mark - BaseTabBarVC 
@interface BaseTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

//选中动画
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //tabBarItems图片的抖动动画
    NSInteger index = [tabBar.items indexOfObject:item];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.6,@0.9,@1.4,@0.95,@1.2,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [[[tabBar.imageViewArray objectAtIndex:index] layer] addAnimation:animation forKey:nil];
}


@end
