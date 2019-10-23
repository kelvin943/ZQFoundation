//
//  ZQPageViewController.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/18.
//


/** used
 self.pageVC = [[ZQPageViewController alloc ] init];
 [self.view addSubview:self.pageVC.view];
 {
     UIViewController * tempVC = [[UIViewController alloc] init];
     tempVC.view.backgroundColor = ZQRandomColor;
     [self.pageVC addChildViewController:tempVC];
 }
 
 {
     UIViewController * tempVC = [[UIViewController alloc] init];
     tempVC.view.backgroundColor = ZQRandomColor;
     [self.pageVC addChildViewController:tempVC];
 }
 {
        UIViewController * tempVC = [[UIViewController alloc] init];
        tempVC.view.backgroundColor = ZQRandomColor;
        [self.pageVC addChildViewController:tempVC];
 }
 [self.pageVC reladPages];
 */

#import <ZQFoundation/ZQFoundation.h>

@class ZQPageViewController;
@protocol ZQPageViewControllerDelegate <NSObject>
@optional
- (void)pageViewController:(ZQPageViewController*)pageViewController didScrolledXPercetage:(CGFloat)XPercetage;


@end

NS_ASSUME_NONNULL_BEGIN

@interface ZQPageCollectionCell : UICollectionViewCell

@property (nonatomic, weak) __kindof UIViewController *viewController;
+ (NSString *)reuseIdentifier;
- (void)addChildViewIfNeeded;

@end


@interface ZQPageViewController : BaseViewController
// Page VC 滚动的区域，默认全屏滚动
@property (nonatomic, assign) UIEdgeInsets pageContetnInset;
@property (nonatomic, weak) id<ZQPageViewControllerDelegate> delegate;

- (void)reloadPages;
@end

NS_ASSUME_NONNULL_END
