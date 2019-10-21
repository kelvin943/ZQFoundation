//
//  HoverTableViewController.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/16.
//

#import "HoverTableViewController.h"
#import "ZQMacros.h"
#define TableHeadViewHeight  300
#define TableSectionHeight  50

static NSString *hoverCell = @"HoverCell";
static NSString *hoverHeadView = @"HoverHeadView";


@interface HoverTableViewCell()
@end
@implementation HoverTableViewCell

//手动初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

@end

@interface HoverTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HoverTableViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
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
        UITableView * tableview         = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor      = self.view.backgroundColor;
        tableview.backgroundView       = nil;
        tableview;
    });
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:hoverCell];
    [self.tableView registerClass:[UITableViewCell class]  forHeaderFooterViewReuseIdentifier:hoverHeadView];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xF4F4F4];
    if (!self.tableView.superview) {
        [self.view addSubview:self.tableView];
    }
    //设置代理
    self.tableView.dataSource       = self;
    self.tableView.delegate         = self;
    
    if (!self.tableView.tableHeaderView) {
        //如果设置过HeadView（如从 xib 或者 sb 初始化）父类就不处理
        //也可以在子类重新设置自定义 tableview head
        //以上两个都没处理，这里设置默认 300高度的head
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZQScreenWidth, TableHeadViewHeight)];
        headerView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = headerView;
    }
}


#pragma mark - UITableViewDelegate / UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hoverCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hoverCell];
        
        /// 在tableViewCell中添加控制器
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell.contentView addSubview:self.collectionView];
    }
    
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

@end
