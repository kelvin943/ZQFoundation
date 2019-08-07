//
//  UIViewController+ZQCustomizeNavBar.m
//  ZQDemoApp
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/7/26.
//  Copyright © 2019 张泉. All rights reserved.
//

#import "UIViewController+ZQCustomizeNavBar.h"
#import <objc/runtime.h>

typedef void (^_ZQViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

static void __exchange_method(Class class, SEL originalSelector, SEL swizzlingSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSelector);
    
    BOOL didAddMethod =  class_addMethod( class, originalSelector,  method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzlingSelector, method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}

#pragma mark -
@interface _FullscreenPopGestureRecognizerImpl : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

#pragma mark - 自定义左滑返回的手势代理
@implementation _FullscreenPopGestureRecognizerImpl

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // Ignore when no view controller is pushed into the navigation stack.
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // Ignore when the active view controller doesn't allow interactive pop.
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.zq_interactivePopDisabled) {
        return NO;
    }
    
    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.zq_popEdgeRegionSize;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}
@end

#pragma mark -
@implementation ZQCustomNavBar

- (void)setBarAlpha:(CGFloat)barAlpha {
    _barAlpha = MAX(MIN(barAlpha, 1), 0);
    self.alpha = _barAlpha;
}
- (void)setBarColor:(UIColor *)barColor {
    _barColor = barColor;
    self.backgroundColor = barColor;
}

@end

@implementation UIViewController (ZQCustomizeNavBar)

#pragma mark - AssociatedObject

