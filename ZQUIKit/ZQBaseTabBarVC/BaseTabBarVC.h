//
//  BaseTabBarVC.h
//  ZQDemoApp
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/24.
//  Copyright © 2019 张泉. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITabBar (Category)
@property (nonatomic, strong, readonly) NSMutableArray<UIView*> *imageViewArray;
@end

@interface UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index;    //显示小红点
- (void)hideBadgeOnItemIndex:(int)index;    //隐藏小红点
@end

@interface BaseTabBarVC : UITabBarController

@end

