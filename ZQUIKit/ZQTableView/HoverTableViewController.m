//
//  HoverTableViewController.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/16.
//

#import "HoverTableViewController.h"
#import "ZQPageViewController.h"
#import "ZQMacros.h"
#define TableHeadViewHeight  200
#define TableSectionHeight  50

static NSString *hoverCell = @"HoverCell";
static NSString *hoverHeadView = @"HoverHeadView";


@interface HoverTableViewCell()
@property (nonatomic,strong) ZQPageViewController *pageVC;
@end
@implementation HoverTableViewCell

//手动初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
//        [self setupContentView];
    }
    return self;
}


#pragma mark - lazy load
- (ZQPageViewController*)pageVC {
    if (!_pageVC) {
        _pageVC = [[ZQPageViewController alloc] init];
    }
    return _pageVC;
}


@end

@interface HoverTableViewController ()<UITableViewDelegate, UITableViewDataSource,ZQPageViewControllerDelegate>

@property (nonatomic,strong) ZQPageViewController *pageVC;

@end

@implementation HoverTableViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    [self.pageVC.view layoutIfNeeded];
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
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:hoverCell];
//    [self.tableView registerClass:[UITableViewCell class]  forHeaderFooterViewReuseIdentifier:hoverHeadView];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF4F4F4];
    if (!self.tableView.superview) {
        [self.view addSubview:self.tableView];
    }
    //设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.pageVC.delegate      = self;
    
    if (!self.tableView.tableHeaderView) {
        //如果设置过HeadView（如从 xib 或者 sb 初始化）父类就不处理
        //也可以在子类重新设置自定义 tableview head
        //以上两个都没处理，这里设置默认 300高度的head
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZQScreenWidth, TableHeadViewHeight)];
        headerView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = headerView;
    }
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = ZQScreenHeight - TableHeadViewHeight - TableSectionHeight;

}


#pragma mark - UITableViewDelegate / UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hoverCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hoverCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.pageVC.view];
    [self.pageVC reloadPages];
    return cell;
}

//可由子类重写
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZQScreenWidth, TableSectionHeight)];
    sectionHeadView.backgroundColor = [UIColor redColor];
    return sectionHeadView;
}

//可以有子类重写TableSectionHeight
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableSectionHeight;
}

#pragma mark - lazy load
- (ZQPageViewController*)pageVC {
    if (!_pageVC) {
        _pageVC = [[ZQPageViewController alloc] init];
        if ([self pageDataSource].count >0) {
            NSArray<UIViewController*>* arr  = [self pageDataSource];
            for (UIViewController * vc in arr) {
                [_pageVC addChildViewController:vc];
            }
        }
    }
    return _pageVC;
}

//由子类重写返回pagevc 的数据源
-(NSArray<UIViewController*>*)pageDataSource {
    return @[[UIViewController new]].copy;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView                 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}

- (void)reloadPage {
    [self.tableView reloadData];
}
@end