//是否是当前VC不受 InjectBlock 注入影响 
- (BOOL)zq_willAppearInjectBlockIgnored {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZq_willAppearInjectBlockIgnored:(BOOL)ignore {
    objc_setAssociatedObject(self, @selector(zq_willAppearInjectBlockIgnored), @(ignore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//是否隐藏导航栏
- (BOOL)zq_prefersNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setZq_prefersNavigationBarHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(zq_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//是否禁用左滑返回手势
- (BOOL)zq_interactivePopDisabled {
    NSNumber * popDisable =objc_getAssociatedObject(self, _cmd);
    if (!popDisable) {
        return NO; // default value  默认开启左滑返回
    }
    return popDisable. boolValue;
}

- (void)setZq_interactivePopDisabled:(BOOL)disabled {
    objc_setAssociatedObject(self, @selector(zq_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//左滑返回手势边缘范围
- (CGFloat)zq_popEdgeRegionSize {
    id edgeRegionSize =objc_getAssociatedObject(self, _cmd);
    if (!edgeRegionSize) {
        objc_setAssociatedObject(self, _cmd, @([UIScreen mainScreen].bounds.size.width -100), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return [UIScreen mainScreen].bounds.size.width -100 ; //默认为屏幕宽度 -100
    }
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setZq_popEdgeRegionSize:(CGFloat)distance {
    SEL key = @selector(zq_popEdgeRegionSize);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//导航栏背景view
- (void)setZq_CustomBar:(ZQCustomNavBar *)barHeadView  {
    objc_setAssociatedObject(self, @selector(zq_CustomNavBar), barHeadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (ZQCustomNavBar*)zq_CustomNavBar {
    if(!objc_getAssociatedObject(self, _cmd)){
        ZQCustomNavBar * barHeadView = [[ZQCustomNavBar alloc] initWithFrame:CGRectZero];
        objc_setAssociatedObject(self, _cmd, barHeadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return barHeadView;
    }else{
        return objc_getAssociatedObject(self, _cmd);
    }
}

@end


@interface UIViewController (ZQCustomizeNavBarPrivate)

@property (nonatomic, copy) _ZQViewControllerWillAppearInjectBlock zq_willAppearInjectBlock;

@end

@implementation UIViewController (ZQCustomizeNavBarPrivate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Inject "-viewDidLoad"
        __exchange_method([self class], @selector(viewDidLoad), @selector(vc_viewDidLoad));
        
        // Inject "-viewWillAppear"
        __exchange_method([self class], @selector(viewWillAppear:), @selector(vc_viewWillAppear:));
        
        // Inject "-viewWillDisappear"
        __exchange_method([self class], @selector(viewWillDisappear:), @selector(vc_viewWillDisappear:));
    });
}

#pragma mark - exchangeMethod

- (void)vc_viewDidLoad{
    //不隐藏导航栏的话添加一个headView
    if (self.navigationController && !self.zq_prefersNavigationBarHidden) {
        [self.view addSubview:self.zq_CustomNavBar];
        CGFloat screenWith   = [UIScreen mainScreen].bounds.size.width;
        CGFloat navBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
        self.zq_CustomNavBar.frame = CGRectMake(0, 0, screenWith, navBarHeight);
    }
    
    if (self.navigationController) {
        //VC包含在容器中就延伸到顶部
        self.edgesForExtendedLayout                 = UIRectEdgeTop;
        self.extendedLayoutIncludesOpaqueBars       = NO;
        
        if (!self.navigationItem.title ||self.navigationItem.title.length ==0 || self.navigationItem.title.length >= 4){//标题太长的时候返回按钮的文字自定义或者没有
            //设置vc.navigationItem.title必须在[super viewDidLoad] 之前
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
            backItem.title = @"返回";
            self.navigationItem.backBarButtonItem = backItem;
        }
    }
    
    // Forward to primary implementation.
    [self vc_viewDidLoad];
    
    [self.view bringSubviewToFront:self.zq_CustomNavBar];
    
    
}


- (void)vc_viewWillAppear:(BOOL)animated {
    // Forward to primary implementation.
    [self vc_viewWillAppear:animated];
    
    if (!self.zq_willAppearInjectBlockIgnored && self.zq_willAppearInjectBlock) {
        self.zq_willAppearInjectBlock(self, animated);
    }
}

- (void)vc_viewWillDisappear:(BOOL)animated {
    // Forward to primary implementation.
    [self vc_viewWillDisappear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *viewController = self.navigationController.viewControllers.lastObject;
        if (viewController && !viewController.zq_prefersNavigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }
    });
}


#pragma mark - AssociatedObject
- (_ZQViewControllerWillAppearInjectBlock)zq_willAppearInjectBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZq_willAppearInjectBlock:(_ZQViewControllerWillAppearInjectBlock)block {
    objc_setAssociatedObject(self, @selector(zq_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UINavigationController (ZQCustomizeNavBar)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Inject "-viewDidLoad"
        __exchange_method([self class], @selector(viewDidLoad), @selector(nav_viewDidLoad));
        
        // Inject "-pushViewController:animated:"
        __exchange_method([self class], @selector(pushViewController:animated:), @selector(zq_pushViewController:animated:));
    });
}

- (void)nav_viewDidLoad {
    //设置导航背景为透明色
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    [self nav_viewDidLoad];
}

- (void)zq_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed =YES;
    }
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.zq_fullscreenPopGestureRecognizer]) {
        
        // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.zq_fullscreenPopGestureRecognizer];
        
        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        self.zq_fullscreenPopGestureRecognizer.delegate = self.zq_popGestureRecognizerDelegate;
        [self.zq_fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    [self zq_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    // Forward to primary implementation.
    if (![self.viewControllers containsObject:viewController]) {
        [self zq_pushViewController:viewController animated:animated];
    }
}
- (void)zq_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingVC {
    
    __weak typeof(self) weakSelf = self;
    _ZQViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.zq_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // Setup will appear inject block to appearing view controller.
    // Setup disappearing view controller as well, because not every view controller is added into
    // stack by pushing, maybe by "-setViewControllers:".
    appearingVC.zq_willAppearInjectBlock = block;
    UIViewController *disappearingVC= self.viewControllers.lastObject;
    if (disappearingVC && !disappearingVC.zq_willAppearInjectBlock) {
        disappearingVC.zq_willAppearInjectBlock = block;
    }
    
}


#pragma mark -AssociatedObject
//自定义全屏左滑手势代理 ,get方法创建一个代理实现
- (_FullscreenPopGestureRecognizerImpl *)zq_popGestureRecognizerDelegate {
    _FullscreenPopGestureRecognizerImpl *impl = objc_getAssociatedObject(self, _cmd);
    if (!impl) {
        impl = [[_FullscreenPopGestureRecognizerImpl alloc] init];
        impl.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, impl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return impl;
}


//自定义全屏左滑手势
- (UIPanGestureRecognizer *)zq_fullscreenPopGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

@end

