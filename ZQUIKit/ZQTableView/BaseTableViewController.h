//
//  BaseTableViewController.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseViewController.h"
#import "BaseTableViewAdaptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<BaseTableViewAdaptorDelegate>

@property (nonatomic, strong) IBOutlet UITableView * tableView;
@property (nonatomic, strong) IBOutlet BaseTableViewAdaptor * tableViewAdaptor;

@end

@interface UITableView (registerExtern)
- (void)registerNibsWithReuseIds:(NSArray<NSString*> *)arr;
- (void)registerClassesWithReuseIds:(NSArray<NSString*> *)arr;
@end
NS_ASSUME_NONNULL_END



