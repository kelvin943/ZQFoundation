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

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) BaseTableViewAdaptor * tableViewAdaptor;

@end

NS_ASSUME_NONNULL_END
