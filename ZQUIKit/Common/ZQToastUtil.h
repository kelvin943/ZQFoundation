//
//  ZQToastUtil.h
//  ZQFoundation
//
//  Created by macro on 2019/9/26.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    ToastUtilPositionCenter,
    ToastUtilPositionBottom,
    ToastUtilPositionTop,
} ToastUtilPosition;

@interface ZQToastUtil : NSObject

// 显示提示信息， s代表提示内容，view为要展示信息得view，一般为self.view
+ (void)showNotice:(NSString *)text;
+ (void)showNotice:(NSString *)text inView:(UIView *)view;
+ (void)showNotice:(NSString *)text inView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)showNotice:(NSString *)text inView:(UIView *)view duration:(NSTimeInterval)duration completion:(void(^)(void))completion;
+ (void)showNotice:(NSString *)aText inView:(UIView *)aView position:(ToastUtilPosition)aPosition space:(CGFloat)aSpace;
+ (void)hideNotice;

@end

