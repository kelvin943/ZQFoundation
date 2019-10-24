//
//  HoverTableViewController.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/16.
//

#import <ZQFoundation/ZQFoundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface HoverTableViewController : BaseViewController
@property (nonatomic, strong) IBOutlet UITableView * tableView;

- (void)reloadPage;

@end




NS_ASSUME_NONNULL_END
