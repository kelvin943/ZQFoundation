//
//  UIButton+ZQAdd.h
//  ZQDemoApp
//
//  Created by 张泉(macro) on 2019/3/1.
//  Copyright © 2019 张泉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//按钮点击事件回调
typedef void(^TouchUpInsideAction)(UIButton * _Nullable button);

//按钮图片和文字布局方式
typedef NS_ENUM(NSInteger, SCButtonLayoutStyle) {
    SCButtonLayoutStyleImageLeft,
    SCButtonLayoutStyleImageRight,
    SCButtonLayoutStyleImageTop,
    SCButtonLayoutStyleImageBottom,
};



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZQAdd)

@property (nullable,nonatomic,copy)TouchUpInsideAction touchUpInsideAction;

@end


@interface UIButton (Layout)

- (void)sc_setLayoutStyle:(SCButtonLayoutStyle)style spacing:(CGFloat)spacing;

@end


NS_ASSUME_NONNULL_END
