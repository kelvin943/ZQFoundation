//
//  UIViewController+ZQAdd.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/25.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewExceptionType) {
    UIViewExceptionTypeServiceError     =  1,      // 服务出错
    UIViewExceptionTypeNetworkError     =  2,      // 网络出错
    /*空数据的情况放在 UITableView 分类中 由 UITableView 自动处理*/
    //UIViewExceptionTypeNullData         =  3,      // 数据为空
};

@interface ZQExceptionView : UIView
// 设置异常标题
- (void)setText:(NSString *)title;
// 设置异常图片
- (void)setImage:(NSString *)imageNamed;

@end


@interface UIViewController (Exception)

- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName;
- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName atView:(UIView *)view;
- (void)showExceptionTitle:(NSString *)title imageName:(NSString *)imageName top:(CGFloat)top;
- (void)showExceptionView:(UIViewExceptionType)exceptionType;
- (void)showExceptionView:(UIViewExceptionType)exceptionType atView:(UIView *)view;
- (void)showExceptionView:(UIViewExceptionType)exceptionType top:(CGFloat)top;

- (void)hideExceptionView;
// 设置服务异常图片
- (NSString *)serviceErrorImageNameForExceptionView;
// 设置服务出错文字
- (NSString *)serviceErrorTitleForExceptionView;

// 设置网络出错图片
- (NSString *)networkErrorImageNameForExceptionView;
// 设置网络出错文字
- (NSString *)networkErrorTitleForExceptionView;

// 异常视图被点击事件
- (void)exceptionViewClickAction;

@end

