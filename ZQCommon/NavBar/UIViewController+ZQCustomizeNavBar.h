//
//  UIViewController+ZQCustomizeNavBar.h
//  ZQDemoApp
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/7/26.
//  Copyright © 2019 张泉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQCustomNavBar : UIView

/// 导航栏背景颜色的透明度(0,1)
@property (nonatomic, assign) CGFloat barAlpha;
/// 导航栏的vc 自己navBar的颜色
@property (nonatomic, strong) UIColor *barColor UI_APPEARANCE_SELECTOR;

@end


@interface UIViewController (ZQCustomizeNavBar)

/// Indicate this view controller prefers its navigation bar hidden or not,
/// checked when view controller based navigation bar's appearance is enabled.
/// Default to NO, bars are more likely to show.
@property (nonatomic, assign) BOOL zq_prefersNavigationBarHidden;
/// 左滑返回手势是否禁用
@property (nonatomic, assign) BOOL zq_interactivePopDisabled;
/// 左滑返回手势的触发范围（默认边缘值 13）
@property (nonatomic, assign) CGFloat zq_popEdgeRegionSize;

@property (nonatomic, strong, readonly) ZQCustomNavBar *zq_CustomNavBar;

@end

@interface UINavigationController (ZQCustomizeNavBar)

/// The gesture recognizer that actually handles interactive pop.
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *zq_fullscreenPopGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
