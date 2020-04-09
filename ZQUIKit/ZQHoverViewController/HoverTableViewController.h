//
//  HoverTableViewController.h
//  ZQFoundation
//
//  Created by 张泉(Macro) on 2019/10/16.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface HoverTableView : UITableView

@end

@interface HoverTableViewController : BaseViewController
@property (nonatomic, assign) BOOL isCanScroll;
@property (nonatomic, strong) IBOutlet HoverTableView * tableView;

- (void)reloadPage;

@end




NS_ASSUME_NONNULL_END
