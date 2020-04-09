//
//  ZQPageViewController.h
//  ZQFoundation
//
//  基于 UIPageViewController 封装的分页控制器，
//  Created by 张泉(Macro) on 2019/10/17.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQBookViewController : BaseViewController

@property (nonatomic,assign,readonly) NSInteger currentIndex;
@property (nonatomic,strong) NSArray<__kindof UIViewController *> *viewControllers;

- (void)setSelectPageWithIndex:(NSInteger)selectIndex hasNext:(BOOL)hasNext;

@end

NS_ASSUME_NONNULL_END
