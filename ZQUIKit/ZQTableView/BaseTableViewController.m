//
//  BaseTableViewController.m
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseTableViewController.h"
#import "BaseViewController.h"
#import "MJRefresh.h"


@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                      = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor      = self.view.backgroundColor;
        _tableView.backgroundView       = nil;
        _tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource           = self.tableViewAdaptor;
        _tableView.delegate             = self.tableViewAdaptor;
        if (@available(iOS 11.0, *)) {
            // iOS 11 弃用了 automaticallyAdjustsScrollViewInsets 属性，Never 表示不计算内边距
            _tableView.contentInsetAdjustmentBehavior   = UIScrollViewContentInsetAdjustmentNever;
            // iOS 11 开启 Self-Sizing 之后，tableView 使用 estimateRowHeight 一点点地变化更新的 contentSize 的值。
            // 这样导致 setContentOffset 为 0 不能回到顶部，故禁用 Self-Sizing
            _tableView.estimatedRowHeight               = 0;
            _tableView.estimatedSectionHeaderHeight     = 0;
            _tableView.estimatedSectionFooterHeight     = 0;
        }
        
        _tableViewAdaptor.tableView     = _tableView;
    }
    return _tableView;
}

- (BaseTableViewAdaptor *)tableViewAdaptor {
    if (!_tableViewAdaptor) {
        _tableViewAdaptor               = [[BaseTableViewAdaptor alloc] init];
        _tableViewAdaptor.delegate      = self;
    }
    return _tableViewAdaptor;
}

@end
