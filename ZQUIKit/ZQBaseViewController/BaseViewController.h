//
//  BaseViewController.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import <UIKit/UIKit.h>


@protocol BaseViewControllerProtocol <NSObject>
@optional
//default is no
- (BOOL)disableInteractiveGesture;
//default is no
- (BOOL)needAddTapGestureDismissKeyborad;
@end

@protocol ZQNavigatorProtocol <NSObject>
@required
//参数化构建
- (instancetype)initWithQuery:(NSDictionary *)query;
@end

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<BaseViewControllerProtocol,ZQNavigatorProtocol>

@end

NS_ASSUME_NONNULL_END
