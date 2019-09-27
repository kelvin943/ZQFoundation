//
//  BaseTableViewController.m
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#import "BaseTableViewController.h"
#import "BaseViewController.h"


@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

//xib 初始化
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        //保证从xib 初始化后其他的设置和手动初始化设置一样
        if (_tableView && _tableViewAdaptor) {
            self.tableViewAdaptor.delegate  = self;
             self.tableViewAdaptor.tableView = self.tableView;
             if (@available(iOS 11.0, *)) {
                self.tableView.contentInsetAdjustmentBehavior   = UIScrollViewContentInsetAdjustmentNever;
                self.tableView.estimatedRowHeight               = CGFLOAT_MIN;
                self.tableView.estimatedSectionHeaderHeight     = CGFLOAT_MIN;
                self.tableView.estimatedSectionFooterHeight     = CGFLOAT_MIN;
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.tableView.superview) {
        [self.view addSubview:self.tableView];
    }
}

#pragma mark -  BaseTableViewAdaptorDelegate
//按需由子类复写
- (void)tableView:(UITableView *)tableView
  didSelectObject:(id<CellModelBasicProtocol>)object
      atIndexPath:(NSIndexPath *)indexPath {}

- (void)tableView:(UITableView *)tableView
     didSetObject:(id<CellModelBasicProtocol>)object
             cell:(UITableViewCell *)cell {}

- (void)refreshReload:(ZQTableViewRefreshType)pullType {}


#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                      = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor      = self.view.backgroundColor;
        _tableView.backgroundView       = nil;
//        _tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource           = self.tableViewAdaptor;
        _tableView.delegate             = self.tableViewAdaptor;
        if (@available(iOS 11.0, *)) {
            // iOS 11 弃用了 automaticallyAdjustsScrollViewInsets 属性，Never 表示不计算内边距
            _tableView.contentInsetAdjustmentBehavior   = UIScrollViewContentInsetAdjustmentNever;
            // iOS 11 开启 Self-Sizing 之后，tableView 使用 estimateRowHeight 一点点地变化更新的 contentSize 的值。
            // 这样导致 setContentOffset 为 0 不能回到顶部，故禁用 Self-Sizing
            _tableView.estimatedRowHeight               = CGFLOAT_MIN;
            _tableView.estimatedSectionHeaderHeight     = CGFLOAT_MIN;
            _tableView.estimatedSectionFooterHeight     = CGFLOAT_MIN;
        }
    }
    return _tableView;
}

- (BaseTableViewAdaptor *)tableViewAdaptor {
    if (!_tableViewAdaptor) {
        _tableViewAdaptor               = [[BaseTableViewAdaptor alloc] init];
        _tableViewAdaptor.delegate      = self;
        _tableViewAdaptor.tableView     = self.tableView;
    }
    return _tableViewAdaptor;
}

@end


@implementation UITableView (registerExtern)
- (void)registerNibsWithReuseIds:(NSArray<NSString*> *)arr {
    [arr enumerateObjectsUsingBlock:^(NSString*  _Nonnull reuseID, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerNib:[UINib nibWithNibName:reuseID bundle:nil] forCellReuseIdentifier:reuseID];
    }];
}

- (void)registerClassesWithReuseIds:(NSArray<NSString*> *)arr {
    [arr enumerateObjectsUsingBlock:^(NSString*  _Nonnull reuseID, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerClass:NSClassFromString(reuseID) forCellReuseIdentifier:reuseID];
    }];
}
@end
