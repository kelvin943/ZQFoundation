//
//  ZQHoverScrollView.h
//  ZQFoundation
//
//  Created by 张泉(Macro) on 2019/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZQHoverScrollView;
@protocol ZQHoverScrollViewDataSource <NSObject>

@required
- (UIView*)headViewForHoverView:(ZQHoverScrollView*)hoverView;
- (UIView*)hoverViewForHoverView:(ZQHoverScrollView*)hoverView;
@optional
- (CGFloat)heightForHeadView;
- (CGFloat)heightForHoverView;

@end

@interface ZQHoverScrollView : UIScrollView

@property (nonatomic,strong) UIView* headView;
@property (nonatomic,strong) UIView* hoverView;
@property (nonatomic, weak, nullable) id <ZQHoverScrollViewDataSource> dataSource;
@end

NS_ASSUME_NONNULL_END
