//
//  BaseTableViewAdaptor.m
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseTableViewAdaptor.h"
#import "MJRefresh.h"

@interface BaseTableViewAdaptor()
@property (nonatomic,strong)MJRefreshNormalHeader *mjHeader;//mj下拉刷新控件
@property (nonatomic,strong)MJRefreshBackNormalFooter *mjFooter;//mj上拉加载
@end


@implementation BaseTableViewAdaptor




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    <#code#>
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    <#code#>
}

#pragma mark - getter/setter
- (NSMutableArray *)items{
    if (!_items) {
        _items = @[].mutableCopy;
    }
    return _items;
}


- (void)setPullRefreshEnable:(BOOL)pullRefreshEnable {
    _pullRefreshEnable = pullRefreshEnable;
    if (_pullRefreshEnable) {
        __weak typeof(self) weakSelf = self;
        self.mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(refreshReload:)]) {
                [weakSelf.delegate refreshReload:ZQTableViewRefreshTypePullDown];
            }
        }];
        self.tableView.mj_header = self.mjHeader;

       
    }
}
- (void)setLoadMoreEnable:(BOOL)loadMoreEnable {
    _loadMoreEnable = loadMoreEnable;
    if (_loadMoreEnable) {
        __weak typeof(self) weakSelf = self;
        self.mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(refreshReload:)]) {
                [weakSelf.delegate refreshReload:ZQTableViewRefreshTypePullUp];
            }
        }];
        self.tableView.mj_footer = self.mjFooter;
    } else {
        self.tableView.mj_footer = nil;
    }
}

@end
