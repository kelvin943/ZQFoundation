//
//  BaseTableViewController.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseViewController.h"
#import "BaseTableViewAdaptor.h"

typedef void(^TableViewDidScrollAction)(UIScrollView* scrollView);

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<BaseTableViewAdaptorDelegate>

@property (nonatomic, strong) IBOutlet UITableView * tableView;
@property (nonatomic, strong) IBOutlet BaseTableViewAdaptor * tableViewAdaptor;


//tableView是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
@property (nonatomic,  copy) TableViewDidScrollAction scrollAction;
@end

@interface UITableView (registerExtern)
- (void)registerNibsWithReuseIds:(NSArray<NSString*> *)arr;
- (void)registerClassesWithReuseIds:(NSArray<NSString*> *)arr;
@end
NS_ASSUME_NONNULL_END



