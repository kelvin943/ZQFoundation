//
//  ZQPageViewController.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/17.
//

#import "ZQBookViewController.h"

@interface ZQBookViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>
@property (strong,  nonatomic) UIPageViewController *pageViewController;
@end

@implementation ZQBookViewController


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.pageViewController.view.frame = self.view.bounds;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}



- (void)setSelectPageWithIndex:(NSInteger)selectIndex hasNext:(BOOL)hasNext {
    if (selectIndex >= self.viewControllers.count) {
        return;
    }
    _currentIndex = selectIndex;
    [self.pageViewController setViewControllers:@[self.viewControllers[selectIndex]]
                                      direction:hasNext?UIPageViewControllerNavigationDirectionForward:
                                                        UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

#pragma mark - UIPageViewControllerDelegate
// 将要滑动
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
//    NSLog(@"将要滑动");

}
// 结束滑动
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
//    NSLog(@"结束滑动");
    if (completed && finished) {
        UIViewController *nextVC = [pageViewController.viewControllers firstObject];
        _currentIndex = [self.viewControllers indexOfObject:nextVC];
    }
}

// 根据index得到对应的UIViewController
- (nullable UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index < self.viewControllers.count) {
        return self.viewControllers[index];
    }
    return nil;
}

#pragma mark - UIPageViewControllerDataSource
//向前滑动
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController                              viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
//向后滑动
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController                               viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound || index >= self.viewControllers.count) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}


#pragma mark - lazy load
- (UIPageViewController*)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}


@end
