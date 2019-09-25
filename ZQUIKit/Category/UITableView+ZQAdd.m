//
//  UITableView+ZQAdd.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/25.
//

#import "UITableView+ZQAdd.h"
#import "UIViewController+ZQAdd.h"
#import <objc/runtime.h>
#import "ZQMacros.h"


//ZQCATEGORY_DUMMY_CLASS(UITableView_ZQEmptyData)

@implementation UITableView_ZQEmptyData

@end

@interface UITableView ()
@property (nonatomic, strong) ZQExceptionView *placeholderView; //没数据时的展位图
@end

@implementation UITableView (ZQEmptyData)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method newMethod = class_getInstanceMethod(self, @selector(zq_reloadData));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}

- (void)zq_reloadData{
    if (!self.firstReload) {
        if (self.isShowEmpty) {// 如果通过 tableview 的 datesource 来判断可能存在误判，因为 datesource 可能加入一些非业务数据来渲染界面
            //通过业务方设置此属性来决定是否显示空数据占位图
            if (!self.placeholderView.superview) {
                [self addSubview:self.placeholderView];
            }
            self.placeholderView.hidden = NO;
        }else {
            self.placeholderView.hidden = YES;
        }
    }
    self.firstReload = NO;
    [self zq_reloadData];
}


- (void)emptyViewTap:(id)sender {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}
#pragma mark - 类目添加的属性
- (ZQExceptionView *)placeholderView {
    if(!objc_getAssociatedObject(self, _cmd)) {
        CGRect emptyFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        ZQExceptionView * emptyView = [[ZQExceptionView alloc] initWithFrame:emptyFrame];
        [emptyView setImage:@"tableview_empty_data"];
        [emptyView setText:@"数据为空，轻触屏幕重新加载"];
        objc_setAssociatedObject(self, _cmd, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //空数据点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyViewTap:)];
        [emptyView addGestureRecognizer:tapGesture];
        return emptyView;
    }else{
        return objc_getAssociatedObject(self, _cmd);
    }
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isShowEmpty {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsShowEmpty:(BOOL)isShowEmpty {
    objc_setAssociatedObject(self, @selector(isShowEmpty), @(isShowEmpty), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


@interface UICollectionView ()
@property (nonatomic, strong) ZQExceptionView *placeholderView; //没数据时的展位图
@end
@implementation UICollectionView (ZQEmptyData)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method newMethod = class_getInstanceMethod(self, @selector(zq_reloadData));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}

- (void)zq_reloadData{
    if (!self.firstReload) {
        if (self.isShowEmpty) {// 如果通过 tableview 的 datesource 来判断可能存在误判，因为 datesource 可能加入一些非业务数据来渲染界面
            //通过业务方设置此属性来决定是否显示空数据占位图
            if (!self.placeholderView.superview) {
                [self addSubview:self.placeholderView];
            }
            self.placeholderView.hidden = NO;
        }else {
            self.placeholderView.hidden = YES;
        }
    }
    self.firstReload = NO;
    [self zq_reloadData];
}


- (void)emptyViewTap:(id)sender {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}
#pragma mark - 类目添加的属性
- (ZQExceptionView *)placeholderView {
    if(!objc_getAssociatedObject(self, _cmd)) {
        CGRect emptyFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        ZQExceptionView * emptyView = [[ZQExceptionView alloc] initWithFrame:emptyFrame];
        [emptyView setImage:@"tableview_empty_data"];
        [emptyView setText:@"数据为空，轻触屏幕重新加载"];
        objc_setAssociatedObject(self, _cmd, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //空数据点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyViewTap:)];
        [emptyView addGestureRecognizer:tapGesture];
        return emptyView;
    }else{
        return objc_getAssociatedObject(self, _cmd);
    }
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isShowEmpty {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsShowEmpty:(BOOL)isShowEmpty {
    objc_setAssociatedObject(self, @selector(isShowEmpty), @(isShowEmpty), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
