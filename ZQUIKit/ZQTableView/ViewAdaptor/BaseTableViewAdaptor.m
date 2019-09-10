//
//  BaseTableViewAdaptor.m
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseTableViewAdaptor.h"
#import "MJRefresh.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewAdaptor()
@property (nonatomic,strong)MJRefreshNormalHeader *mjHeader;//mj下拉刷新控件
@property (nonatomic,strong)MJRefreshBackNormalFooter *mjFooter;//mj上拉加载
@end

@implementation BaseTableViewAdaptor

#pragma mark - private
//获取 cell 的indexPath 获取cell 的模型
- (id<CellModelBasicProtocol>)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cellModel  = nil;
    if (self.items.count > indexPath.row) {
        cellModel = [self.items objectAtIndex:indexPath.row];
    }
    return cellModel;
}
//根据 cell 的indexPath获取对应的cellClass
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath {
    id<CellModelBasicProtocol> cellModel  = [self cellModelForRowAtIndexPath:indexPath];
    if (cellModel && [cellModel respondsToSelector:@selector(cellClass)]) {
        return [cellModel cellClass];
    }else {
        return nil;
    };
}
// 根据 indexPath 获取 Cell 的重用 Identifier
- (NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    Class cellClass = [self cellClassForIndexPath:indexPath];
    if ([cellClass respondsToSelector:@selector(cellIdentifier)]) {
        identifier = [cellClass cellIdentifier];
    }
    return identifier;
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id<CellModelBasicProtocol> cellModel = [self cellModelForRowAtIndexPath:indexPath];
    NSString *identifier    = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        Class cellClass = [self cellClassForIndexPath:indexPath];
        if (cellClass) {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }else {
            cell = [[UITableViewCell alloc]init];
        }
    }
    //设置 cell 数据
    if ([cell isKindOfClass:[BaseTableViewCell class]]) {
        [(BaseTableViewCell*)cell setCellModel:cellModel];
    }
    //通知 VC 已经设置 cell 数据
    if ([self.delegate respondsToSelector:@selector(tableView:didSetObject:cell:)]) {
        [self.delegate tableView:tableView didSetObject:cellModel cell:cell];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = CGFLOAT_MIN;
    
    id<CellModelBasicProtocol> cellModel = [self cellModelForRowAtIndexPath:indexPath];
    Class cellClass = nil;
    if (cellModel && [cellModel respondsToSelector:@selector(cellClass)]) {
        cellClass =  [cellModel cellClass];
    }
    //根据cell class 对象获取缓存高度
    rowHeight = [cellClass tableView:tableView rowHeightForObject:cellModel];
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<CellModelBasicProtocol> object = [self cellModelForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectObject:atIndexPath:)]) {
        [self.delegate tableView:tableView didSelectObject:object atIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.delegate tableView:self.tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"Delete";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}





#pragma mark - UIScrollViewDelegate
// 保证UIScrollViewDelegate 的正常回调

// any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}
// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2) {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.delegate scrollViewDidZoom:scrollView];
    }
}
// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}
// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

// return a view that will be scaled. if delegate returns nil, nothing happens
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.delegate viewForZoomingInScrollView:scrollView];
    }else{
        return nil;
    }
}
// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2) {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}
// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}
// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return  [self.delegate scrollViewShouldScrollToTop:scrollView];
    }else {
        return YES;
    }
}
// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegate scrollViewDidScrollToTop:scrollView];
    }
}

/* Also see -[UIScrollView adjustedContentInsetDidChange]
 */
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.delegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
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
