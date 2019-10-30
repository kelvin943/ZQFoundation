//
//  ZQHoverViewController.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/30.
//

#import "BaseViewController.h"
#import "ZQHoverScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQHoverViewController : BaseViewController

@property (nonatomic, assign) BOOL isCanScroll;
@property (nonatomic, strong) ZQHoverScrollView * hoverScrollView;

@end

NS_ASSUME_NONNULL_END
