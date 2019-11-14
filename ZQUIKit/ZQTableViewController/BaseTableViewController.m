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
#import "UIColor+ZQAdd.h"
#import "UIViewController+ZQCustomizeNavBar.h"
#import "ZQMacros.h"


@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.zq_prefersNavigationBarHidden) {
         self.tableView.frame = self.view.bounds;
    }else {
        self.tableView.frame = CGRectMake(0, ZQNavBarHeight, ZQScreenWidth, ZQScreenHeight - ZQNavBarHeight);
    }
}

//手动初始化
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self didInitialize];
    }
    return self;
}
//xib 初始化
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
//        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.tableView = ({
        UITableView * tableview         = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableview.backgroundView       = nil;
        tableview;
    });
    self.tableViewAdaptor =({
        BaseTableViewAdaptor *tableViewAdaptor = [[BaseTableViewAdaptor alloc] init];
        tableViewAdaptor;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClassesWithReuseIds:@[@"ZQDefaultCell",@"ZQEmptyCell",@"ZQCustomDefaultCell"]];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF4F4F4];
    if (!self.tableView.superview) {
        [self.view addSubview:self.tableView];
    }
    
    if (@available(iOS 11.0, *)) {
        // iOS 11 弃用了 automaticallyAdjustsScrollViewInsets 属性，Never 表示不计算内边距
        self.tableView.contentInsetAdjustmentBehavior   = UIScrollViewContentInsetAdjustmentNever;
        // iOS 11 开启 Self-Sizing 之后，tableView 使用 estimateRowHeight 一点点地变化更新的 contentSize 的值。
        // 这样导致 setContentOffset 为 0 不能回到顶部，故禁用 Self-Sizing
        //对于 Plain 类型的 tableView 而言，要去掉 header / footer 请使用 0，对于 Grouped 类型的 tableView 而言，要去掉 header / footer 请使用 CGFLOAT_MIN
        self.tableView.estimatedRowHeight               = 0;
        self.tableView.estimatedSectionHeaderHeight     = 0;
        self.tableView.estimatedSectionFooterHeight     = 0;
    }
    //设置代理
    self.tableViewAdaptor.tableView = self.tableView;
    self.tableViewAdaptor.delegate  = self;
    self.tableView.dataSource       = self.tableViewAdaptor;
    self.tableView.delegate         = self.tableViewAdaptor;
        
        
}


#pragma mark -  UIScrollViewDelegate
//重写需要调用的父类的改方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView NS_REQUIRES_SUPER {
    if (self.scrollAction) {
        self.scrollAction(scrollView);
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
