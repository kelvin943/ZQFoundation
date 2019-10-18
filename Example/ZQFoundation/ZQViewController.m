//
//  ZQViewController.m
//  ZQFoundation
//
//  Created by macro on 11/15/2018.
//  Copyright (c) 2018 macro. All rights reserved.
//

#import "ZQViewController.h"
#import "BaseTableViewCell.h"
#import "YYClassInfo.h"
#import "TestVC.h"


@interface ZQViewController ()

@end

@implementation ZQViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClassesWithReuseIds:@[@"ZQDefaultCell",@"ZQEmptyCell",@"ZQCustomDefaultCell"]];
    self.tableViewAdaptor.pullRefreshEnable = YES;
    self.tableViewAdaptor.loadMoreEnable = YES;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
//    self.tableView.isShowEmpty = YES;
    [self construstData];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)refreshReload:(ZQTableViewRefreshType)pullType {
    [self.tableViewAdaptor.mjHeader endRefreshing];
    [self.tableViewAdaptor.mjFooter endRefreshing];
    self.tableViewAdaptor.loadMoreEnable = NO;
}

- (void)tableView:(UITableView *)tableView
didSelectObject:(id<CellModelBasicProtocol>)object
    atIndexPath:(NSIndexPath *)indexPath {
    
    TestVC * vc = [[TestVC alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)construstData {
    NSMutableArray * items = @[].mutableCopy;
//    YYClassIvarInfo * info  = [[YYClassIvarInfo alloc] init];
    
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"wifi_on" subTitle:@"andsinf"];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       [items addObject:item];
    }
    
    
    [items addObject:[ZQDefaultCellItem cellWithTitleStr:@"123" content:@"456"]];
    [items addObject:[ZQEmptyCellItem emptyCellItemWithBackgroundColor:[UIColor redColor]]];
    [items addObject:[ZQEmptyCellItem emptyCellItemWithBackgroundColor:[UIColor redColor]]];
    [items addObject:[ZQEmptyCellItem emptyCellItem]];
    [items addObject:[ZQDefaultCellItem cellWithTitleStr:@"123" content:@"456"]];
    [items addObject:[ZQEmptyCellItem emptyCellItemWithBackgroundColor:[UIColor yellowColor]]];
    [items addObject:[ZQDefaultCellItem cellWithTitleStr:@"123" content:@"456"]];
    [items addObject:[ZQEmptyCellItem emptyCellItem]];
    [items addObject:[ZQDefaultCellItem cellWithTitleStr:@"123" content:@"456"]];
    
    self.tableViewAdaptor.items = items;
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
